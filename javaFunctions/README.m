%%
% This folder contains the Incremental procedure of SMaL to use it in Java
% It contains 4 functions used as a wrapper to import as .jar library in
% Java Project.
% To build a java project open the "deploytool" from command window.
% The smal.jar is used in ConceptDetector Package and the
% siftExtraction.jar is used in Sift Package.
% If you want to build the jar file for linux please follow the orders in
% readme.txt from src folder (ex. smal/src/readme.txt).
% Use the functions with the following order:
% 
% # updateTraining: Extracts the training eigenvectors and the variables
% needed to construct the test eigenvectors incrementally. Exports a file
% used in java. It is an offline method and run whenever you need to update
% the training eigevectors and the parameters.
% # incremental: extracts the test eigenvectors incrementally in batch
% mode. similar to smalIncrementalDemo.
% # classifier: use linear svm to train the model and extract the
% prediction score  use of liblinear library. Alternatively, use smooth
% function to train the model and extract the prediction score. It extracts
% the idx, which obtains the concept an image belongs.
% # metrics: computes the Average Precision 
% 
% *smal: An example of smalDemo.