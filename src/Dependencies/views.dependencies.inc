(*!------------------------------------------------------------
 * Fano MVC Sample Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-mvc.git
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-mvc/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your dependencies registration here---}

{-----------------------------------------------
  file reader utility
------------------------------------------------}
container.add('fileReader', TStringFileReaderFactory.create());

{-----------------------------------------------
  register view parameters. use of factory() method
  will cause container.get('viewParams') call
  always return new instance
------------------------------------------------}
container.factory('viewParams', TViewParametersFactory.create());

{-----------------------------------------------
  setup html template parser
------------------------------------------------}
container.add('templateParser', TSimpleTemplateParserFactory.create());

{-----------------------------------------------
  header view
------------------------------------------------}
container.add('headerView', THeaderViewFactory.create());

{-----------------------------------------------
  footer view
------------------------------------------------}
container.add('footerView', TFooterViewFactory.create());

{-----------------------------------------------
  user listing view
------------------------------------------------}
container.add('userListingView', TUserListingViewFactory.create());
