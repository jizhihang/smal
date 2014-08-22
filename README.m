%% Introduction 
% This folder contains implementation of SMaL and Incremental SMaL (SIML) frameworks as described in [1], [2] and [3].
%
% * _Features_
% Any new features to be analysed should be placed in the _../results/features/"collectionFolder"_ [*] folder. Preferably, feature data should be in Matlab format (*.mat) of the form:	
% 
%                                           vec1 vec2 vec3.....vecn			
%
% * _Necessary Data_
% 
% Any data like groundtruth or lists refering to ids indeces to split a
% dataset of images should be placed in _..results/data/"collectionFolder"_ [*] folder. Preferably, these data should be in Matlab format (*.mat). Groundtruth should be of the form:
% 
%                                       label_class1 label_class2.....label_classn
%
% [*] CollectionFolder should be a name given to a dataset. For example, for Flikcr dataset we have set the CollectionFolder as flick2013. 
% 
% * _Results_
% 
% Any results should be placed in _results/predictions_ folder.
%
% * The final outcome from the aforementioned files is the prediction scores from each descriptor in
%
%  ../results/predictions/"collectionFolder"/"nameOfDescriptor"/predictionScore[num]split[num].mat
%
% and some accuracy metrics like mean Interpolated Average precision in
%
% ../results/predictions/"collectionFolder"/"nameOfDescriptor"/mIAP.mat_. 
%
% * The results from fusionDemos are in
%
% ../results/predictions/"collectionFolder"/Fusion/predictionScore[num]split[num].mat
% and ../results/predictions/"collectionFolder"/Fusion/mIAP.mat. 
%
% * Finally, the results from IncrementalDemos are in
%
% ../results/predictions/"collectionFolder"/Incremental/"nameOfDescriptor"/predictionScore[num]split[num].mat 
% and ../results/predictions/"collectionFolder"/Incremental/"nameOfDescriptor"/mIAP.mat.	 
%
% * In _../results/images_ users can include the images from a dataset in case they want to extract test results according to top-k precision of images/concept. Optionally, users can extract graphical statistics from the results.	
% 
%% More Semantics for Running the Code
% The Matlab code consists of 4 files which can work as standalone scripts and 4 folders which contains functions, which include algorithm scripts or scripts to run the Demos.   
%
% *These 4 files are:*  
%
% * _smalDemo.m_: This .m file extracts the SMaL framework by computing the Laplacian Eigenmaps for different features. 
% * _smalFusionDemo.m_: This .m file extracts the SMaL framework by computing the Laplacian Eigenmaps and by fusioning them.  
% * _smalIncrementalDemo.m_: This .m file extracts the SIML framework by computing the training Laplacian Eigenmaps and then with Incremental method compute the test Laplacian Eigenmaps in batches for different features.
% * _smalIncrementalFusionDemo.m_: This .m file extracts the SIML framework by computing the training Laplacian Eigenmaps and then with Incremental method compute the test Laplacian Eigenmaps in batches by fusioning them.  
% 
% The 4 included folders  are:
%
% * *ale*: implementation of  Approximate Laplacian Eigenmaps as described in [4].	
% * *gsf*: implementation of Laplacian Eigenmaps by using Spectral Clustering. This Framework is known as _Graph Structure Features_, and is used in ImageCLEF2012 competition in photo Annotation task and as state-of-the-art in [2]. In this folder 2 .m files are included:
%    _gsfDemo.m_: This .m file extracts the Laplacian Eigenmaps for different features
%    _gsfFusionDemo.m_: This .m file extracts the Laplacian Eigenmaps by fusioning them. In order to run this .m file, users should first run the _gsfDemo_ file.	
% * *incremental*: functions used in SIML incremental computation 
% * *utility*: general functions used many times in the procedure. 	
% 
%% Supplementary Code
%
% * *evaluation*: This folder contains various evaluation measures and
% comparison tests used in IJMR journal
% * *featureExtraction*: This folder contains a function which is used to
% build a matlab wrapper, to extract SIFT features from vlfeat in Java
% * *javaFunctions*: This folder contains the SMaL and SIML functions which are included in a wrapper
% implementation for Java
% * *LDA*: This folder contains the Latent Discriminant Analysis (LDA)
% implementation
% * *matlab&MySQL*: This folder contains functions used to interact matlab
% with MySQL 
% * *pLSA*: This folder contains the probabilistic Latent Semantic Analysis
% (pLSA) implementation
% * *toyExperiments*: This folder contains various functions, used for
% experimental reasons and does not contain a specific implementation
%
%% Libraries
%
% In order to make possible to run the aforementioned demos you must insert in Matlab path the libraries bellow (included in toolbox_tmp folder):
%
% # <http://www.csie.ntu.edu.tw/~cjlin/liblinear/ Liblinear>(1.94v)
% # <http://www.csie.ntu.edu.tw/~cjlin/libsvm/ Libsvm>(3.17v)	
% # <http://leitang.net/social_dimension.html SocioDim>
% # <http://www.vlfeat.org/ vlFeat>(0.9.17v)	
% 
%% References
% [1]  E. Mantziou, S. Papadopoulos, Y. Kompatsiaris. "Large-Scale Semi-Supervised Learning by Approximate Laplacian Eigenmaps, VLAD and Pyramids". 
% In Proceedings of WIA2MIS 2013, Paris, France.  
%
% [2]  E. Mantziou, S. Papadopoulos, Y. Kompatsiaris. "Scalable Training with Approximate Incremental Laplacian Eigenmaps and PCA".
% In Proceedings of ACM Yahoo Grand Challenge 2013, ACM Multimedia MM'13, Barcelona, Spain.	
% 
% [3]  R. Fergus and Y. Weiss. "Semi-supervised Learning in Gigantic Image Collections".
% Neural Information Processing Systems (NIPS), 2009.
