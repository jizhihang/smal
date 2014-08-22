function score = smal(params )
% example of smalDemo used in Java
%   Detailed explanation goes here

% setenv('JAVA_HOME','C:\Program Files\Java\jdk1.7.0_17\')

%% user parameters
vtrain = params.vtrain;
vtest = params.vtest;
trainLabels = params.trainLabels;
method =params.method;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist('params.NUMEVECS','var')
    NUM_EVECS = params.NUMEVECS;
    
else
    NUM_EVECS = 500;  %number of total eigenvectors
end

if exist('params.SIGMA','var')
    SIGMA = params.SIGMA;
    
else
    SIGMA = 0.2;  % controls affinity in graph Laplacian
end

v = [vtrain;vtest];
% compute approximate eigenvectors using eigenfunction approach
eigenfunctionStart =tic;
disp('Compute Eigenfunctions');
[dd,uu] = eigenfunctions(v,SIGMA,NUM_EVECS);
uu = double (uu);
dd = double(dd);
eigenfunctionEnd= toc(eigenfunctionStart);
trainNum = size(vtrain,1);
uutrain = uu(1:trainNum,:);
uutest = uu(trainNum+1:end,:);
fprintf('Eigenvectors computed at %d minutes and %f seconds\n',floor(eigenfunctionEnd/60),rem(eigenfunctionEnd,60));
predictionStart = tic;
fprintf('Computing Prediction Score\n');
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
        if exist('params.parameter','var')
            parameter = params.parameter;
        else
            parameter = 100;  %numoflambda: the weight of known samples
        end
        score = smooth( parameter, uutrain,uutest,dd, trainLabels);
end
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
