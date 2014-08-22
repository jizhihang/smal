function  insertRun( run,description )
%insert info for a specific run into 'runs' table of le_interconnection database

% make new database connection
conn = dbConnection;

values = {run,description};

% insert data into the database
colnames={'name','description'}; 
%fastinsert(connection,'tablename','colnames','matlabdata')
fastinsert(conn, 'runs', colnames, values);

% close our connection with the database
close(conn)
end

