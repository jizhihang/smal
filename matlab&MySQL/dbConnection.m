function conn = dbConnection
% connects with the database using the credentials bellow
% u must install ODBC driver and in administrator tools insert the db connection
% then from matlab call querybuilder to confirm the connection!
% database info
dbUsername = 'root'; %Username for the database
dbPassword = 'imageclef'; %Password associated with the above username

%Create the connection to the database with the credentials specified above
conn = database('twitter13',dbUsername,dbPassword);
% le_interconnection, flickr2013
if ~isconnection(conn)
   
    error(message('database:fastinsert:invalidConnection'))
end
end

