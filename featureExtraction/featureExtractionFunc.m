function nonzerodescriptor = featureExtractionFunc(imagedir,pyramids)

% This function call the vl_phow function from vlfeat library to construct
% the SIFT descriptors. 
% featureExtractionFunc is used in  "javaFunctions/siftExtraction" package as a matlab
% wrapper in Java


% vl_setup --> uncomment it for the first time u run the code to open vlfeat
% setenv('JAVA_HOME','C:\Program Files\Java\jdk1.7.0_17\')

image = imread(imagedir);
% color = 'gray','rgb','opponent'
[fr,desc]=vl_phow(im2single(image));
fr = fr';
desc =double(desc');
coordinates =fr(:,1:2);
descriptor = [coordinates desc];

% check if you want to use the descriptors for Spatial Pyramids. If
% pyramids variable is true then we need to extract the coordinates.
if strcmp(pyramids, 'false')
    nonzerodescriptor = desc(sum(desc(:,1:end),2)~=0,:);
else
    %with coordinates for pyramids
    nonzerodescriptor = descriptor(sum(descriptor(:,3:end),2)~=0,:);
end
end

