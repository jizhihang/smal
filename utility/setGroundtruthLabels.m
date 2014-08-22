function groundtruthLabels = setGroundtruthLabels(  testLabels )
% given a matrix [1,0], which rows refer to images and columns to concept
% we export a new 1-d matrix, which denotes the number of concept.
%  INPUT:
% - testLabels: given two images with 3 labels:
%       0 1 0
%       0 0 1
% OUTPUT: 
% -groundtruthLabels:
% 2
% 3

groundtruthLabels = zeros(size(testLabels,1),1);
for i=1:size(testLabels,1)
    idLabels = find(testLabels(i,:)==1);
    
    if(numel(idLabels)>1)
        idLabels=idLabels(1);
    end
    groundtruthLabels(i)=idLabels;
end
    

end

