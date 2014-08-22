function  [ldafeattrain,ldafeattest]=testLDA
% An example using LDA

dir_features ='./results/features/';
dir_data = './results/data/';
collectionFolder = 'imageclef/';
load([dir_features,collectionFolder,'sift_pca512']);
load([dir_data,collectionFolder,'allLabels']);
[dd,uu] = eigenfunctions(v,0.2,500);

uutrain = uu(trainListID,:); uutrain = uutrain';
uutest = uu(testListID,:); uutest = uutest';

nclasses = size(allLabels,2);
for i =1:nclasses
    posindeces = allLabels(:,i)==1;
    D{i} = uutrain(:,posindeces);
end

W=CanonVar(D,nclasses-1);

for j = 1:(nclasses-1)
    name = ['V',num2str(j)];
    name = W(:,j);
    
    ldafeattrain(:,j) = uutrain'*name;
    
    ldafeattest(:,j) = uutest'*name;
end

tic
model = ClassificationKNN.fit(ldafeattraining,allLabels);

[predictionLabels,predscore] = predict(model,ldafeattest);
toc
end

