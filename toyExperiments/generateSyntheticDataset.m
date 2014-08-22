function [samples,labelVec] = generateSyntheticDataset( typeData, nSamples, classProb,...
    noiseSigma, linesOpts, circlesOpts, gaussianOpts, flagPlot)
%% Description
%   Create synthetic datasets 
%---------------------------------------------------
%% Input arguments 
%   [samples,labelVec] = generateSyntheticDataset( typeData, nSamples, classProb,...
%   noiseSigma, linesOpts, circlesOpts, gaussianOpts, flagPlot)
%   
%   typeData   = {'lines','two_moons','circles','gaussians'}
%   nSamples   = number of output samples
%   classProb  = samples per class, sum of classProb must be 1
%   noiseSigma = sigma of Gaussian noise
%   flagPlot   = plot generated samples, {'false', 'true'}
%
%   linesOpts.dist                             = distance between lines   
%   circlesOpts.radius, circlesOpts.center     = center and radius of each circle
%   gaussianOpts.covariance, gaussianOpts.mean = mean and covariance matrix of each gaussian
%% Output
%  samples  = nSamples x 2
%  labelVec = nSamples x 1
%% Examples
%% Lines 
%  linesOpts.dist = 1;
%  [samples,labelVec] = generateSyntheticDataset('lines', 1000, [0.5 0.25 0.25], 0.01, linesOpts, [], [], 'true');
%
%% Two moons
%  [samples,labelVec] = generateSyntheticDataset('two_moons', 1000, [0.5 0.5], 0.01, [], [], [], 'true');
%% Circles
%  circlesOpts.radius = [3,5,7];
%  circlesOpts.center = [1,1;3,3;4,4];
%  [samples,labelVec] = generateSyntheticDataset('circles', 1000, [0.5 0.25 0.25], 0.01, [], circlesOpts, [], 'true');
% 
%% Gaussians
%  gaussianOpts.mean       = [12,10;20,20;30,30];
%  gaussianOpts.covariance = {{[5,0;0,80]},{[1,0;0,1]},{[11,1;1,11]}};
%  [samples,labelVec]      = generateSyntheticDataset('gaussians', 1000, [0.5 0.25 0.25], 0.01, [], [], gaussianOpts, 'true');
%
%% See also
% <createTrainTestSets.html createTrainTestSets>
%
% Written by: Christos Sagonas,
%  21-Mar-2012
%%

% check if sum of classProb equal to 1
%if(sum(classProb)~=1)
%    error('Sum of ClassProb must me equal to 1');
%end

nClasses         = length(classProb);
points           = rand(nSamples,1);
nPtsPerClasses   = zeros(1,nClasses);

% calculate number of samples for each class
for i=1:nClasses
    if(i==1)
        nPtsPerClasses(i)=sum(points >= 0 & points<classProb(i));
    else
        nPtsPerClasses(i)=sum(points >= sum(classProb(1:i-1)) & points<sum(classProb(1:i)));
    end
end


