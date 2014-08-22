function idconcept = retrieveConcept( c )
% select and retrieve Concept ID from Concepts table of le_interconnection database
% -->call mainly from SocioDim/MakeOutputFile.m file<--
% make new database connection
conn = dbConnection;

SQLqueryConcept = ['select id from concepts where id = ''' num2str(c) ''' '];
%Execute the query on the database and fetch the data
idconcept = cell2mat(fetch(conn, SQLqueryConcept));
%Check if data are available for the given dates. If no data are
%available then give an error and stop execution
if (isempty(idimage)|| isempty(idrun) || isempty(idconcept))
    errordlg('No data were found with this name')
    close(conn); % close the connection on error
    return
end
%% close our connection with the database
close(conn)
end



