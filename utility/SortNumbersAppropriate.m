% given a directory this functions sorts the name of files appropriately.
% Example:
% given the table names = {'a1.txt','a10.txt','a2.txt','a100.txt'}; [replace lines 8 and 9]
% the output is the table names names =
% {'a1.txt','a2.txt','a10.txt','a100.txt'} [replace line 14 with names = names(sortOrder)]

path = 'D:\lena\Codes\MyCodes\LaplacianEigenmaps_Code\results\featuresmediaeval\rgb)';
dstruct =  dir([path '*.txt']);
names = {dstruct.name};
maxlen = max(cellfun(@length, names));
padname = @(s) sprintf(['%0' num2str(maxlen) 's'], s);
namesPadded = cellfun(padname, names, 'UniformOutput', false);
[~, sortOrder] = sort(namesPadded);
dstruct = dstruct(sortOrder);