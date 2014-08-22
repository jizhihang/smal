function  idimage = retrieveImage( image )
% select and retrieve image ID from images table of le_interconnection database
% -->call mainly from SocioDim/MakeOutputFile.m file<--
% make new database connection
conn = dbConnection;
idimage = ones(numel(image),1);
for i = 1:numel(image)
% Construct SQL Query to take the id of a given image
SQLqueryImage = ['select Distinct max(id) from images where title = ''' image{i} ''' '];
%Execute the query on the database and fetch the data
idimage(i) =  cell2mat(fetch(conn, SQLqueryImage));
end
%Check if data are available for the given dates. If no data are
%available then give an error and stop execution
if (isempty(idimage))
    errordlg('No data were found with this name')
    close(conn); % close the connection on error
    return
end

%% close our connection with the database
close(conn)
end



