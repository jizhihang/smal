function uutest= inremental(params)
%
% setenv('JAVA_HOME','C:\Program Files\Java\jdk1.7.0_17\')
% 
% Implementation of Incremental Learning of k-approximate eigenvectors.
% Demo computes the eigenfunctions and eigenvalues from training data
% and compute the training eigenvector. From this eigenvectors, demo
% computes the eigenfunctions and eigenvectors of test data by
% interpolating them.
% For efficient reasons, demo compute the eigenvectos from test data
% in batches (1000 items/batch).
%
% Demo also runs two different variant of learning model methods:
% 1. Linear SVM.
% 2. Smooth Function
%
% The code is ready to run for flickr2013 (included ulr file) and twitter2013 datasets.
% You can download the datasets from
% 1. flickr2013: http://www.socialsensor.eu/datasets/mm-concept-detection-dataset-2013/mm-concept-detection-datasets.zip
% 2. twitter2013: http://www.socialsensor.eu/datasets/mm-concept-detection-dataset-2013/mm-concept-detection-twitter2013-images.zip
%      password: socialsensor
%
% It is tested in ACM Yahoo Grand Challenge 2013 competition
%
% SmaL uses SIFT/RGB-SIFT VLAD feature aggregation method (and with spatial pyramids)
% and PCA for image representation.
% The implementation of SmaL approach is general and can be applied to any data.
%
% Version 1.0. Eleni Mantziou. 6/1/13.


%===================================Set Parameters=========================
k = 500;                            % number of eigenvectors
uutest = [];                        % test eigenvectors
vtest = params.vtest;
bins_out = params.bins_out;
uu1 = params.uu1;
jj = params.jj;

% if size(vtest,1)<40
%   error('cannot extract reliable results. The size of points is very small');
% end
%============== Interpolation on test batches======================
BatchesStart = tic;
fprintf('start batches');

LOWER = 2.5/100; %% clip lowest CLIP_MARIN percent
UPPER = 1-LOWER; % clip symmetrically
for a=1:size(vtest,2)
    [clip_lower(a),clip_upper(a)] = percentile(vtest(:,a),LOWER,UPPER);
    q = vtest(:,a)<clip_lower(a);
    % set all values below threshold to be constant
    vtest(q,a) = clip_lower(a);
    q2 = vtest(:,a)>clip_upper(a);
    % set all values above threshold to be constant
    vtest(q2,a) = clip_upper(a);
end
for a=1:k
    uutest(:,a) = interp1(bins_out(:,a),uu1(:,a),vtest(:,jj(a)),'linear','extrap');
end
suu2 = sqrt(sum(uutest.^2));
uutest = uutest ./ (ones(size(vtest,1),1) * suu2);


BatchesEnd =toc(BatchesStart);
fprintf('test batches computed at %d minutes and %f seconds\n',floor(BatchesEnd/60),rem(BatchesEnd,60));

% uutest  = [uutest;tmpuutest];

end

