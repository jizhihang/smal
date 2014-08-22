function [avgmAP, AP] = metrics( score,testLabels )
% extracts the accuracy metrics used in java. 
% similar to "statistics" in "utility" folder.

AP  = zeros(size(testLabels,2),1);

for i=1:size(testLabels,2)
    [AP(i)] = averagePrecision(testLabels(:,i),score(:,i)) ;
end

avgmAP = mean(AP,1);

end

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