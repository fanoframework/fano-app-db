(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

 {-----------------------------------------------
   register middleware list for each routes that
   does nothing,
   need to be use factory so each route will have
   different middleware list
   Replace with TMiddlewareCollectionAwareFactory to support middleware
   or replace with your own implementation if required
 ------------------------------------------------}
 container.factory('routeMiddlewares', TNullMiddlewareCollectionAwareFactory.create());

{-----------------------------------------------
  register application configuration
------------------------------------------------}
container.add(
    'config',
    TJsonFileConfigFactory.create(
        extractFileDir(getCurrentDir()) + '/src/config/config.json'
    )
);
