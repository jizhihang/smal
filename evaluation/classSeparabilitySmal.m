% A seoparability measure between classes, based on
% between and within distance. We use the following measure function
%  jd = trace(sb)/trace(sw);
clearvars -except v;clc;
% initialize variables
num_experiment=1;                   % holds the number of experiment to be saved
nr_splits = 10;                      % in how many splits to splits the training dataset. for Validation reasons.
collectionFolder = 'yahoo/';     % give a name of a folder to save experiments. just a convention
splitnum = [1,5,10,20,50,100,150]; % yahoo
split = 'k/';
experimentsdate = date;
% =========================SetPaths========================================
dir_data = '//ITI-195/smal/matlab/results/data/';
dir_predictions ='./results/classSeparability/smal/';
for current_Trainbatch =1:length(splitnum)
    
    
    predictionsDir = [dir_predictions,num2str(splitnum(current_Trainbatch)),split,'/',experimentsdate];
    if (exist(predictionsDir,'dir')==0)
        mkdir (predictionsDir)
    end
    addpath(dir_predictions);
    addpath(predictionsDir);
    
    mer = zeros(nr_splits,1);
    SplitsStart = tic;
    
    jd = zeros(nr_splits,1);
    for current_split=1:nr_splits
        SplitStart = tic;
        
        %==========Retrieve the list of images and the groundtruth=========
        [trainLabels,~, trainListID, testListID ] = setData(collectionFolder, dir_data,current_split,num2str(splitnum(current_Trainbatch)),current_Trainbatch,split);
        trainnum = size(trainListID,1);
        testnum = size(testListID,1);
        dims = size(v,2);
        vsplit = zeros(trainnum+testnum,dims);
        vsplit(1:trainnum,:) = v(trainListID,:);
        vsplit(trainnum+1:end,:) = v(testListID,:);
        
        nr_classes = size(trainLabels,2);
        trainLabels(trainLabels==0) = -1;
        
        [~,uu] = eigenfunctions(vsplit,0.2,500);
        
        uutrain = uu(1:trainnum,:);

        %% measure the separability of classes
        feature = uutrain';
        dims2 = size(uu,2);
        mu1 = zeros(dims2,nr_classes);
        
        % overall mean
        % mu = sum(mu1,2)./10; % mu =(mu1+mu2+mu3)./3
        mu=mean(feature,2);
        
        sb=zeros(dims2,dims2);
        % sw=zeros(ndims,ndims);
        sw=zeros(dims2,dims2);
        for i= 1:nr_classes
            ind = trainLabels(:,i)==1;
            
            % computing the class means
            x1 = feature(:,ind);
            mu1(:,i) = mean(x1,2);
     
            %within-class scatter matrix
            %class covariance matrices
            xi=x1-repmat( mu1(:,i),1,sum(ind)); %Xi-MeanXi
            sw=sw+(xi*xi');
            
            %number of samples of each class
            n1 = size(x1,2);
            % between-class scatter matrix
            sb1 = n1.*(mu1(:,i)-mu)*(mu1(:,i)-mu)';
            sb =sb+sb1; % sb = sb1+sb2+sb3
        end
        
        jd(current_split) = trace(sb)/trace(sw);
        
        save([predictionsDir, '\sb', num2str(num_experiment),'split_',num2str(current_split)],'sb');
        save([predictionsDir, '\sw', num2str(num_experiment),'split_',num2str(current_split)],'sw');
        num_experiment= num_experiment+1;
        SplitEnd =toc(SplitStart);
        fprintf('one split computed at %d minutes and %f seconds\n',floor(SplitEnd/60),rem(SplitEnd,60));
    end
    SplitsEnd =toc(SplitsStart);
    fprintf('all splits computed at %d minutes and %f seconds\n',floor(SplitsEnd/60),rem(SplitsEnd,60));
    save([predictionsDir, '/Jd'],'jd');
    meanJd = mean(jd);
    stdJd = std(jd);
    writingArray = [jd;meanJd;stdJd];
    num_dig = 4;
    writingArray = round(writingArray*(10^num_dig))/(10^num_dig);
    xlswrite([predictionsDir,'/','.xls'],writingArray);
    
end


