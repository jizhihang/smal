function  PerformClustering
% performs multiple classifiers. Constructs the uu eigenvectors and apply
% k-means clustering to define in how many clusters a class is splited.
% Finally, trains a linear SVM or smooth function to extract the prediction
% scores of unlabelled data and we choose to get the scores having max or
% mean values. 


dir_data = '../results/data/';
dir_features = '../results/features/';
collectionFolder = 'imageclef/';

%load data 
load([dir_features,collectionFolder,'sift_pca512']); % v vector
load([dir_data,collectionFolder,'allLabels']); % allLabels
tic
[dd,uu] = eigenfunctions(v,0.2,500,1);

% uncomment if you want to perform l2-normalization  
% for vec=1:size(uu,1)
%     uu(vec,:) = uu(vec,:)./norm(uu(vec,:),2);
% end

uutrain = uu(1:size(allLabels,1),:);
uutest = uu(10001:end,:);
toc
clusters =3; % number of clusters
start = tic;
for i=1:size(allLabels,2)
    % find the positive indeces in each class
    posIndeces=find(allLabels(:,i)==1);
    datapos = uutrain(posIndeces,:);
    
    %perform k-means in positive samples
    clustIndeces = kmeans(datapos,clusters);
    
    %     matlabpool open 5
    tic
    for x = 1:clusters
        % find indeces belongin in x-cluster
        clustIndperClass=find(clustIndeces==x);
        %get the samples belonging to x-cluster
        dataposperClust = uutrain(clustIndperClass,:);
        
        % find positive indeces belonging in this cluster
        indeces = posIndeces(clustIndperClass);
        % get positive samples of x-cluster in i-class
        vpos  = uutrain(posIndeces(clustIndperClass),:);
        
        % get labels of positive training samples of x-cluster in i-class
        posLabels = allLabels(posIndeces(clustIndperClass),i);
        
        % find the negative indeces of x-cluster in i-class
        trainIndeces = 1:size(allLabels,1); trainIndeces = trainIndeces';
        indNeg = setdiff(trainIndeces,posIndeces);
        % get negative samples of x-cluster in i-class
        vneg = uutrain(indNeg,:);
        % get labels of negative training samples of x-cluster in i-class
        negLabels = allLabels(indNeg,i);
        
        vClust = [vpos;vneg];
        labelsClust = [posLabels;negLabels];
        % concatenate the positive and negative training eigenvectors with
        % the test eigenvector
        vnew = [vClust;uutest];
        % train linear SVM and smooth function anf get their prediction
        % scores
        [ predscoreClust(:,x),  predscoreClustsvm(:,x)]= computePredScores( vnew,0.2,500,labelsClust,size(vClust,1),dd);
    end
    %     matlabpool close
    toc
        
    predscore(:,i)=max(predscoreClust,[],2);
    predscoresvm(:,i)=max(predscoreClustsvm,[],2);
    predscoremean(:,i)=mean(predscoreClust,2);
    predscoresvmmean(:,i)=mean(predscoreClustsvm,2);
    %     predscore(:,i) = sum(predscoreClust,2);
    
    clearvars -except predscoremean predscoresvmmean vtrain vtest v allLabels testLabels i predscore predscoresvm clusters start uutrain uutest dd
    
end
save('score','predscore');
for i=1:size(testLabels,2)
    [InterPrecisionRecall(i,:)] = Statistics(testLabels(:,i),predscore(:,i)) ;
end
avgmIAP = mean(InterPrecisionRecall(:,1))
save('miap','avgmIAP')
% save('interprec','InterPrecisionRecall(:,1)');
endtime = toc(start);
fprintf('finished at %d minutes and %f seconds\n',floor(endtime/60),rem(endtime,60));



% for x = 1:5
%     norm(:,:,x) = normalizeMatrix(predscoreClust(:,:,x),1);
% end
%
% for x = 1:10
%     tmp = norm(:,x,:);
%     tmp = tmp(:,:);
%     score(:,x) = max(tmp,[],2);
% end
%
% for i=1:size(testLabels,2)
%     [InterPrecisionRecall(i,:)] = Statistics(testLabels(:,i),score(:,i)) ;
% end
% avgmIAP = mean(InterPrecisionRecall(:,1))

end

