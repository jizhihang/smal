function  insertPredscores(score)
% insert prediction scores of a specific run into the specific database
% as denoted in dbConnection function
% This function uses dbBulkInsert.m function, which upload batches of
% images in each iteration, to make the procedure very fast!!
% *************Estimated time ~35min for 10k images***********
%load prediction
% finalFile = ShareData('finalFile');
filename = 'predictionScore_2.txt';%final_prediction_Approximate_Fusion

% FinalPrediction = importdata([finalFile filename]);
% score = FinalPrediction.data(:,1:2:end);
collectionFolder = 'twitter2013\';
% finalpredictions = ShareData('finalpredictions');
% load([finalpredictions, collectionFolder,'04-Sep-2013\', 'predictionScore_1']);
% score =f_efunc(:,1:end);
score = normalizeMatrix(score,1);

%========== info about this run which will be saved in the database====
% le_interconnection
description = ('run with surf and graphics concept');
%======== insert data into the database using insertRun function======
% insertRun(filename,description);


% load the images names
pathTrainTestLabelsSet = '//ITI-195/smal/matlab/results/data/';
% fid = fopen([pathTrainTestLabelsSet,collectionFolder 'IDs.txt']);
% Images = textscan(fid,'%q');
% Images = Images{1};
% 
% Images = importdata([pathTrainTestLabelsSet,collectionFolder 'IDs.txt']);
% load ([pathTrainTestLabelsSet, collectionFolder 'test5kTwitter13']);
Images = Images(testListID,:);
testListID = 1:4522;%rem = 0;
testListID = testListID';
% load ([pathTrainTestLabelsSet 'indeces']);
% Images = Images(indeces(:));
Images = Images(testListID);

%==========set variables===========
batch = 323;
nrclass=6;
% score = score(testListID,:);
for ii =1:batch:size(score,1);
    ii
    iend = ii + batch -1;
    %     Image = FinalPrediction.textdata(ii:iend,:);
    Image = Images(ii:iend,:);
    
    idimage = retrieveImage(Image);
    
    %========== retrieve data from the database using insertRun function=======
    idrun = retrieveRun(filename);
    idrun = repmat(idrun,numel(Image),1);
    % insert data into the database
    colnames={'idimage','idconcept','score','idrun'};
    fieldTypes = {'int','int','double','int'};
    values = [];
    for i= 1:nrclass
        idconcept = repmat(i,numel(Image),1);
        prediction= score(ii:iend,i);
        values =[idimage(:) idconcept prediction(:) idrun];
        % call dbBulkInsert --> Faster than fastinsert to insert data into
        % leinterconnection.imageconcepts table.
        dbBulkInsert('imageconcepts', colnames, fieldTypes, values);
        values=[];
        
    end
end
end

