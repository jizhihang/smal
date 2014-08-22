% Implementation of Incremental Learning of k-approximate eigenvectors.
% Demo computes the eigenfunctions and eigenvalues from training data
% and compute the training eigenvector. From these eigenvectors, demo
% computes the eigenfunctions and eigenvectors of test data by
% interpolating them.
% For efficient reasons, demo compute the eigenvectos from test data
% in batches (1000 items/batch).
%
% Demo also runs three different variant of learning model methods:
% 1. Linear SVM.
% 2. RBF SVM.
% 3. Smooth Function
%
% The code is ready to run for flickr2013 (included ulr file) and twitter2013 datasets.
% You can download the datasets from
% 1. flickr2013: http://www.socialsensor.eu/datasets/mm-concept-detection-dataset-2013/mm-concept-detection-datasets.zip
% 2. twitter2013: http://www.socialsensor.eu/datasets/mm-concept-detection-dataset-2013/mm-concept-detection-twitter2013-images.zip
%      password: socialsensor
%
% It is tested in ACM Yahoo Grand Challenge 2013 competition
%
% SmaL uses SIFT/RGB-SIFT VLAD feature aggregation method (and with spatial pyramids)
% and PCA for image representation.
% The implementation of SmaL approach is general and can be applied to any data.
%
% Version 1.0. Eleni Mantziou. 6/1/13.

clear;clc;
%===================================Set Parameters=========================
k = 500;                            % number of eigenvectors
sigma = 0.2;                        % controls affinity in graph Laplacian, how strong connected the edges are
num_experiment=1;                   % holds the number of experiment to be saved
nr_splits = 1;                      % in how many splits to splits the training dataset. for Validation reasons.
collectionFolder = 'twitter2013/';   % give a name of a folder to save experiments. just a convention
method = {'linear'};                  % the training method (linear, rbf and smooth)
numMethods = numel(method);% splitnum = [1,5,7.5,10,15];
splitnum = [1,5,7.5,10,15];
split = 'k/';
experimentsdate = date;

% =========================SetPaths========================================
dir_features ='./results/features/';
dir_data = './results/data/';
dir_predictions ='./results/predictions/';

