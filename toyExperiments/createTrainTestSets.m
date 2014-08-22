function [ trainID, testID, labels ] = createTrainTestSets( samples, labelVec, labeledRatio, flagPlot )
%% Description
%   Split dataset into training set (equal to labeledRatio for each class)
%   and testing set (the remainder samples).
%---------------------------------------------------
%% Input arguments 
%   [ trainID, testID, labels ] = createTrainTestSets( samples, labelVec, labeledRatio, flagPlot )%   
%   
%   samples       = matrix which contains the samples' coordinates, [nSamples x  2]
%   labelVec      = vector with labels, [nSamples x 1]
%   labeledRatio  = the ratio of labeled samples (train) per class, [%]
%   flagPlot      = plot train-test samples, {'false', 'true'}
%
%% Output
%  trainID = IDs of train samples 
%  testID  = IDs of test samples
%  labels  = matrix with {0,1}, [nSamples x nClasses]
%% Examples
% [ trainID, testID, labels ] = createTrainTestSets( samples, labelVec, 30, 'true' )
%
%% See also
% <generateSyntheticDataset.html generateSyntheticDataset>
%
% Written by: Christos Sagonas,
%  21-Mar-2012
%%

nClasses = length(unique(labelVec));
nSamples = size(samples,1);

% create labels matrix
labels = zeros(nSamples,nClasses);

for i=1:nClasses
   labels(labelVec==i,i) = 1;    
end


% find range of each class
classRange = zeros(nClasses,2);

for i=1:nClasses
    [tmp,~] = find(labels(:,i)==1);
    classRange(i,:) = [min(tmp) max(tmp)];
end

% calculate number of labeled samples for each class
trainNumClass = zeros(nClasses,1);
for i=1:nClasses
    trainNumClass(i) = ceil(length(find(labels(:,i)==1))*labeledRatio/100);
end

% create trainID
trainID = [];
for i=1:nClasses
   classTrID = rand_int(classRange(i,1),classRange(i,2),trainNumClass(i),1,1,0);    
   trainID = [trainID, classTrID'];
end

% create testID
testID = 1:size(samples,1);
testID(trainID) = []; 

% create figure to plot train-test samples
if (strcmp(flagPlot,'true'))
    hold on
    for i = 1:nClasses
        current_color = [rand rand rand];
        plot(samples(labels(:,i)==1,1), samples(labels(:,i)==1,2), ...
            'Color',current_color, 'MarkerSize',5,  'Marker','*','LineStyle','none');
       
        for j=1:size(trainID,2)
            if labels(trainID(j),i) ==1
                hold on
                plot(samples(trainID(j),1),samples(trainID(j),2),'Color','g', 'MarkerSize',5,  'Marker','s','LineStyle','none');
            end
        end
     end   
end

end

