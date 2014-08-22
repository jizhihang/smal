function AP = runLibSVM(vtest,vtrain,trainLabels,testLabels)
% Train SVM and create the prediction scores and average precision using
% LibSVM with precomputed kernels
% Input: 
%  *vtest: matrix which contain test vectors
%  *vtrain: matrix which contain train vectors
%  *trainLabels: the labels of train samples
%  *testLabels: the labels of test samples
% Output:
%  *AP: the average precision
%

% load flikcr2013
% for i=1:15000
%     vtrain(i,:) = vtrain(i,:)./norm(vtrain(i,:),2);
% end
% for i=1:10000
%     vtest(i,:) = vtest(i,:)./norm(vtest(i,:),2);
% end
% 
K = vtest*vtrain';
Ktr = vtrain*vtrain';
trainLabels(trainLabels==0) = -1;
testLabels(testLabels==0) = -1;
for i=1:94
    disp(i);
    model{i} = svmtrain(trainLabels(:,i),[(1:15000)' Ktr],'-t 4');
    [~,~,preds(:,i)] = svmpredict(testLabels(:,i),[(1:10000)' K],model{i});
    AP(i) = averagePrecision(testLabels(:,i), preds(:,i));
end
end


% svmtrain(labels(trainListID,1),vtrain,'-t 0');
% [a b c] = svmpredict(labels(testListID,1),vtest,model);
% x=labels(testListID,1);
% [a2 b2 c2] = svmpredict(x(1:100),vtest(1:100,:),model);

function AP = averagePrecision(groundTruth, predictionScore)
% function to compute AP

[~, IDs] = sort(predictionScore,'descend');
Ranked = groundTruth(IDs(:));

AP = 0;
for i=1:length(Ranked)
    if Ranked(i) ==1
        temp = Ranked(1:i);
        TP = sum(temp == 1);
        Pr = TP/length(temp);
        AP = AP + Pr;
    end
end
Total = sum(Ranked == 1);
AP = AP/Total;

end

function normmat = normalizeMat(mat)
for i=1:size(mat,2)
    normmat(:,i) = (mat(:,i) - min(mat(:,i)))/(max(mat(:,i))-min(mat(:,i)));
end

end