% ==========================Set Features===================================
nameDescriptors  = {{'surfpca1024'}};
numDescriptors = length(nameDescriptors);
for current_method =1:numMethods
    for current_desc=1:numDescriptors
        %==========load descriptors from chunks==========
        % ch=load([pathTrainTestLabelsSet,collectionFolder,'chunks_gray_sift.mat']);
        
        % v=[];
        % for i=1:numel(ch.chunks)
        %     filename = [dir_features,collectionFolder,ch.chunks{i}];
        %     tmpv = dlmread(filename,'',0,1);
        %     disp(['Reading training row filename ' filename]);
        %     v=[v;tmpv];
        % end
        
        disp(nameDescriptors{current_desc});
        featureFile    = [ dir_features,collectionFolder,cell2mat(nameDescriptors{current_desc})];
        load(featureFile);                    % v: feature vector
        %----------------------------------------------------------------------
        % alternatively you can read txt files. A txt file can
        % be in form of "id vec1 vec2...."
        
        % featureFile    = [dir_features,collectionFolder,cell2mat(nameDescriptors{i}),'.txt'];
        % v = dlmread(featureFile,'',0,1);    % the feature vector
        
        %----------------------------------------------------------------------
        % alternatively if the features are in binary format you can use
        % the utility/vec_read.m function
        for current_Trainbatch =1:length(splitnum)
            %======================make dir to save experiments================
            predictionsDir = [dir_predictions,collectionFolder,num2str(splitnum(current_Trainbatch)),split,'Incremental',method{current_method},'/',cell2mat(nameDescriptors{current_desc}),'/',experimentsdate];
            if (exist(predictionsDir,'dir')==0)
                mkdir (predictionsDir)
            end
            addpath(dir_predictions);
            addpath(predictionsDir);
            
            mAP = zeros(nr_splits,1);
            mIAP = zeros(nr_splits,1);
            for current_split=1:nr_splits
                SplitStart = tic;
                
                vOrdered = [];      % just a convention to be sure that in each split the order of indeces will be the appropriate
                
                %==========Retrieve the list of images and the groundtruth=========
                [trainLabels,testLabels, trainListID, testListID ] = setData(collectionFolder, dir_data,current_split,num2str(splitnum(current_Trainbatch)),current_Trainbatch,split);

                vOrdered = v(trainListID,:);
                vOrdered = [vOrdered;v(testListID,:)];
                
                %------------------------------------------------------------------
                % ======Find bins, g and eigenvcalues in train set=================
                trainnum = size(trainLabels,1);
                for dim=1:size(vOrdered,2)
                    [bins(:,dim),g(:,:,dim),lambdas(:,dim),pp]=numericalEigenFunctions(vOrdered(1:trainnum,dim),sigma);
                end
                % =================Find eigenvectors in train set==================
                [ddtrain,uutrain,ii,jj] = eigenfunctionsIncremental(vOrdered(1:trainnum,:),g,lambdas,k,bins);
                
                % ======Incremental approach in test set in batches================
                vtest = vOrdered(trainnum+1:end,:);     % choose the test set from feature space
                indx = 1;
                uutest = [];                            % test eigenvectors
                numPerBatch = 100;                     % the number of batches to split the test set
                batches = round(size(vtest,1)/numPerBatch);    % the number of loops
                %============== Interpolation on test batches======================
                BatchesStart = tic;
                fprintf('start batches');
                for i = 1:batches
                    if mod(size(vtest,1),numPerBatch)~=0    % if the dataset does not diverse it with the numPerBatch
                        % we have to compute the reamining items
                        if i==batches
                            res = (size(vtest,1)- ((i-1)* numPerBatch )-1);    % the remaining items
                            vtmp = vtest(indx:indx+res,:);
                        else
                            vtmp = vtest(indx:indx+99,:);
                        end
                    else
                        vtmp = vtest(indx:indx+99,:);
                    end
                    
                    LOWER = 2.5/100; %% clip lowest CLIP_MARIN percent
                    UPPER = 1-LOWER; % clip symmetrically
                    for a=1:size(vtmp,2)
                        [clip_lower(a),clip_upper(a)] = percentile(vtmp(:,a),LOWER,UPPER);
                        q = vtmp(:,a)<clip_lower(a);
                        % set all values below threshold to be constant
                        vtmp(q,a) = clip_lower(a);
                        q2 = vtmp(:,a)>clip_upper(a);
                        % set all values above threshold to be constant
                        vtmp(q2,a) = clip_upper(a);
                    end
                    for a=1:k
                        bins_out(:,a) = bins(:,jj(a));
                        uu1(:,a) = g(:,ii(a),jj(a));
                        uu2(:,a) = interp1(bins_out(:,a),uu1(:,a),vtmp(:,jj(a)),'linear','extrap');
                    end
                    suu2 = sqrt(sum(uu2.^2));
                    uu2 = uu2 ./ (ones(size(vtmp,1),1) * suu2);
                    
                    indx=indx+numPerBatch;
                    uutest = [uutest;uu2];
                    clear uu2
                end
                
                BatchesEnd =toc(BatchesStart);
                fprintf('test batches computed at %d minutes and %f seconds\n',floor(BatchesEnd/60),rem(BatchesEnd,60));
                
                uu  = [uutrain;uutest];
                
                
                %==========================train model===============================
                fprintf('Computing Prediction Score\n');
                predictionStart = tic;
                
                switch method{current_method}
                    case 'linear'
                        % use linear svm to train the model and extract the prediction
                        % score
                        % use of liblinear library
                        C = 5;                                 % the C parameter in SVM Classifier
                        trainID = (1:trainnum)';
                        testID=(trainnum+1:size(uu,1))';
                        score = SocioDim(uu, trainLabels, trainID, testID,C);
                    case 'rbf'
                        % use non-linear svm to train the model and extract the prediction
                        % score
                        % use of libsvm library
                        param = ('-c 5 -t 2 -g 0.0008 -q 1');   % the parameter in RBF SVM Classifier
                        trainID = (1:trainnum)';
                        testID=(trainnum+1:size(uu,1))';
                        score = rbf_svm_parameters(uu, trainLabels, testLabels,trainListID, testListID, param);
                    case 'smooth'
                        % use smooth function to train the model and extract the prediction
                        % score
                        numOflamda = 500;                       % the weight of known samples
                        testID=(trainnum+1:size(uu,1))';
                        score = smoothFunction( numOflamda, uu,ddtrain, trainLabels,testID);
                end
                
                %----------------------------------------------------------------------
                % u can normalize the score
                % ex. in range [-1 1]
                % score = normalizeMatrix(score,4);
                
                
                
                save([predictionsDir, '\predictionScore_', num2str(num_experiment),'split_',num2str(current_split)],'score');
                predictionEnd =toc(predictionStart);
                fprintf('train SVM computed at %d minutes and %f seconds\n',floor(predictionEnd/60),rem(predictionEnd,60));
                
                %========================Compute the evaluation metrics============
                AP  = zeros(size(trainLabels,2),1);
                InterPrecisionRecall = zeros(size(trainLabels,2),1);
                precistionStart=tic;
                for j=1:size(testLabels,2)
                    [AP(j),InterPrecisionRecall(j,:)] = statistics(testLabels(:,j),score(:,j)) ;
                end
                
                %----------------------------------------------------------------------
                % uncomment if you want to compute more metrics
                % predictionLabels: according to prediction scores compute the
                % predictionLabels
                % groundtuthLabels: according to testLabels compute the
                % groundtuthLabels
                % [fmeasure, precision, recall ]= compute_precision_recall( groundtuthLabels,predictionLabels );
                
                %             normscore = normalizeMatrix(score,1); % p(class(i)|f)
                %
                %             [maxprediction predictionLabels] = max(normscore,[],2);
                %             groundtruthLabels = setGroundtruthLabels(testLabels);
                %
                %             [fmeasure, precision, recall ]= compute_precision_recall( groundtuthLabels,predictionLabels );
                %             metrics = [fmeasure' precision' recall'];
                %
                
                avgmAP = mean(AP,1);
                mAP(current_split) =avgmAP;
                avgmIAP = mean(InterPrecisionRecall(:,1));
                mIAP(current_split) =avgmIAP;
                
                num_experiment= num_experiment+1;
                SplitEnd =toc(SplitStart);
                fprintf('procedure computed at %d minutes and %f seconds\n',floor(SplitEnd/60),rem(SplitEnd,60));
                save([predictionsDir, '\InterPrecisionRecallTable_','Exp_', num2str(num_experiment),'split_',num2str(current_split)],'InterPrecisionRecall');
%                 save([predictionsDir, '\prec_recall','Exp_', num2str(num_experiment),'split_',num2str(current_split)],'metrics');
                num_experiment= num_experiment+1;
            end
            fprintf('MiAP %6.4f \n',avgmIAP);
            fprintf('MAP %6.4f \n',avgmAP);
            save([predictionsDir, '\mIAP',cell2mat(nameDescriptors{current_desc})],'mIAP');
            save([predictionsDir, '\mAP',cell2mat(nameDescriptors{current_desc})],'mAP');
            meanMIAP = mean(mIAP);
            stdMIAP = std(mIAP);
            writingArray = [mIAP;meanMIAP;stdMIAP];
            num_dig = 4;
            writingArray = round(writingArray*(10^num_dig))/(10^num_dig);
            xlswrite([predictionsDir,'/',cell2mat(nameDescriptors{current_desc}),'.xls'],writingArray);
        end
    end
end