switch (typeData)
    case 'lines',
        if(~isfield(linesOpts,{'dist'}))
            error('Missing field in linesOpt');
        end
        labelVec = zeros(nSamples,1);
        % samples of first class
        samples  = [rand(1,nPtsPerClasses(1));zeros(1,nPtsPerClasses(1));]+ sqrt(noiseSigma)*randn(2,nPtsPerClasses(1));  
        labelVec(1:nPtsPerClasses(1),1) = 1;
        
        % calculate samples for each class
        nextPoint = nPtsPerClasses(1);        
        for i = 2:nClasses        
            samples(:,nextPoint+1:nextPoint+nPtsPerClasses(i))=[rand(1,nPtsPerClasses(i));...
                (i-1)*linesOpts.dist*ones(1,nPtsPerClasses(i))]+sqrt(noiseSigma)*randn(2,nPtsPerClasses(i));
            labelVec(nextPoint+1:nextPoint+nPtsPerClasses(i),1) = i; 
            nextPoint = nextPoint + nPtsPerClasses(i);
        end
        samples = samples';
        
    case 'two_moons',
        % numPos->first moon, numNeg->second moon
        numPos  = nPtsPerClasses(1); 
        numNeg  = nPtsPerClasses(2);
        radii   = ones(nSamples,1);
        phi     = rand(numPos+numNeg,1).*pi;

        samples  = zeros(2,nSamples);
        labelVec = zeros(nSamples,1);
        
        % caclulate samples of first moon
        for i = 1:numPos
            samples(1,i)  = radii(i)*cos(phi(i));
            samples(2,i)  = radii(i)*sin(phi(i));
            labelVec(i,1) = 1;
        end
        
        % calculate samples of second moon
        for i = numPos+1:numNeg+numPos
            samples(1,i)=1+radii(i)*cos(phi(i));
            samples(2,i)=-radii(i)*sin(phi(i))+0.5;
            labelVec(i,1)=2;
        end
        
        % add Gaussian noise
        samples = samples + sqrt(noiseSigma)*randn(2,nSamples);
        samples = samples';
        
    case 'circles',
        if(~isfield(circlesOpts,{'radius'}) || ~isfield(circlesOpts,{'center'}))
            error('Missing field in circlesOpts');
        end
        
        nextPoint = 0;
        for i = 1:nClasses
            theta   = linspace(0,2*pi,nPtsPerClasses(i));
            rho     = ones(1,nPtsPerClasses(i))*circlesOpts.radius(i);
            [x1,x2] = pol2cart(theta,rho);
            x1      = x1+circlesOpts.center(i,1)+sqrt(noiseSigma)*randn(1,nPtsPerClasses(i));
            x2      = x2+circlesOpts.center(i,2)+sqrt(noiseSigma)*randn(1,nPtsPerClasses(i));
            tmp     = [x1;x2];
            
            samples(:,nextPoint+1:nextPoint+nPtsPerClasses(i))  = tmp;          
            labelVec(nextPoint+1:nextPoint+nPtsPerClasses(i),1) = i; 
            nextPoint = nextPoint+nPtsPerClasses(i);
        end
        
        samples = samples';
    case 'gaussians',
        
        if(~isfield(gaussianOpts,{'covariance'}) || ~isfield(gaussianOpts,{'mean'}))
            error('Missing field in circlesOpts');
        end
        
        nextPoint = 0;
        samples  = zeros(2,nSamples);
        labelVec = zeros(nSamples,1);
        
        for i = 1:nClasses
            xtmp     = randn(nPtsPerClasses(i),2);
            xtmpMean = mean(xtmp);
            xtmp     = xtmp - repmat(xtmpMean,[nPtsPerClasses(i),1]);
            [R,p] = chol(gaussianOpts.covariance{i});
            if p>0
                xtmp = xtmp + sqrtm(gaussianOpts.covariance{i});
            else
                xtmp = xtmp*R;
            end
            xtmp = xtmp + repmat(gaussianOpts.mean(i,:),[nPtsPerClasses(i),1]);
            xtmp = xtmp + sqrt(noiseSigma)*randn(nPtsPerClasses(i),2);
            
            samples(:,nextPoint+1:nextPoint+nPtsPerClasses(i))  = xtmp';          
            labelVec(nextPoint+1:nextPoint+nPtsPerClasses(i),1) = i; 
            nextPoint = nextPoint+nPtsPerClasses(i);                    
        end
        samples = samples';
        
    otherwise,
        error('Wrong value of typeData')
end


% create figure to plot samples
if (strcmp(flagPlot,'true'))
   for classID = 1:max(labelVec)
       current_color = [rand rand rand];
       plot(samples(labelVec==classID,1), samples(labelVec==classID,2), ...
           'Color',current_color, 'MarkerSize',5,  'Marker','*','LineStyle','none');
       hold on
   end
   hold off
end

end