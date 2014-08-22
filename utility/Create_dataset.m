% create random dataset with different ratio/class


clear all;
% pathTrainTestLabelsSet = ShareData('pathTrainTestLabelsSet');
pathTrainTestLabelsSet = 'D:\lena\Codes\MyCodes\smal\smal\matlab\results\data\';
collectionFolder = 'twitter2013\';

load ([pathTrainTestLabelsSet,collectionFolder, 'labels_old']);


% labels = trainLabels;
 AllList =1:size(labels,1);

% labeledRatio declares the amount of training and validation set
% with this ratio the training set is around 10k and the rest is for the
% validation
labeledRatio = 50.0;
% find range of each class
nClasses = size(labels,2);
classRange = zeros(nClasses,2);
nr_splits = 10;
for x=1:nr_splits
    for i=1:nClasses
        [tmp,~] = find(labels(:,i)==1);
        classRange(i,:) = [min(tmp) max(tmp)];
    end
    
    % calculate number of labeled samples for each class
    trainNumClass = zeros(nClasses,1);
    for i=1:nClasses
        trainNumClass(i) = ceil(length(find(labels(:,i)==1))*labeledRatio/100);
    end
    
    % create trainID
    
    train=[];
    for i=1:nClasses
        classTrID = rand_int(classRange(i,1),classRange(i,2),trainNumClass(i),1,1,0);
        train = [train, classTrID'];
    end
    trainListID=unique(train);
    %Save trainListID
    nameTrainFile = [pathTrainTestLabelsSet,collectionFolder, 'trainList',num2str(x),'.mat'];
    save(nameTrainFile,'trainListID');
    % create testID
     testListID = setdiff(AllList,trainListID);
     test = intersect(AllList,trainListID);
    %Save testListID
    nameTestFile = [pathTrainTestLabelsSet,collectionFolder, 'testList',num2str(x),'.mat'];
    save(nameTestFile,'testListID');
end