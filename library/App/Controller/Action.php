<?php

/**
 * 基础表，可以在此完成一些公共Controller，供继承词类的类使用
 *
 */
class App_Controller_Action extends Q_Controller_Smarty {

    public $url_path_params = array();
    public $channel_enname = '';
    public $pc_root_channel_url = '';
    public $wap_root_channel_url = '';
    public $cate_info_params = array();
    public $user_agent = '';
    public function init() {
        parent::init();
        $this->initVaribles();
        $this->enableCache();
        $this->user_agent = QLib_Utils_Function::getuseragent();
    }

    private function initVaribles() {
        header('Cache-Control:max-age=3600');
        $uri = trim($_SERVER['REQUEST_URI'], '/');
        if (stripos($uri, "?") !== false){
            $uri_arr = explode('?', $uri);
            $uri = $uri_arr[0];
        }
        if (empty($uri)) {
            $this->pc_root_channel_url = 'http://www.9939.com';
            $this->wap_root_channel_url = __DOMAINURL__;
            $curr_cate_info = array();
            $curr_cate_info['pc_url'] = trim($this->pc_root_channel_url, '/') . '/';
            $curr_cate_info['wap_url'] = trim($this->wap_root_channel_url, '/') . '/';
            $this->cate_info_params = $curr_cate_info;
        } else {
            $this->url_path_params = explode("/", $uri);
            $this->channel_enname = $this->url_path_params[0];
            $this->pc_root_channel_url = sprintf('http://%s.9939.com/', $this->channel_enname);
            $domain = str_replace('//', '/', '/' . $this->channel_enname . '/');
            $this->wap_root_channel_url =__DOMAINURL__.$domain;

            $last_url_name = $this->url_path_params[count($this->url_path_params) - 1];
            $curr_path_arr = array();
            switch (strtolower($last_url_name)) {
                case "nav.shtml":
                case "list.shtml": {
                        $curr_path_arr = array_slice($this->url_path_params, 0, -1);
                        break;
                    }
                default: {
                        if (stripos($last_url_name, '.shtml') !== false) {
                            $curr_path_arr = array_slice($this->url_path_params, 0, -1);
                        } else {
                            $curr_path_arr = $this->url_path_params;
                        }
                        break;
                    }
            }
            array_splice($curr_path_arr, 0, 1, trim($this->wap_root_channel_url, '/'));
            $wap_url = implode('/', $curr_path_arr);

            array_splice($curr_path_arr, 0, 1, trim($this->pc_root_channel_url, '/'));
            $curl_url = implode('/', $curr_path_arr);
            $cate_url_model = new App_Model_Categoryurl();
            $curr_cate_info = $cate_url_model->getCatidByURL($curl_url);
            if (!empty($curr_cate_info)) {
                $curr_cate_info['channel_enname'] = $this->channel_enname;
                $curr_cate_info['channel_url'] = $this->wap_root_channel_url;
                $parent_ids = explode(",", $curr_cate_info['arrparentid']);
                $curr_cate_info['channel_id'] = count($parent_ids) >= 2 ? $parent_ids[1] : 0;
                $curr_cate_info['lum_id'] = count($parent_ids) >= 3 ? $parent_ids[2] : $curr_cate_info['catid'];

                $curr_cate_info['pc_url'] = trim($curr_cate_info['url'], '/') . '/';
                $curr_cate_info['wap_url'] = trim($wap_url, '/') . '/';
                $this->cate_info_params = $curr_cate_info;
                
                /* echo '<pre>';
                  print_r($this->cate_info_params) ;
                  echo '</pre>';
                  exit; */
            }
        }
    }

    /**
     * 
     * @param type $template 模板名称
     * @param type $cache_key 缓存键
     */
    public function display($template, $cache_key) {
        $smart = $this->view->getEngine();
        if ($smart->isCached($template, $cache_key)) {
            $smart->display($template, $cache_key);
            exit;
        }
    }
    /**
     * 开启smarty缓存
     */
    public function enableCache(){
        /*$smart = $this->view->getEngine();
        $smart->caching = true;
        $smart->cache_lifetime =18000;// 3600;
        $smart->setCacheDir(APP_CACHE_PATH.DIRECTORY_SEPARATOR.'pages'.DIRECTORY_SEPARATOR.'smarty_pages');
        $smart->setCompileDir(APP_CACHE_PATH.DIRECTORY_SEPARATOR.'templates_c');*/
    }
    
    public function disableCache(){
        $smart = $this->view->getEngine();
        $smart->caching = false;
        $smart->cache_lifetime =18000;// 3600;
    }

    /**
     * 解析拆分 url
     * @author gaoqing
     * 2015年10月26日
     * @param string $url 要被拆分的 url
     * @return array 拆分后的 url 数组
     */
    public function resolveURL($url) {
        $urlArr = array();

        if (isset($url) && !empty($url)) {
            preg_match("/http:\/\/([\s\S]*?).9939.com\/?([\s\S]*?)\/?$/", $url, $urlArr);
        }
        return $urlArr;
    }

}
