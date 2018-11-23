(*!------------------------------------------------------------
 * Fano Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-db
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-db/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit UserControllerFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TUserController
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------*)
    TUserControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    UserController;

    function TUserControllerFactory.build(const container : IDependencyContainer) : IDependency;
    var routeMiddlewares : IMiddlewareCollectionAware;
        config : IAppConfiguration;
        viewParams : IViewParameters;
    begin
        routeMiddlewares := container.get('routeMiddlewares') as IMiddlewareCollectionAware;
        try
            //get instance of application from dependency container
            config := container.get('config') as IAppConfiguration;

            //get new instance of viewParams from dependency container
            viewParams := container.get('viewParams') as IViewParameters;

            //set some value. Following command will replace
            //any {{baseUrl}} {{appName}} in template HTML with actual
            //value from json configuration
            viewParams
                .setVar('baseUrl', config.getString('baseUrl'))
                .setVar('appName', config.getString('appName'));

            //create the controller
            result := TUserController.create(
                routeMiddlewares.getBefore(),
                routeMiddlewares.getAfter(),
                //use userListingView as view
                container.get('userListingView') as IView,
                viewParams,
                //use model registered in user.list
                container.get('userListModel') as IModelReader
            );
        finally
            routeMiddlewares := nil;
        end;
    end;
end.
