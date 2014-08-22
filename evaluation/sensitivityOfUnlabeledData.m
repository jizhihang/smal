% With this experiment we want to measure the accuracy improvement of SMaL if we add
% unlabeled samples in laplacian eigenmaps construction. The number of unlabeled
% data increases in each iteration.

v = dlmread('D:\lena\Codes\MyCodes\smal\smal\matlab\results\features\imageclef\gist_25K.txt','',0,1);
clearvars -except v allLabels testLabels labels trainListID testListID miap
clc
labelsImport = labels;
id =0;
k = 500;
minter= zeros(11,1);
for cc = 1:11
    fprintf([num2str(cc),'\n']);
    clearvars -except v allLabels testLabels labels trainListID testListID labelsImport id k cc minter miap
    % set size of labeled/unlabeled/test samples
    labeledNum   = 5000;
    unlabeledNum = id;
    testNum      = 10000;
    
    % create ids for labeled / unlabeled / test samples
    labeledID  = trainListID(1:labeledNum);
    if id==0
        unlabeldID = [];
        
    else
        unlabeldID = trainListID(labeledNum+1:labeledNum+unlabeledNum);
    end
    
    testID     = testListID(end-testNum+1:end);
    
    % create labeled / unlabeled / test samples
    labeledSampels   = v(labeledID,:);
    unlabeledSamples = v(unlabeldID,:);
    testSamples      = v(testID,:);
    
    % matrix which contains labeled & unlabeled samples
    labeled_unlabeled_samples = [labeledSampels;unlabeledSamples];
    tic;
    for a=1:size(labeled_unlabeled_samples,2)
        % Solve eqn. 2 in the NIPS paper, one dimension at a time.
        [bins(:,a),g(:,:,a),lambdas(:,a),pp]=numericalEigenFunctions(labeled_unlabeled_samples(:,a),0.2);
    end
    
    [ddtrain,uutrain,ii,jj] = eigenfunctionsIncremental(labeled_unlabeled_samples,g,lambdas,k,bins);
    
%     uutest = zeros(size(testSamples,1),k);
    uutest = [];
    indx = 1;
    numPerBatch = 1000;                     % the number of batches to split the test set
    batches = round(size(testSamples,1)/numPerBatch);    % the number of loops
    %============== Interpolation on test batches======================
    BatchesStart = tic;
    fprintf('start batches');
    for i = 1:batches
        if mod(size(testSamples,1),numPerBatch)~=0    % if the dataset does not diverse it with the numPerBatch
            % we have to compute the reamining items
            if i==batches
                res = (size(testSamples,1)- ((i-1)* numPerBatch )-1);    % the remaining items
                vtmp = testSamples(indx:indx+res,:);
            else
                vtmp = testSamples(indx:indx+999,:);
            end
        else
            vtmp = testSamples(indx:indx+999,:);
        end
        
        LOWER = 2.5/100; %% clip lowest CLIP_MARIN percent
        UPPER = 1-LOWER; % clip symmetrically
        for a=1:size(vtmp,2)
            [clip_lower(a),clip_upper(a)] = percentile(vtmp(:,a),LOWER,UPPER);
            q = vtmp(:,a)<clip_lower(a);
            % set all values below threshold to be constant
            vtmp(q,a) = clip_lower(a);
            q2 = vtmp(:,a)>clip_upper(a);
            % set all values above threshold to be constant
            vtmp(q2,a) = clip_upper(a);
        end
        for a=1:k
            bins_out(:,a) = bins(:,jj(a));
            uu1(:,a) = g(:,ii(a),jj(a));
            uu2(:,a) = interp1(bins_out(:,a),uu1(:,a),vtmp(:,jj(a)),'linear','extrap');
        end
        suu2 = sqrt(sum(uu2.^2));
        uu2 = uu2 ./ (ones(size(vtmp,1),1) * suu2);
        
        indx=indx+numPerBatch;
        uutest = [uutest;uu2];
        clear uu2
    end
    
    BatchesEnd =toc(BatchesStart);
    fprintf('test batches computed at %d minutes and %f seconds\n',floor(BatchesEnd/60),rem(BatchesEnd,60));
    
    uu  = [uutrain;uutest];
   
    %========================svm================================
%     model = linearsvm(uu(labeledID,:),labelsImport(labeledID,:),5);
%     score = uu(labeledNum+unlabeledNum+1:end,:) * model.W + repmat(model.bias, testNum, 1);
    
    %======================smooth f==============================
        nPoints = size(uu,1);
        lambda=zeros(nPoints,1);
        classnr = size(labelsImport,2);
        labelst = labelsImport(labeledID,:);
        labelst(labelst==0)=-1;
        labelsnew = zeros(nPoints,classnr);
        labelsnew(labeledID,:)=labelst;    % In the end we have positive examples(1), negative examples(-1) from train set and Unlabeled data(0)
        lambda(labeledID,:)=500;
        Lambda = spdiags(lambda(:),0,nPoints,nPoints);
        alpha2=(ddtrain +uu'*Lambda*uu)\(uu'*Lambda*labelsnew);
        decisionValues=uu*alpha2;
        score = decisionValues(labeledNum+unlabeledNum+1:end,:);
    %
    %======================AP Interprecisionrecall==============================
    AP  = zeros(size(labelsImport,2),1);
    InterPrecisionRecall = zeros(size(labelsImport,2),1);
    for i=1:size(labelsImport(testID,:),2)
        [AP(i),InterPrecisionRecall(i,:)] = statistics(labelsImport(testID,i),score(:,i)) ;
    end
    minter(cc) = mean(InterPrecisionRecall);
    %     mean(AP)
    %     mean(InterPrecisionRecall)
    id = id+1000;
    
end
plot(minter)
toc;
