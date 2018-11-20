{*!
 * Fano Web Framework (https://fano.juhara.id)
 *
 * @link      https://github.com/zamronypj/fano
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/zamronypj/fano/blob/master/LICENSE (GPL 3.0)
 *}

unit DbFactory;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!------------------------------------------------
     * basic class having capability to
     * handle create mysql database
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *-------------------------------------------------*)
    TDbFactory = class(TFactory)
    public

        (*!---------------------------------------------------
         * build class instance
         *----------------------------------------------------
         * @param container dependency container instance
         *---------------------------------------------------*)
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

    (*!---------------------------------------------------
     * build class instance
     *----------------------------------------------------
     * @param container dependency container instance
     *---------------------------------------------------*)
    function TDbFactory.build(const container : IDependencyContainer) : IDependency;
    var db : IRdbms;
        config : IAppConfiguration;
    begin
        config := container.get('config') as IAppConfiguration;
        db := TMySQLDb.create(config.getString('db.mysql.version'));
        db.connect(
            config.getString('db.mysql.host'),
            config.getString('db.mysql.database'),
            config.getString('db.mysql.username'),
            config.getString('db.mysql.password'),
            config.getInt('db.mysql.port')
        );
        result := db as IDependency;
    end;

end.
