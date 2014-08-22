%  computes Precision@k (k=10,100,200 etc.)

% collection  = 'Twitter13';
% load(['D:\lena\Codes\MyCodes\LaplacianEigenmaps_Code\TestTrainSet\',collection,'\testLabels',collection,'.mat']);
% load(['D:\lena\Codes\MyCodes\LaplacianEigenmaps_Code\TestTrainSet\',collection,'\test5k',collection,'.mat']);
% load(['D:\lena\Codes\MyCodes\LaplacianEigenmaps_Code\results\predictions\prediction scores\final_test_scores\',collection,'\03-Sep-2013\predictionScore_1']);
clc
nrClass=size(testLabels,2);
% score = predscore; %f_efunc  predscore
precision = 100;
Pr=zeros(nrClass,1);
% score = normalizeMatrix(score,3);
for i=1:nrClass
    [~, IDs] = sort(score(:,i),'descend');
    Ranked = testLabels(IDs(:),i);
    for j=1:precision
        temp = Ranked(1:j);
        TP = sum(temp == 1);
        Pr(i) = TP/length(temp); 
    end
end
Pr= Pr'
%  AP  = zeros(size(testLabels,2),1);
%  for j=1:size(testLabels,2)
%      [AP(j),~] = statistics(testLabels(:,j),score(:,j)) ;
%  end
%  
%  id = Pr==0;
%  Pr(id)=AP(id);
 mean(Pr)