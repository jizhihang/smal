function [score,idx] = classifier(params )
% Train SVM or smooth function to train the model and create the prediction scores
% Input: 
%  *params: a structure containing training and test eigenvectors, training
%  labels and important parameters.
% Output:
%  *score: the prediction scores for test samples
%  *idx: the concept a sample belongs (ex. 1,2,3..10)

%
%  setenv('JAVA_HOME','C:\Program Files\Java\jdk1.7.0_17\')
%

%===================================Set Parameters=========================
uutrain = params.uutrain;
uutest = params.uutest;
trainLabels = params.trainLabels;
method = params.method;

%==========================train model===============================
fprintf('Computing Prediction Score\n');
predictionStart = tic;

switch method
    case '1'
        
        if exist('params.parameter','var')
            parameter = params.parameter;
            
        else
            parameter = 5;  %c: the SVM trade-off parameter
        end
        % use linear svm to train the model and extract the prediction
        % score
        % use of liblinear library
        
        model = linearsvm(uutrain, trainLabels, parameter);
        
        numU = size(uutest,1);  % number of test instances
        % prediction
        score = uutest * model.W + repmat(model.bias, numU, 1);
        
        
    case '2'
        % use smooth function to train the model and extract the prediction
        % score
        ddtrain = params.ddtrain;
        if exist('params.parameter','var')
            parameter = params.parameter;
        else
            parameter = 100;  %numoflambda: the weight of known samples
        end
        score = smooth( parameter, uutrain,uutest,ddtrain, trainLabels);
end

score =(score-min(min(score)))./ (max(max(score))-min(min(score)));
[~, idx] = max(score,[],2);

% score = round(score*(10^num_dig))/(10^4);


predictionEnd =toc(predictionStart);
fprintf('train SVM computed at %d minutes and %f seconds\n',floor(predictionEnd/60),rem(predictionEnd,60));



end

function decisionValues=smooth(numOflamda,uutrain,uutest,dd,trainLabels)
uu  = [uutrain;uutest];
nPoints = size(uu,1);
lambda=zeros(nPoints,1);
classnr = size(trainLabels,2);
trainvector = size(trainLabels,1);

% Setup positive examples(1), negative examples(-1) from train set and Unlabeled data(0)
labelst = trainLabels;              % train set
labelst(labelst==0)=-1;             % set negative examples to -1 from train set
labels = zeros(nPoints,classnr);
labels(1:trainvector,:)=labelst;    % In the end we have positive examples(1), negative examples(-1) from train set and Unlabeled data(0)
lambda(1:trainvector,:)=numOflamda;

%----------------------------------------------------------------------
Lambda=diag(lambda);

% Smooth Function alpha
alpha2=(dd +uu'*Lambda*uu)\(uu'*Lambda*labels);
decisionValues=uu*alpha2;           % prediction score

testListID = trainvector+1:size(uu,1);
decisionValues =  decisionValues(testListID',:);

end



