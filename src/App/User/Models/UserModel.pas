(*!------------------------------------------------------------
 * Fano Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-db
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-db/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit UserModel;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * model that load data from MySQL database
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------*)
    TUserModel = class(TInterfacedObject, IModelReader, IModelReadOnlyData, IDependency)
    private
        mysqlDb : IRdbms;
        resultSet : IRdbmsResultSet;
    public
        constructor create(const db : IRdbms);
        destructor destroy(); override;

        function read(const params : IModelWriteOnlyData = nil) : IModelReadOnlyData;
        function data() : IModelReadOnlyData;

        (*!------------------------------------------------
         * get total data
         *-----------------------------------------------
         * @return total data
         *-----------------------------------------------*)
        function count() : int64;

        (*!------------------------------------------------
         * test if in end of result set
         *-----------------------------------------------
         * @return true if no more record
         *-----------------------------------------------*)
        function eof() : boolean;

        (*!------------------------------------------------
         * move data pointer to next record
         *-----------------------------------------------
         * @return true if successful, false if no more record
         *-----------------------------------------------*)
        function next() : boolean;

        (*!------------------------------------------------
         * read data from current active record by its name
         *-----------------------------------------------
         * @return value in record
         *-----------------------------------------------*)
        function readString(const key : string) : string;
    end;

implementation

uses

    Classes,
    SysUtils;

    constructor TUserModel.create(const db : IRdbms);
    begin
        mysqlDb := db;
        resultSet := nil;
    end;

    destructor TUserModel.destroy();
    begin
        inherited destroy();
        mysqlDb := nil;
        resultSet := nil;
    end;

    function TUserModel.read(
        const params : IModelWriteOnlyData = nil
    ) : IModelReadOnlyData;
    begin
        resultSet := mysqlDb.exec('SELECT * FROM users');
        result := self;
    end;

    function TUserModel.data() : IModelReadOnlyData;
    begin
        result := self;
    end;

    (*!------------------------------------------------
     * get total data
     *-----------------------------------------------
     * @return total data
     *-----------------------------------------------*)
    function TUserModel.count() : int64;
    begin
        result := resultSet.resultCount();
    end;

    (*!------------------------------------------------
     * test if in end of result set
     *-----------------------------------------------
     * @return true if no more record
     *-----------------------------------------------*)
    function TUserModel.eof() : boolean;
    begin
        result := resultSet.eof();
    end;

    (*!------------------------------------------------
     * move data pointer to next record
     *-----------------------------------------------
     * @return true if successful, false if no more record
     *-----------------------------------------------*)
    function TUserModel.next() : boolean;
    begin
        result := not resultSet.eof();
        resultSet.next();
    end;

    (*!------------------------------------------------
     * read data from current active record by its name
     *-----------------------------------------------
     * @return value in record
     *-----------------------------------------------*)
    function TUserModel.readString(const key : string) : string;
    begin
        result := resultSet.fields().fieldByName(key).asString;
    end;
end.
