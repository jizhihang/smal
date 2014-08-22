function [trainLabels,testLabels, trainListID, testListID ] = setData(folder, dir_data,current_split,splitnum,current_Trainbatch,split)
% setup Annotation set and how we should split out dataset in case of
% validation reasons

switch folder
    case 'imageclef/'
        %CLEF2012
        %---------------for validation---------------------------------------
        load ([dir_data,folder, 'allLabels']);  % Annotation set
        load ([dir_data,folder, 'trainList',num2str(current_split)]); % the number of lines to use as training set
        load ([dir_data,folder 'testList',num2str(current_split)]);   % the number of lines to use as test set
        
        if size(testListID,1)==1 ||size(trainListID,1)==1
            trainListID = trainListID';
            testListID = testListID';
        end
        trainLabels = allLabels(trainListID,:);
        testLabels =allLabels(testListID,:);
        
        %                 load ([dir_data,folder 'allLabels']);
        %                 load ([dir_data,folder 'testLabels']);
        %                 if current_Trainbatch==1
        %                     load ([dir_data,folder 'trainList15k']);
        %                     trainListID = trainListID';
        %
        %                 else
        %                     load ([dir_data,folder,splitnum,split, 'trainList',num2str(current_split)]);
        %                     trainListID = trainListID';
        %                 end
        %                 load ([dir_data,folder 'testList15to25k']);
        %
        %                 trainLabels = allLabels(trainListID,:);
        %
        
    case 'mir-flickr/'
        %MIR-FLICKR
        load ([dir_data,folder 'flickrPOTlabelslikeCLEF']);
        allLabels=labels; clear labels;
        if current_Trainbatch==5
            load ([dir_data,folder 'trainList15k']);
            trainListID = trainListID';
        else
            load ([dir_data,folder,splitnum,split, 'trainList',num2str(current_split)]);
            trainListID = trainListID';
        end
        load ([dir_data,folder 'testList15to25k']);
        
        trainLabels = allLabels(trainListID,:);
        testLabels =allLabels(testListID,:);
    case 'nuswide/'
        %NUS-Wide
        load ([dir_data,folder, 'trainLabels']);
        load ([dir_data,folder 'testLabels']);
        if current_Trainbatch==6
            load ([dir_data,folder 'trainList']);
        else
            load ([dir_data,folder,splitnum,split, 'trainList',num2str(current_split)]);
            
        end
        load ([dir_data,folder 'testList']);
        
        if size(testListID,1)==1 ||size(trainListID,1)==1
            trainListID = trainListID';
            testListID = testListID';
        end
        
        trainLabels  = trainLabels(trainListID,:);
    case 'yahoo/'
        %yahoo gc
        load ([dir_data,folder 'trainLabels(full)']);
        load ([dir_data,folder 'testLabels(full)']);
        
        if current_Trainbatch==7
            trainListID = 1:1500000;
            trainListID = trainListID';
        else
            load ([dir_data,folder,splitnum,split, 'trainList',num2str(current_split)]);
            
        end
        
        
        testListID = 1500001:2000000;
        testListID = testListID';
        
        trainLabels = trainLabels(trainListID,:);
        
    case 'flickr2013/'
        %flickr2013
        %         labels = dlmread([dir_data,folder,'annotation.txt'],'',0,1);
        load ([dir_data,folder, 'labels13new']);  % Annotation set
        load ([dir_data,folder, 'trainList',num2str(current_split)]); % the number of lines to use as training set
        load ([dir_data,folder 'testList',num2str(current_split)]);   % the number of lines to use as test set
        
        trainLabels = labels(trainListID,:);
        testLabels =labels(testListID,:);
    case 'twitter2013/'
        %twitter2013
        %         labels = dlmread([dir_data,folder,'annotation.txt'],'',0,1);
        %         load([dir_data,folder,'old Groundtruth/','labelsv1']);
        %         load ([dir_data,folder,'old Groundtruth/', 'trainList',num2str(current_split),'v1']); % the number of lines to use as training set
        %         load ([dir_data,folder,'old Groundtruth/', 'testList',num2str(current_split),'v1']);   % the number of lines to use as test set
        %
        %         trainLabels = labels(trainListID,:);
        %         testLabels =labels(testListID,:);
        
        
        load([dir_data,folder,'trainLabels']);
        load([dir_data,folder,'testLabels']);
        load ([dir_data,folder, 'trainListID']); % the number of lines to use as training set
        load ([dir_data,folder,'testListID']);   % the number of lines to use as test set
        
end
if size(testListID,1)==1 ||size(trainListID,1)==1
    trainListID = trainListID';
    testListID = testListID';
end
end



