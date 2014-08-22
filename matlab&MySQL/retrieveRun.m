function idrun = retrieveRun( run )
% select and retrieve Run ID from Runs table of le_interconnection database
% -->call mainly from SocioDim/MakeOutputFile.m file<--

% make new database connection
conn = dbConnection;

% Construct SQL Query to take the id of a given run
SQLqueryRun = ['select id from runs where name = ''' run ''' '];
%Execute the query on the database and fetch the data
idrun = cell2mat(fetch(conn, SQLqueryRun));

%Check if data are available for the given dates. If no data are
%available then give an error and stop execution
if (isempty(idrun))
    errordlg('No data were found with this name')
    close(conn); % close the connection on error
    return
end
%% close our connection with the database
close(conn)
end


