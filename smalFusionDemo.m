% Demo for SMaL (Scalable Manifold Learning) framework on top
% of ALE for eigenfunction method for computing approximate
% eigenvectors of graph Laplacian.
%
% This demo find the k-approximate eigenvectors for every feature
% and concatenate all the eigenvectors. We call this method as "fusion of Laplacian Eigenmaps"
% finally runs three different variant
% of learning model methods:
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
% It is tested in ImageCLEF2012, ACM Yahoo Grand Challenge 2013 competition and MediaEVal 2013
% competition, SED task Challenge 2.
%
% SmaL uses SIFT/RGB-SIFT VLAD feature aggregation method (and with spatial pyramids)
% and PCA for image representation.
% The implementation of SmaL approach is general and can be applied to any data.
%
% If you do use this code in your paper, please cite our paper. For your
% convenience, here is the bibtex:
%
% @conference{smal_wiamis_13,
%  author = {Mantziou, E. and Papadopoulos, S. and Kompatsiaris, I.},
%  booktitle = {WIAMIS},
%  title = {Large-scale Semi-supervised Learning by Approximate Laplacian Eigenmaps, {VLAD} and Pyramids},
%  year = {2013}
%  }
%
% Version 1.0. Eleni Mantziou. 1/17/13.

clear;clc;
%===================================Set Parameters=========================
k = 500;                            % number of eigenvectors
sigma = 0.2;                        % controls affinity in graph Laplacian, how strong connected the edges are
num_experiment=1;                   % holds the number of experiment to be saved
nr_splits = 1;                     % in how many splits to splits the training dataset. for Validation reasons.
collectionFolder = 'imageclef/';   % give a name of a folder to save experiments. just a convention
method = {'linear','smooth'};     % the training method (linear, rbf and smooth)
numMethods = numel(method);
splitnum = [1,5,7.5,10,15];
split = 'k/';
experimentsdate = date;
% =========================SetPaths========================================
dir_features ='./results/features/';
dir_data = './results/data/';
dir_predictions ='./results/predictions/';
dir_images = './results/images/';

% ==========================Set Features===================================
nameDescriptors  = {{'gist_25K'},{'plsaTopTags_25K'},{'siftpca512'},{'surf512'}};

numDescriptors = length(nameDescriptors);
for current_method =1:numMethods
    for current_Trainbatch =1:length(splitnum)
        %======================make dir to save experiments================
        predictionsDir = [dir_predictions,collectionFolder,'fusion/',num2str(splitnum(current_Trainbatch)),split,method{current_method},'/',experimentsdate];
        
        if (exist(predictionsDir,'dir')==0)
            mkdir (predictionsDir)
        end
        addpath(dir_predictions);
        addpath(predictionsDir);
        mAP = zeros(nr_splits,1);
        mIAP = zeros(nr_splits,1);
        for current_split=1:nr_splits
            SplitStart = tic;
            uuext = [];
            dd = zeros(k*numDescriptors,k*numDescriptors);
            ddindx=1;
            [trainLabels,testLabels, trainListID, testListID ] = setData(collectionFolder, dir_data,current_split,num2str(splitnum(current_Trainbatch)),current_Trainbatch,split);
            
            for current_desc=1:numDescriptors
                disp(nameDescriptors{current_desc});
                if current_desc==1 ||current_desc==2
                    featureFile    = [ dir_features,collectionFolder,cell2mat(nameDescriptors{current_desc}),'.txt'];
                    v = dlmread(featureFile,'',0,1);    % the feature vector
                else
                    featureFile    = [ dir_features,collectionFolder,cell2mat(nameDescriptors{current_desc})];
                    load(featureFile);
                end
                
                %----------------------------------------------------------------------
                % alternatively you can read txt files. A txt file can
                % be in form of "id vec1 vec2...."
                
                % featureFile    = [dir_features,collectionFolder,cell2mat(nameDescriptors{i}),'.txt'];
                % v = dlmread(featureFile,'',0,1);    % the feature vector
                
                %----------------------------------------------------------------------
                % alternatively if the features are in binary format you can use
                % the utility/vec_read.m function
                
                %==========Retrieve the list of images and the groundtruth=========
                
                vsplit = v(trainListID,:);
                vsplit = [vsplit;v(testListID,:)];
                
                
                if current_method==1
                
                    if current_desc~=2
                        for i=1:size(vsplit,1)
                            vsplit(i,:) = vsplit(i,:)./norm(vsplit(i,:),2);
                        end
                    end
                end
                %==compute approximate eigenvectors using eigenfunction approach===
                eigenfunctionStart =tic;
                % uu                        : the eigenvectors
                % dd                        : the eigenvalues
                [ddtrain,uu] = eigenfunctions(vsplit,sigma,k);

                if current_method==2
                    
                    if current_desc~=2
                        for i=1:size(uu,1)
                            uu(i,:) = uu(i,:)./norm(uu(i,:),1);
                        end
                    end
                end

                uuext = [uuext uu];
                
                dd(ddindx:size(uuext,2),ddindx:size(uuext,2))=ddtrain;
                ddindx = ddindx+k;
                eigenfunctionEnd= toc(eigenfunctionStart);
                vsplit = [];
                fprintf('Eigenvectors computed at %d minutes and %f seconds\n',floor(eigenfunctionEnd/60),rem(eigenfunctionEnd,60));
            end
            trainID = (1:size(trainListID,1))';
            testID=(size(trainListID,1)+1:size(uuext,1))';
            %==========================train model===============================
            fprintf('Computing Prediction Score\n');
            predictionStart = tic;
            
            switch  method{current_method}
                case 'linear'
                    % use linear svm to train the model and extract the prediction
                    % score
                    % use of liblinear library
                    C = 5; % the C parameter in SVM Classifier
                    score = SocioDim(uuext, trainLabels, trainID, testID,C);
                case 'rbf'
                    % use non-linear svm to train the model and extract the prediction
                    % score
                    % use of libsvm library
                    param = ('-c 5 -t 2 -g 0.0008 -q 1'); % the parameter in RBF SVM Classifier
                    score = rbf_svm_parameters(uuext, trainLabels, testLabels,trainID, testID, param);
                case 'smooth'
                    % use smooth function to train the model and extract the prediction
                    % score
                    numOflamda = 500;                       % the weight of known samples
                    score = smoothFunction( numOflamda,uuext,dd, trainLabels,testID);
            end
            
            %----------------------------------------------------------------------
            % u can normalize the score
            % ex. in range [-1 1]
            % score = normalizeMatrix(score,4);
            
            
