function dbBulkInsert(db_table, fieldNames, fieldTypes, varargin)

% dbBulkInsert(db_table, fieldNames, fieldTypes, data1, data2, ...)
%
% 2010 Jul WY
%   1) uses "insert ... select UNION ALl select ... "
%   2) sprintf instead of num2str
%   3) matrix print, instead of looping over column
%   4) it handles batch, 100 lines at a time, no huge mem overhead
%   5) accepts multiple input matrices with different type 
% 
% fieldTypes:
%   'datenum', e.g. 734324
%   'datestr', 'date', 'char', 'str'
%   'double', 'float', 'integer', 'int'

VARNUM  = length(varargin);
if VARNUM <1
    me  = MException('MATLAB:INPUT:MISSING', 'No Data Specified');
    throw (me);
end

BATCH   = 100;
N       = size(varargin{1},1);
M       = length(fieldNames);

% construct format string
format  = fieldTypes;
format  = strrep(format, 'float',   '%0.8g');
format  = strrep(format, 'double',  '%0.8g');
format  = strrep(format, 'integer', '%d');
format  = strrep(format, 'int',     '%d');
format  = strrep(format, 'char',    '''%s''');
format  = strrep(format, 'str',     '''%s''');
format  = strrep(format, 'datenum', '''%s''');
format  = strrep(format, 'date',    '''%s''');
format  = cell2list(format);

stmtBegin   = ['insert ' db_table '(' cell2list(fieldNames) ') '];

% conn    = dbConnect(db_srvr, 'cellarray');
conn = dbConnection;

tic;
for ib=1:BATCH:N,
    
    iHead   = ib;
    if (iHead + BATCH -1 > N)
        iTail   = N;
    else
        iTail = iHead + BATCH -1;
    end

    % construct batch as cell array
    batch   = cell(iTail-iHead+1, M);
    offset  = 0;
    for iv = 1:VARNUM
        VARLEN  = size(varargin{iv}, 2);
        if isnumeric(varargin{iv})
            if (strcmp('date', fieldTypes(offset+1)) || strcmp('datenum', fieldTypes(offset+1)))
                batch(:, offset+1:offset+VARLEN) = cellstr(datestr(varargin{iv}(iHead:iTail,:), 'yyyymmdd'));
            else
                batch(:, offset+1:offset+VARLEN) = num2cell(varargin{iv}(iHead:iTail,:));
            end
        else
            batch(:, offset+1:offset+VARLEN) = varargin{iv}(iHead:iTail,:);
        end
        
        offset  = offset + VARLEN;
    end
    
    % use the result of cell array
    stmtLine    = '';
    for i = 1:iTail-iHead+1
        
        if i~=1
            stmtLine    = [stmtLine ' union all '];
        end
        stmtLine    = [stmtLine 'select ' sprintf(format, batch{i, :})];
    end

    stmt    = [stmtBegin stmtLine ];
    stmt    = strrep(stmt, 'NaN', 'Null');
    
    curs    = exec(conn, stmt);
    TIME    = toc;
%     disp([num2str(iTail) ' rows in ' num2str(TIME) ' sec']);
    
end
time2 = toc;
% disp([num2str(iTail) ' rows in ' num2str(time2) ' sec']);
dbClose(conn);

