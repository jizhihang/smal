function  insertConcepts
% insert the concepts of a specific dataset into the specific database
% as denoted in dbConnection function
clear all;
pathTrainTestLabelsSet = '../results/data/';
currentfolder='\Flickr13\';
fid = fopen([pathTrainTestLabelsSet, currentfolder 'flickr13_concept.txt']);
concept = textscan(fid,'%q');
concept = concept{1};

% make new database connection
conn = dbConnection;
if ~isconnection(conn)
   
    error(message('database:fastinsert:invalidConnection'))
   
end
% %Construct the SQL query
% SQLquery = 'select name from concepts where id = 2';
% %Execute the query on the database and fetch the data
% results = fetch(NewConn, SQLquery)
% %Check if data are available for the given query. If no data are
% %available then give an error and stop execution
% if (isempty(results))
%     errordlg('No patients were found within that date range')
%     close(NewConn); % close the connection on error
% return
% end

%fastinsert(connection,'tablename','colnames','matlabdata')
colnames={'id','name'};
for i=1:numel(concept)
    cons{i,1} = i;
    cons{i,2} = concept{i};
end
fastinsert(conn, 'concepts', colnames, cons);
% close our connection with the database
close(conn)
end

