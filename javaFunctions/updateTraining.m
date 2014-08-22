function [ ddtrain,uutrain,bins_out,uu1,jj ] = updateTraining( params, trainLabels )
% extracts and saves the training eivenvectors and the parameters used in incremental
% procedure. Used when you want to update these parameters adding new
% samples.
%
% run in command window this command to set the jdk enviroment if it is not
% predefined.
%  setenv('JAVA_HOME','C:\Program Files\Java\jdk1.7.0_17\')
%
%------------------------------------------------------------------
% ======Find bins, g and eigenvcalues in train set=================
vtrain = params.vtrain;
file = params.file;

sigma = 0.2;
k=500;
trainnum = size(vtrain,1);
for dim=1:size(vtrain,2)
    [bins(:,dim),g(:,:,dim),lambdas(:,dim),~]=numericalEigenFunctions(vtrain(:,dim),sigma);
end
% =================Find eigenvectors in train set==================
[ddtrain,uutrain,bins_out,uu1,jj] = eigenfunctionsIncremental(vtrain,g,lambdas,k,bins);

param.ddtrain = ddtrain; % eigenvalues
param.uutrain = uutrain; % eigenvectors
param.bins_out = bins_out; % nubmer of bins used to build the histogram
param.uu1 = uu1; %eigenfunctions
param.jj = jj; %number of dimensions
param.trainLabels = trainLabels;

save([file,'/','twitter_training_params'],'param');

end

