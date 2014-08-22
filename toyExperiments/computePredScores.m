function [ predscoreSmooth,predscoreSVM ] = computePredScores( vsplit,sigma,k,trainLabels,trainnum,dd)
% train a linear SVM or a smooth function.
% used in PerformClustering.m

uu = vsplit;
% [dd,uu] = eigenfunctions(vsplit,sigma,k,1);
% ======Prepare Labels for smooth function=========
nPoints= size(vsplit,1);
weight = 100;
lambda=zeros(nPoints,1);

labelst = trainLabels;
labelst(labelst==0)=-1;
labels = zeros(size(vsplit,1),size(trainLabels,2));
labels(1:trainnum,:)=labelst;
lambda(1:trainnum,:)=weight;
clear labelst

Lambda = spdiags(lambda(:),0,nPoints,nPoints);

% ======Smooth Function f=========
alpha2=(dd +uu'*Lambda*uu)\(uu'*Lambda*labels);
f_efunc=uu*alpha2;
predscoreSmooth = f_efunc(trainnum+1:end,:);



% ======SVM========
trainID = (1:trainnum);trainID = trainID';
testID = trainnum+1:size(uu,1);
C = 5;
[predscoreSVM] = SocioDim(uu, trainLabels, trainID, testID,C);

end



