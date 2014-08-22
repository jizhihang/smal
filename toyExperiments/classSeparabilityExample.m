% A toy experiment of measuring the separability between classes, based on
% between and within distance.
% let the center of all classes be
mu=[5;5];

%for the first class
mu1=[mu(1)-3;mu(2)+7];
covm1 = [5 -1;-3 3];

% generating feature vectors using box-muller approach 
% generte a random variable following uniform (0,1) having two features and
% 1000 feature vectors
u=rand(2,1000);

% extracting from the generated unofrm random variable two indepedent
% unofprm random variables
u1 = u(:,1:2:end);
u2 = u(:,2:2:end);

% using u1 and u2, we will usw box-muller method to generate the feature
% vector to folloe standard normal
x  = sqrt((-2).*log(u1)).* (cos(2*pi.*u2));

%now manipulating the generated features N(0,1) to foloowing certain mean
%and coavriance other than the standard normal
% first we will change its variance then we will change its mean
% getting the eigenvectors and values of the covariance matrix
[V,D] = eig(covm1); % D is the eigenvalues matrix and V the eigenvectors
newX = x;
for j=1:size(x,2)
    newX(:,j)=V*sqrt(D)*x(:,j);
end

%changing its mean
newX = newX+repmat(mu1,1,size(newX,2));

%now our dataset for the first class matrix will be 
x1= newX; % each column is a feature vector, each row is a single feature

%% computing the class means
% mu1 = mean(x1')';
mu1 = mean(x1,2);

% overall mean
mu = (mu1)./1; % mu =(mu1+mu2+mu3)./3

%class covariance matrices
s1 = cov(x1');

%within-class scatter matrix
sw = s1; %sw = s1+s2+s3

%number of samples of each class
n1 = size(x1,2);

% between-class scatter matrix
sb1 = n1.*(mu1-mu)*(mu1-mu)';

sb = sb1; % sb = sb1+sb2+sb3

%% lets visualize them
hfig = figure;
axes1 = axes('Parent',hfig,'FontWeight','bold','FontSize',12);
hold all;

%create xlabel
xlabel('X_1- the first feature','FontWeight','bold','FontSize',12, 'FontName','Garamond');

%create ylabel
ylabel('X_2- the first feature','FontWeight','bold','FontSize',12, 'FontName','Garamond')

%the first class 
scatter (x1(1,:),x1(2,:),'r', 'LineWidth',2,'Parent',axes1);
hold on

% class's mean
plot(mu1(1),mu1(2),'co','MarkerSize',8,'MarkerEdgeColor','c','Color','c',...
    'LineWidth',2,'MarkerFaceColor','c','Parent',axes1);
hold on


