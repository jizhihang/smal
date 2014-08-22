% Find the prediction score from Test set and prepare the final file.
% gsfDemo mostly used to for training and validation reasons. However it
% can be used to predict the test set. 
% this file is OPTIONAL.
% Required function : normalizeMatrix,SocioDim, linearsvm , dlmcell
% Required toolboxes: vlfeat, liblinear, libsvm
% Output: The final prediction file saved in ../results/predictions/Final Submited Predictions folder and the final prediction score saved in the same folder.

clear all;clc;
tic

% set paths
dir_features ='./results/features/';
dir_data = './results/data/';
dir_predictions ='./results/predictions/';
dir_socialDimensions ='./results/socialDimensions/';
collectionFolder = 'imageclef/';

% load data 
%train
load ([dir_data,collectionFolder 'trainList15k']);
trainListID = trainListID';

% test
load ([dir_data,collectionFolder 'testList15to25k']);
%load allLabels
load ([dir_data,collectionFolder 'allLabels']);


Feature_Concepts = ShareData('Feature_Concepts');
nr_set =size(testListID,1); % the number of test dataset
nr_class = size(allLabels,2); % the number of concepts
nameDescriptors = {{'vlad_sift_densesampling_sift'}};


numDescriptors = length(nameDescriptors);
% Compute Prediction Score
disp('Compute predscore');
C = 5; % the C parameter in SVM Classifier
predscore = [];
for i=1:nr_class
    Xext = [];
    disp(i);
    for k=1:numDescriptors
        Descname = char(nameDescriptors{k});
        bestparName = ['mIAP_results_Feature_Concept_',Descname];
        load ([dir_predictions,collectionFolder bestparName]);
        Soc_Dim = features_iAP(i,1);
        TopN = features_iAP(i,2);
        vName = ['V_Top_',num2str(Soc_Dim),'_','TopN_',num2str(TopN),'_', Descname];
        load ([dir_socialDimensions,collectionFolder, vName]);
        Xext = [Xext V];
    end
    disp('compute linear svm');
    model  = linearsvm(Xext(trainListID,:), allLabels(trainListID,i), C);
    testPrediction    = Xext(testListID, :)*model.W + repmat(model.bias, length(testListID), 1);
    predscore = [predscore testPrediction];
end
nameSaveExperiments = ['final_predScore_','600'];
save([dir_predictions,collectionFolder, nameSaveExperiments], 'predscore');

% extract txt file
fid = fopen([dir_data,collectionFolder, 'imageclef_Image_ID10K.txt']);
Image = textscan(fid,'%q');
Image = Image{1};

filename = ([dir_predictions,collectionFolder, 'final_prediction','.txt']);
fout=fopen(filename,'w');

% [0 1]
normalizedpred=normalizeMatrix(predscore,1);

for i=1:size(Image,1)
    fprintf(fout,'%s ',Image{i});
%     pred = predscore(i,:)>thresholdTable;
    for c=1:94
        fprintf(fout,'%f %d ',normalizedpred(i,c), predscore (:,c));
    end
    
    fprintf(fout,'\n');
end
fclose all;

toc