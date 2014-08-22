%% 
% This folder contains the functions needed to import and retrieve data from a MySQL database
% 
% # First you need to insert the credentials to dbconnection.m function
% # Then you have to insest Concepts and Images into the database using
% insertConcepts.m and insertImages.m functions respectively.
% # You need to run insertRun.m function to create a description and some
% information for the specific results you will upload.
% # Finally you have to run insertPredscores.m function to add the
%  prediction scores of the predicted images.
% 
% * insertPredscores.m calls retrieveConcept.m, retrieveImage.m and
% retrieveRun.m functions.