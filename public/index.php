<?php
//ini_set('display_errors', 1);
//error_reporting(E_ALL);
//set_time_limit(0);
header("Content-type:text/html;charset=utf-8");
date_default_timezone_set ('Asia/Shanghai');
//定义系统模块路径
//defined('__PUBLIC__') || define('__PUBLIC__', __DIR__);
//defined('__ROOT__')   || define('__ROOT__', realpath(__DIR__.'/../'));
defined('__PUBLIC__') || define('__PUBLIC__', dirname(__FILE__));
defined('__ROOT__')   || define('__ROOT__', dirname(dirname(__FILE__)));
defined('__CONFIG__') || define('__CONFIG__', __ROOT__.'/config');
defined('__DOMAINURL__') or define('__DOMAINURL__','http://m.9939.com');
defined('APP_ROOT')   || define('APP_ROOT', __ROOT__);

defined("FRAMEWORK_PATH") or define("FRAMEWORK_PATH", "/data/www/develop/code/trunk");
//defined("FRAMEWORK_PATH") or define("FRAMEWORK_PATH","/data/web/framework");
defined("ZEND_PATH") or define("ZEND_PATH", FRAMEWORK_PATH . '/QFramework2.0');
//设置包含文件查询路径
set_include_path(implode(PATH_SEPARATOR, array(
    __ROOT__.'/library',ZEND_PATH,
    get_include_path(),
)));

/****************************************************
 * 说明：此自动加载会与Smarty的自动加载冲突
 * 2013-05-01
	require_once 'Zend/Loader.php';
	function __autoload($classname)
	{
		Zend_Loader::loadClass($classname);
	}
****************************************************/

require_once "Zend/Loader/Autoloader.php";
$autoloader = Zend_Loader_Autoloader::getInstance();
$autoloader->registerNamespace(array('App','Helei', 'Q',  'QConfigs',  'QLib',  'QModels'));



// +-------------------------------------------------------------------------
// | 读取站点配置文件，获取配置信息
// | Edit By Helei @ 2014-01-21
// +-------------------------------------------------------------------------
$siteconf = new Zend_Config_Xml(__CONFIG__.'/SiteConfig.xml');
defined('__TITLE__')       || define('__TITLE__', $siteconf->Title);
defined('__KEYWORDS__')    || define('__KEYWORDS__', $siteconf->Keywords);
defined('__DESCRIPTION__') || define('__DESCRIPTION__', $siteconf->Description);
defined('__SKIN__')        || define('__SKIN__', $siteconf->Skin);
defined('__UploadDir__')   || define('__UploadDir__', $siteconf->UploadDir);

$uri = $_SERVER['REQUEST_URI'];
if (stripos($uri, "?") !== false){
    $uri_arr = explode('?', $uri);
    $uri = $uri_arr[0];
}

// +-------------------------------------------------------------------------
// | 定义前端控制器 
// | Edit By Helei @ 2013/02/24 16:20
// +-------------------------------------------------------------------------
$front = Zend_Controller_Front::getInstance();
//设置视图属性
$front->setParam('noViewRenderer', true);
//创建路由
$router = $front->getRouter();
//============================ 2015-12-11: 新增 【热搜】、【专题】部分 Start ==========================//
QConfigs_Defines::setVaribles('local');
//============================ 2015-12-11: 新增 【热搜】、【专题】部分 End ==========================//

$uri_info = trim($uri, '/');
$url_path_params = explode("/", $uri_info);
if(!in_array(strtolower($url_path_params[0]), array('jb','disease','zhuanti','bottom','symptom','crontab','pic','order','images'))){
    $last_url_name = $url_path_params[count($url_path_params) - 1];
    $curr_path_arr = array();
    switch (strtolower($last_url_name)) {
            case "nav.shtml":{
                $curr_path_arr = array_slice($url_path_params, 0, -1); 
                $route_path =  implode('/', $url_path_params);
                $route_key = implode('-', $url_path_params);
                $route_key = 'lists_channel_nav_'.$route_key;
                $action_name = 'nav';
                $router->addRoute($route_key,
                    new Zend_Controller_Router_Route($route_path,
                        array(
                            'controller'=>'Channel',
                            'action'=>$action_name
                        )
                    )
                );
                break;
            }
            case "list.shtml": {
                $curr_path_arr = array_slice($url_path_params, 0, -1); 
                $route_path =  implode('/', $url_path_params);
                $route_key = implode('-', $url_path_params);
                $route_key = 'lists_channel_list_'.$route_key;
                $action_name = 'list';
                $router->addRoute($route_key,
                    new Zend_Controller_Router_Route($route_path,
                        array(
                            'controller'=>'Channel',
                            'action'=>'list'
                        )
                    )
                );
                break;
            }
            default: {
                if (stripos($last_url_name, '.shtml') !== false) {
                    $curr_path_arr = array_slice($url_path_params, 0, -1);
                } else {
                    $curr_path_arr = $url_path_params;
                    $route_path = implode('/', $url_path_params);
                    if(!empty($route_path)){
                        $route_key = implode('-', $url_path_params);
                        $route_key = 'channel_dispatch_'.$route_key;
                        if(count($curr_path_arr)>1){
                            $router->addRoute($route_key,
                                new Zend_Controller_Router_Route($route_path,
                                    array(
                                        'controller'=>'Channel',
                                        'action'=>'dispatch'
                                    )
                                )
                            );
                        }else{
                            $router->addRoute('Channel_'.$curr_path_arr[0],
                                new Zend_Controller_Router_Route($curr_path_arr[0],
                                    array(
                                    'controller'=>'Channel',
                                    'action'=>'index'
                                    )
                                )
                            );
                        }
                    }
                }
                break;
            }
    }  
}
$routers = require '../application/router.php';
$router->addRoutes($routers);

//设置参数
$front->addModuleDirectory(__ROOT__.'/application/modules');
$front->setDefaultModule('wap');

$error_plugin = new Zend_Controller_Plugin_ErrorHandler(
        array(
            'module'=>'wap',
            'controller'=>'index',
            'action'=>'error'
        )
);
$front->registerPlugin($error_plugin);
$front->throwExceptions(true);
$front->dispatch();







