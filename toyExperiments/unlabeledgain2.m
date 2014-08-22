% load('D:\lena\Codes\MyCodes\smal\smal\matlab\results\data\mir-flickr\flickrPOTlabelslikeCLEF.mat')
% load('D:\lena\Codes\MyCodes\smal\smal\matlab\results\data\mir-flickr\testList15to25k.mat')
% load('D:\lena\Codes\MyCodes\smal\smal\matlab\results\data\mir-flickr\5k\trainList1.mat')
% load('D:\lena\Codes\MyCodes\smal\smal\matlab\results\features\imageclef\surf512.mat')


vunlabeled = v(testListID,:);
vlabeled = v(trainListID,:);
trainLabels = trainLabels(trainListID,:);
% testLabels = labels(testListID,:);

allIndeces= 1:1500;
restIndeces = setdiff(allIndeces,trainListID);
vrest = v(restIndeces,:);
numrest = size(vrest,1);

% clearvars -except vunlabeled vlabeled trainLabels testLabels allIndeces restIndeces vrest v

miap = zeros(10,1);
numsplit = 1100;
for jj=1:10
    clearvars -except v vunlabeled vlabeled trainLabels testLabels allIndeces restIndeces vrest numsplit jj numrest
    
    restIndeces1 = datasample(1:numrest,numsplit);
    restIndeces1 = unique(restIndeces1);
       
%     if jj == 3
%         restIndeces1 = datasample(1:numrest,3600);
%         restIndeces1 = unique(restIndeces1);
%     elseif jj == 4
%         restIndeces1 = datasample(1:numrest,5100);
%         restIndeces1 = unique(restIndeces1);
%     elseif jj==5
%         restIndeces1 = datasample(1:numrest,7000);
%         restIndeces1 = unique(restIndeces1);
%     elseif jj ==6
%         restIndeces1 = datasample(1:numrest,9300);
%         restIndeces1 = unique(restIndeces1);
%     elseif jj==7
%         restIndeces1 = datasample(1:numrest,12000);
%         restIndeces1 = unique(restIndeces1);
%     elseif jj==8
%         restIndeces1 = datasample(1:numrest,17000);
%         restIndeces1 = unique(restIndeces1);
%     elseif jj==9
%         restIndeces1 = datasample(1:numrest,24000);
%         restIndeces1 = unique(restIndeces1);
%     end
    

    vOrdered =[vlabeled;vrest(restIndeces1',:);vunlabeled];
    num1 = size(vlabeled,1);
    num2 = size(vrest(restIndeces1',:),1);
    
%     if jj==10
%         vOrdered =[vlabeled;vrest;vunlabeled];
%         num1 = size(vlabeled,1);
%         num2 = size(vrest,1);
%     end
    
    [dd,uu] = eigenfunctions(vOrdered,0.2,500);
    numOflamda = 500;
    
    nPoints = size(uu,1);
    lambda=zeros(nPoints,1);
    classnr = size(trainLabels,2);
    trainvector = size(trainLabels,1);
    labelst = trainLabels;
    labelst(labelst==0)=-1;
    labelsnew = zeros(nPoints,classnr);
    labelsnew(1:trainvector,:)=labelst;    % In the end we have positive examples(1), negative examples(-1) from train set and Unlabeled data(0)
    lambda(1:trainvector,:)=numOflamda;
    Lambda = spdiags(lambda(:),0,nPoints,nPoints);
    alpha2=(dd +uu'*Lambda*uu)\(uu'*Lambda*labelsnew);
    decisionValues=uu*alpha2;
    score = decisionValues((num1+num2+1):end,:);
    InterPrecisionRecall = zeros(size(trainLabels,2),1);
    for j=1:size(testLabels,2)
        [InterPrecisionRecall(j,:)] = statistics(testLabels(:,j),score(:,j)) ;
    end
    miap(jj)=mean(InterPrecisionRecall(:,1));
    numsplit = numsplit +11000;
end