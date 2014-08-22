function finalnumber=findmynumber(num)
% given a number (num) which denotes the number of images, the function
% computes a number (place) which the modulo(num,place)=0 to find the max
% number to use it as the number of batches in insertPredscores function.

% num = 4522;
x=1:num;
myrem=rem(num,x);
mymod=find(myrem==0);
iter=0;
place=[];
while isempty(place)
    place=find(mymod>100 & mymod<(500+iter));
    iter=iter+100;
end
finalnumber=mymod(max(place));