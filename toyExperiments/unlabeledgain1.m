vtest = v(15001:end,:);
vst = v(10001:15000,:);
trainLabels = allLabels(10001:end,:);
a = 1000;
% map = zeros(10,1);
minter = zeros(10,1);
for i = 1:10
    vr = v(1:a,:);
    vfinal = [vst;vr;vtest];
    [dd,uu] = eigenfunctions(vfinal,0.2,500);
    num1 = size(vst,1);
    num2 = size(vr,1);
    totalnumber = num1+num2;
    %========================svm================================
%         model = linearsvm(uu(1:size(trainLabels,1),:), trainLabels,5);
%         score = uu(totalnumber+1:end,:) * model.W + repmat(model.bias, 10000, 1);
    %======================smooth f==============================

    nPoints = size(uu,1);
    lambda=zeros(nPoints,1);
    classnr = size(trainLabels,2);
    trainvector = size(trainLabels,1);
    labelst = trainLabels;
    labelst(labelst==0)=-1;
    labelsnew = zeros(nPoints,classnr);
    labelsnew(1:trainvector,:)=labelst;    % In the end we have positive examples(1), negative examples(-1) from train set and Unlabeled data(0)
    lambda(1:trainvector,:)=500;
    Lambda = spdiags(lambda(:),0,nPoints,nPoints);
    alpha2=(dd +uu'*Lambda*uu)\(uu'*Lambda*labelsnew);
    decisionValues=uu*alpha2;
    score = decisionValues(totalnumber+1:end,:);
    
    
    %     AP  = zeros(size(trainLabels,2),1);
    InterPrecisionRecall = zeros(size(trainLabels,2),1);
    for j=1:size(testLabels,2)
        [InterPrecisionRecall(j,:)] = statistics(testLabels(:,j),score(:,j)) ;
    end
    %     map(i) = mean(AP);
    minter(i) = mean(InterPrecisionRecall);
    
    a = a +1000;
end