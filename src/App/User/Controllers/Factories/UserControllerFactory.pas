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
    var config : IAppConfiguration;
        viewParams : IViewParameters;
    begin
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
            //use userListingView as view
            //see views.dependencies.inc
            container.get('userListingView') as IView,
            viewParams,
            //use model registered in userListModel
            //see models.dependencies.inc
            container.get('userListModel') as IModelReader
        );
    end;
end.
