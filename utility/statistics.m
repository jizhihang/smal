function [AP,minter_pr] = statistics( labels, scores )
% computation of metrics average precision (AP) and interpolated average 
% precision (minter_pr)

% compute AP
% AP = averagePrecision(labels,scores);
 
labels(labels==0) = -1;


%compute AUC, EER
% [~,~,info] = vl_roc(labels,scores);
% AUC = info.auc;

% compute interpolated precision-recall
[~, ~, info] = vl_pr(labels, scores);
% inter_pr = info.inter_pr; %vlfeat-0.9.13
inter_pr = info.ap_interp_11; %vlfeat-0.9.17
%mean inter_pr
minter_pr = mean(inter_pr);

AP = info.ap; %vlfeat-0.9.17

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
