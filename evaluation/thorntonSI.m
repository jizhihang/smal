% Matlab code for Thornton's separability index
% Accepts a p x d  matrix X in which each row is a vector
% of d numeric features (usually norm. into the range 0-1)
% t is a vector of labels (usually +1 or - 1)
% Returns s, a number between 0 and 1, a measure of
% degree to which classes are geometrically separable.
% s is  the fraction of instances whose classification
% label is shared by its nearest neighbour (determined
% on the basis of simple Euclidean distance)
tic
s = zeros(10,1);
for i=1:10
    disp(i);
    load(['\\iti-195\smal\matlab\results\data\yahoo\5k\trainList',num2str(i)])
    vtrain1 = vtrain(:,trainListID)';
    [~,uutrain1]=eigenfunctions(vtrain1,0.2,500);
    uutrain1norm = normalizeMatrix(uutrain1,1);
    
    X = uutrain1norm + 1e-3*randn(size(uutrain1norm));      % tie-breaker for toy data
    p = size(X,1);        % number of points
    d2 = slmetric_pw(X', X','eucdist');
    [S,I] = sort(d2);     % sort each col by distance;  I = index
    t1 = labels(I(1,:));         % labels of points          (row 1 of d2)
    t2 = labels(I(2,:));        % labels of n-neighbours  (row 2 of d2)
    s(i) = sum(t1==t2)/p;   % fract. of points with same class n.nr
end
mean(s)
toc