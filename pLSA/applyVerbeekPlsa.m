function   applyVerbeekPlsa
% function   applyVerbeekPlsa(trainMatrix, testMatrix, iNumOfTopics)
directory =  'D:\lena\Codes\MyCodes\LaplacianEigenmaps_Code\results\features\';
directory2 = 'D:\lena\Codes\MyCodes\LaplacianEigenmaps_Code\results\featuresmediaeval\';
Xtrain  =dlmread([directory,'toptags_15K5000.txt'],'',0,1);
Xtest  =dlmread([directory2,'toptags_5000_All.txt'],'',0,1);
% Xtrain=load(trainMatrix);
%
% Xtest=load(testMatrix);
iNumOfTopics=200;
iNumOfWords=size(Xtrain,2);

fprintf('--> Training....\n');
[wt,td,E] = plsa(Xtrain',iNumOfTopics,0.000001,0,rand(iNumOfWords,iNumOfTopics),1);
%[wt,td,E] = plsa_rand(Xtrain',iNumOfTopics,1,0,rand(iNumOfWords,iNumOfTopics),1);

% td=td';
dlmwrite('D:\lena\Codes\MyCodes\LaplacianEigenmaps_Code\results\features\plsatoptags(5000).txt',td,'\t');
% outfilename=strcat('plsa_',trainMatrix);
% save(outfilename,'td','-ascii');


%pseudoinv=pinv(wt);
%pseudotd=pseudoinv*Xtest';
%pseudotd(find(pseudotd<0))=0;
%pseudotd=normalize(pseudotd,2);

%pseudotd=normalize(wt'*Xtest',1);


fprintf('--> Indexing....\n');
[wt,tdtest,E] = plsa(Xtest',iNumOfTopics,0.000001,0,wt,0);
%[wt,td,E] = plsa_rand(Xtest',iNumOfTopics,1,0,wt,0);
%[wt,td,E] = plsa_modified(Xtest',iNumOfTopics,1,0,wt,0,pseudotd);
tdtest=tdtest';
dlmwrite('D:\lena\Codes\MyCodes\LaplacianEigenmaps_Code\results\featuresmediaeval\plsaToptags(5000).txt',tdtest,'\t');
% outfilename=strcat('plsa_',testMatrix);
% save(outfilename,'td','-ascii');