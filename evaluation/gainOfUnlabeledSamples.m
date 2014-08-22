% With this experiment we want to measure how sensitive SMaL is if we add
% different unlabeled samples in laplacian eigenmaps construction. The number of unlabeled
% data remains the same and we choose to change the samples to concatenate them with the training
% set.
clear;clc;
%===================================Set Parameters=========================
k = 500;                            % number of eigenvectors
sigma = 0.2;                        % controls affinity in graph Laplacian, how strong connected the edges are
num_experiment=1;                   % holds the number of experiment to be saved
nr_splits = 1;                      % in how many splits to splits the training dataset. for Validation reasons.
collectionFolder = 'yahoo/';   % give a name of a folder to save experiments. just a convention
splitnum = 50;
% splitnum = [1,5,10,20,50,100,150]; % yahoo
split = 'k/';
experimentsdate = date;

% =========================SetPaths========================================
dir_features ='./results/features/';
% dir_features ='//ITI-195/smal/matlab/results/features/';
% dir_data = './results/data/';
dir_data = '//ITI-195/smal/matlab/results/data/';
dir_predictions ='./results/predictions/';

% ==========================Set Features===================================
nameDescriptors  = {{'siftv'}};
numDescriptors = length(nameDescriptors);


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
    
    SplitStart = tic;  
    vOrdered = [];      % just a convention to be sure that in each split the order of indeces will be the appropriate
    
    %==========Retrieve the list of images and the groundtruth=========
    [trainLabels,testLabels, trainListID, testListID ] = setData(collectionFolder, dir_data,1,num2str(splitnum),1,split);
    
    vOrdered = v(trainListID,:);
   
    Allset = [1:1500000,1]';
    restSet = setdiff(Allset,trainListID);
    vRest = v(restSet,:);
    % number of unlabeled data
    numOfIndepedentSet = 100000; 
    mIAP = zeros(10,1);
    for cc = 1:10
        vRestSplit = datasample(vRest,numOfIndepedentSet,1);
        vOrdered = [vOrdered;vRestSplit];
        vOrdered = [vOrdered;v(testListID,:)];
        
        predictionsDir = [dir_predictions,collectionFolder,'SensitivityRatioOpt/','numOfIndepedentSet',num2str(cc),'/',experimentsdate];
       
        if (exist(predictionsDir,'dir')==0)
            mkdir (predictionsDir)
        end
        %------------------------------------------------------------------
        % ======Find bins, g and eigenvcalues in train set=================
        trainnum = size(trainLabels,1)+numOfIndepedentSet;
        for dim=1:size(vOrdered,2)
            [bins(:,dim),g(:,:,dim),lambdas(:,dim),pp]=numericalEigenFunctions(vOrdered(1:trainnum,dim),sigma);
        end
        % =================Find eigenvectors in train set==================
        [ddtrain,uutrain,ii,jj] = eigenfunctionsIncremental(vOrdered(1:trainnum,:),g,lambdas,k,bins);
        
        % ======Incremental approach in test set in batches================
        vtest = vOrdered(trainnum+1:end,:);     % choose the test set from feature space
        indx = 1;
        uutest = [];                            % test eigenvectors
        numPerBatch = 1000;                     % the number of batches to split the test set
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
                    vtmp = vtest(indx:indx+999,:);
                end
            else
                vtmp = vtest(indx:indx+999,:);
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
        
        
        % use smooth function to train the model and extract the prediction
        % score
        numOflamda = 500;                       % the weight of known samples
        testID=(trainnum+1:size(uu,1))';
        score = smoothFunction( numOflamda, uu,ddtrain, trainLabels,testID);
        
        save([predictionsDir, '/predictionScore_', num2str(num_experiment)],'score');
        
        %----------------------------------------------------------------------
        % u can normalize the score
        % ex. in range [-1 1]
        % score = normalizeMatrix(score,4);
        
        predictionEnd =toc(predictionStart);
        fprintf('train SVM computed at %d minutes and %f seconds\n',floor(predictionEnd/60),rem(predictionEnd,60));
        
        %========================Compute the evaluation metrics============
        AP  = zeros(size(trainLabels,2),1);
        InterPrecisionRecall = zeros(size(trainLabels,2),1);
        precistionStart=tic;
        %                 for j=1:size(testLabels,2)
        %                     [AP(j),InterPrecisionRecall(j,:),~] = statistics(testLabels(:,j),score(:,j)) ;
        %                 end
        for j=1:size(testLabels,2)
            [InterPrecisionRecall(j,:)] = statistics(testLabels(:,j),score(:,j)) ;
        end
        
        avgmIAP = mean(InterPrecisionRecall(:,1));
        mIAP(cc) =avgmIAP;
       
        SplitEnd =toc(SplitStart);
        fprintf('procedure computed at %d minutes and %f seconds\n',floor(SplitEnd/60),rem(SplitEnd,60));
        save([predictionsDir, '\InterPrecisionRecallTable_','Exp_', num2str(num_experiment)],'InterPrecisionRecall');
        num_experiment= num_experiment+1;
    end
    fprintf('MiAP %6.4f \n',avgmIAP);
    save([predictionsDir, '/mIAP'],'mIAP');
    meanMIAP = mean(mIAP);
    stdMIAP = std(mIAP);
    writingArray = [mIAP;meanMIAP;stdMIAP];
    num_dig = 4;
    writingArray = round(writingArray*(10^num_dig))/(10^num_dig);
    xlswrite([predictionsDir,'/',cell2mat(nameDescriptors{current_desc}),'.xls'],writingArray);
end