%             save([predictionsDir, '/predictionScore_', num2str(num_experiment),'split_',num2str(current_split)],'score');
            
            predictionEnd =toc(predictionStart);
            fprintf('train SVM computed at %d minutes and %f seconds\n',floor(predictionEnd/60),rem(predictionEnd,60));
            
            %========================Compute the evaluation metrics============
            
            
            AP  = zeros(size(trainLabels,2),1);
            InterPrecisionRecall = zeros(size(trainLabels,2),1);
            precistionStart=tic;
%             for j=1:size(testLabels,2)
%                 [AP(j),InterPrecisionRecall(j,:),~] = statistics(testLabels(:,j),score(:,j)) ;
%             end
            
            for j=1:size(testLabels,2)
                [InterPrecisionRecall(j,:)] = statistics(testLabels(:,j),score(:,j)) ;
            end
            
            %----------------------------------------------------------------------
            % uncomment if you want to compute more metrics
            % predictionLabels: according to prediction scores compute the
            % predictionLabels
            % groundtuthLabels: according to testLabels compute the
            % groundtuthLabels
            % [fmeasure, precision, recall ]= compute_precision_recall( groundtuthLabels,predictionLabels );
            
            
            avgmAP = mean(AP,1);
            mAP(current_split) =avgmAP;
            avgmIAP = mean(InterPrecisionRecall(:,1));
            mIAP(current_split) =avgmIAP;

%             save([predictionsDir, '\InterPrecisionRecallTable_','Exp_', num2str(num_experiment),'split_',num2str(current_split)],'InterPrecisionRecall');
            SplitEnd =toc(SplitStart);
            fprintf('procedure computed at %d minutes and %f seconds\n',floor(SplitEnd/60),rem(SplitEnd,60));
            num_experiment= num_experiment+1;
        end
        fprintf('MiAP %6.4f \n',avgmIAP);
        fprintf('MAP %6.4f \n',avgmAP);
        save([predictionsDir, '/mIAP'],'mIAP');
        save([predictionsDir, '/mAP'],'mAP');
        meanMIAP = mean(mIAP);
        stdMIAP = std(mIAP);
        writingArray = [mIAP;meanMIAP;stdMIAP];
        num_dig = 4;
        writingArray = round(writingArray*(10^num_dig))/(10^num_dig);
        xlswrite([predictionsDir,'/',cell2mat(nameDescriptors{current_desc}),'.xls'],writingArray);
    end
end