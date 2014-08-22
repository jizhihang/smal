function  insertImages
% insert images of a specific dataset into the specific database
% as denoted in dbConnection function
clear all
% set paths
pathTrainTestLabelsSet = '//ITI-195/smal/matlab/results/data/';
% metadata directory
tagsdir = 'D:\Image_Clef_2012\dataset\test_metadata\tags_raw\';
% username directory
userdir = 'D:\Image_Clef_2012\dataset\test_metadata\license\';

% make new database connection
conn = dbConnection;

% take tha id of the sorted images
currentfolder='twitter2013\';
fid = fopen([pathTrainTestLabelsSet,currentfolder 'graphicsID.txt']);
image = textscan(fid,'%q');
image = image{1};
fclose(fid)

image = importdata([pathTrainTestLabelsSet,currentfolder 'graphicsID.txt']);

% set the path that contains the original images
curDir = '\twitter13\';
% insert the appropriate data into the database
for i =1:length(image)
    %     uncomment if you want to insert metadata and username info to the
    %     database
    %     tags = [];
    %     % take the tags of an image
    %     imagename   = [ tagsdir, image{i},'.txt'];
    %     text =  textread(imagename,'%s');
    %     for j=1:length(text)
    %         tags = [tags ' ' char(text{j})];
    %     end
    %     %take the username of the user who took the photo
    %     username = [userdir, image{i},'.txt'];
    %     file = textread(username, '%s', 'delimiter', '\n', 'whitespace', '');
    %     ind = strmatch('Owner username', file);
    %
    %     [~, remain] = strtok(file{ind,:}, ':');
    %     [str, ~] = strtok(remain, ': ');
    
    %     path = [curDir,image{i},'.jpg'];
    path = [curDir,image{i},'.jpg'];
    % create one table of all the info we want to upload in database
    data{i,1} = image{i};
    data{i,2} = '';%tags;
    data{i,3} = path;
    data{i,4} = '';%str;
    
end
disp('ok');
% insert data into the database
colnames={'title','text','path','user'};
%fastinsert(connection,'tablename','colnames','matlabdata')
fastinsert(conn, 'images', colnames, data);

% close our connection with the database
close(conn);
end



