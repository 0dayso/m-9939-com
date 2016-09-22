<?php

/**
 * @Desc :  专题 热搜
 */
class ZhuantiController extends App_Controller_Action {

    public $domain;
    public $host;
    public $pc_zhuanti_url;
    public $_zxads_obj = null;

    public function init() {
        parent::init();
        $this->view->controllername = $this->getRequest()->getControllerName();
        $this->view->actionname = $this->getRequest()->getActionName();

        $this->ask_obj = new App_Model_Ask();
        $this->answer_obj = new App_Model_Answer();
        $this->wd_obj = new App_Model_KeyWords();
        $this->search_obj = new App_Model_Search();
        $this->_categoryurl_obj = new App_Model_Categoryurl();
        $this->_zxads_obj = new App_Model_Zxads();
        
        $domainname = 'm';
        $this->view->domainname = $domainname;
        $this->view->domainurl =$this->wap_root_channel_url;// 'http://' . $domainname . '.9939.com/zhuanti/';
        $this->view->base_include_path = __DOMAINURL__;
        $this->view->searchurl =$this->wap_root_channel_url;// 'http://' . $domainname . '.9939.com/zhuanti/';
        $this->view->letterurl =$this->wap_root_channel_url;// 'http://' . $domainname . '.9939.com/zhuanti/';
        $this->domain =$this->wap_root_channel_url;// 'http://' . $domainname . '.9939.com/zhuanti/';
        $this->host = __DOMAINURL__.'/';
        $this->pc_zhuanti_url = 'http://www.9939.com/zhuanti/';
        
    }
    
    function fillSuffix(){
        $uristr = $_SERVER['REQUEST_URI'];
        if ($pos = strpos($uristr, '?')) {
            $uristr = substr($uristr, 0, $pos);
        }
        if(($last_char =  substr($uristr, -1) )!='/'){
            $redirect_url = 'http://'.$_SERVER['HTTP_HOST'].$uristr.'/';
            if($this->_hasParam('page')){
                $page = $this->_getParam('page',1);
                $redirect_url.='?page='.$page;//http_build_query($paramsArr);
            }
            header("Location:$redirect_url", true, 301);
            exit;
        }
    }

    //热搜专题 字母页
    public function indexAction() {

        $page_title = "久久热搜专题_健康管理库_久久健康网";
        $page_keywords = "久久健康,健康专题,健康管理,久久热搜";
        $page_description = "久久健康网（9939.com）-久久热搜专题频道为您提供最全面的热搜健康专题、疾健康知识、健康养生、健康管理库，是您健康生活的好帮手！";
        $this->view->metaTitle = $page_title;
        $this->view->metaKeywords = $page_keywords;
        $this->view->metaDescription = $page_description;
        $this->view->pc_zhuanti_url = $this->pc_zhuanti_url;

        $this->view->rand_words = $this->rand_words();
        $this->loadletterlist();
        $browser = $this->user_agent;
        $ads_uc = '';
        if($browser == 'uc'){
            $ads_uc = $this->_zxads_obj->ads(4566); //uc广告
        }else{
            $ads_uc = $this->_zxads_obj->ads(4497); //uc广告
        }
        $ads_4567 = $this->_zxads_obj->ads(4567); //4567
        $this->view->assign('ads_uc',$ads_uc);
        $this->view->assign('ads_4567',$ads_4567);
        echo $this->view->render('zhuanti/index.tpl');
    }

    //热搜专题 列表页
    public function listsAction() {
//        $template_path = 'zhuanti/lists.tpl';
        $template_path = 'zhuanti/lists_new.tpl';
        $url = md5($_SERVER['REQUEST_URI']);
        $browser = $this->user_agent;
        $ads_uc = '';
        if($browser == 'uc'){
            $ads_uc = $this->_zxads_obj->ads(4566); //uc广告
        }else{
            $ads_uc = $this->_zxads_obj->ads(4497); //uc广告
        }
        $this->view->assign('ads_uc',$ads_uc);
        $this->display($template_path, $url);
        //搜索拼音
        $search = $this->_getParam('wd', '');
       //页码
        $page = $this->_getParam('page', 0);
        $size = 10;
        
        $wd_list = $this->wd_obj->getKeywordName($search);
        $wd_name = $wd_list['keywords'];
        
        $offset = ($page-1)*$size + 18;
        $result = $this->search_relarticle($wd_name, $offset, $size);
        if(count($result['list'])==0){
            $result = $this->search_relarticle($wd_name, 0, $size);
            $page=1;
        }
        $total = $result['total'];
        $totalpage = ceil($total / $size);
        $totalpage = max($totalpage,1);
        $articles = array();
        foreach ($result['list'] as $k => $v) {
            $articles[$k] = $v;
            $parse_result = $this->parseArtUrl($v);
            $domain = $parse_result['domain'];
            $art_file_name = $parse_result['art_file_name'];
            $art_wap_url = $this->host.$domain . '/article/' .$art_file_name;
            $articles[$k]['url'] = $art_wap_url;
            $articles[$k]['title'] = strip_tags($v['title']);
            if(isset($v['content'])){
                $content = strip_tags($v['content']);
                $articles[$k]['description'] = QLib_Utils_String::cutString($content, 32,1);
            } else {
                $description = strip_tags($v['description']);
                $articles[$k]['description'] = QLib_Utils_String::cutString($description, 32,1);
            }
        }
        
        $this->view->search = $search;
        $this->view->search_name = $wd_name;
        $this->view->articles = $articles;
        $this->view->curpage = $page;
        $this->view->totalpage = $totalpage;

        $this->view->prepage = $this->domain . $search . '/' . (($page <= 1) ? 1 : ($page - 1)) . '/';
        $this->view->nextpage = $this->domain . $search . '/' . (($page >= $totalpage) ? $totalpage : ($page + 1)) . '/';

        $page_title = "{$wd_name}_久久热搜专题_久久健康网";
        $page_keywords = "{$wd_name},{$wd_name}专题,{$wd_name}相关知识";
        $page_description = "久久健康网您提供包括{$wd_name}相关知识，{$wd_name}热门问答,{$wd_name}相关疾病等介绍，帮助大家及时了解及预防疾病！";
        $this->view->metaTitle = $page_title;
        $this->view->metaKeywords = $page_keywords;
        $this->view->metaDescription = $page_description;
        $this->view->pc_zhuanti_search_url = $this->pc_zhuanti_url.$search.'/';
        //相关热词
        $rel_keywords_len = 8;
        $relateWords = $this->relate_words($wd_name, 0, 20);
        $this->view->relateWords = array_slice($relateWords['list'], 0, $rel_keywords_len);
        
        $ads_4567 = $this->_zxads_obj->ads(4567); //4567
        $this->view->assign('ads_4567',$ads_4567); //4567

        echo $this->view->render($template_path, $url);
    }

    /**
     * 热搜词页
     */
    public function searchAction() {
//        $template_path = 'zhuanti/search.tpl';
        $template_path = 'zhuanti/search_new.tpl';
        $url = md5($_SERVER['REQUEST_URI']);
        $browser = $this->user_agent;
        $ads_uc = '';
        if($browser == 'uc'){
            $ads_uc = $this->_zxads_obj->ads(4566); //uc广告
        }else{
            $ads_uc = $this->_zxads_obj->ads(4497); //uc广告
        }
        $this->view->assign('ads_uc',$ads_uc);
        $this->display($template_path, $url);

        $search = $this->_getParam('wd', '');
        $wd_list = $this->wd_obj->getKeywordName($search);
        $wd_name = $wd_list['keywords'];

        $offset = 0;
        $size = 18;
        $result = $this->search_relarticle($wd_name, $offset, $size);
        $total =$result['total'];
        $articles = array();
        foreach ($result['list'] as $k => $v) {
            $articles[$k] = $v;
            $parse_result = $this->parseArtUrl($v);
            $domain = $parse_result['domain'];
            $art_file_name = $parse_result['art_file_name'];
            $art_wap_url = $this->host.$domain . '/article/' .$art_file_name;
            $articles[$k]['url'] = $art_wap_url;
            $articles[$k]['title'] = strip_tags($v['title']);
            if(isset($v['content'])){
                $content = strip_tags($v['content']);
                $articles[$k]['description'] = QLib_Utils_String::cutString($content, 32,1);
            } else {
                $description = strip_tags($v['description']);
                $articles[$k]['description'] = QLib_Utils_String::cutString($description, 32,1);
            }
        }
        $articles_one = array_slice($articles, 0, 6);
        $articles_pic = array_slice($articles, 6, 1);
        $articles_two = array_slice($articles, 7, 6);
        $articles_three = array_slice($articles, 13);
        
        $this->view->articles_one = $articles_one;
        $this->view->articles_pic = $articles_pic;
        $this->view->articles_two = $articles_two;
        $this->view->articles_three = $articles_three;
        $this->view->search = $search;
        $this->view->search_name = $wd_name;
        $this->view->total = $total;


        $page_title = "{$wd_name}_久久热搜专题_久久健康网";
        $page_keywords = "{$wd_name},{$wd_name}专题,{$wd_name}相关知识";
        $page_description = "久久健康网您提供包括{$wd_name}相关知识，{$wd_name}热门问答,{$wd_name}相关疾病等介绍，帮助大家及时了解及预防疾病！";
        $this->view->metaTitle = $page_title;
        $this->view->metaKeywords = $page_keywords;
        $this->view->metaDescription = $page_description;
        $this->view->pc_zhuanti_search_url = $this->pc_zhuanti_url.$search.'/';
        //相关热词
        $rel_keywords_len = 8;
        $relateWords = $this->relate_words($wd_name, 0, 20);
        $this->view->relateWords = array_slice($relateWords['list'], 0, $rel_keywords_len);
        
        $ads_4567 = $this->_zxads_obj->ads(4567); //4567
        $this->view->assign('ads_4567',$ads_4567); //4567
        echo $this->view->render($template_path, $url);
    }

    private function loadletterlist() {
        $letter_list = 'abcdefghijklmnopqrstuvwxyz';
        $len = strlen($letter_list);
        $return_list = array();
        for ($i = 0; $i < $len; $i++) {
            $l = strtoupper($letter_list{$i});
            $return_list[$l] = array(
                'url' => sprintf('%s%s/', $this->view->letterurl, $l),
                'selected' => ($this->view->letter == $l) ? 1 : 0
            );
        }

        $this->view->letter_list = $return_list;
    }

    //随机热词
    private function rand_words(){
        $letter_list = 'abcdefghijklmnopqrstuvwxyz';
        $len = strlen($letter_list);
        $return_list = array();
        $max_kw_length = 100;
        $max_dis_length =30; 
        $filter_array = $this->getFilterArray();
        $cache_rand_words = App_Model_KeyWords::getCacheRandWords($max_kw_length, $filter_array);
        for ($i = 0; $i < $len; $i++) {
            $wd = strtoupper($letter_list{$i});
            $ret = $cache_rand_words[$wd];
            if(count($ret)>0){
                $rand_num = count($ret)>$max_dis_length?30:count($ret);
                $rand_keys = array_rand($ret,$rand_num);
                if(is_array($rand_keys)){
                    foreach($rand_keys as $k){
                        $return_list[$wd][] = $ret[$k];
                    }
                }else{
                     $return_list[$wd][] = $ret[0];
                }
            }else{
                $return_list[$wd]=array();
            }
        }
        return $return_list;
    }
    /**
     * 
     * @param array $v 文章记录
     */
    private function parseArtUrl($v){
        $articleid = 0; 
        $domain = '';
        $art_url = strtolower($v['url']);
        $tmp_source_id = $v['tmp_source_id'];
        $path_arr = explode('/', $art_url);
        if($tmp_source_id==2){
            $domain = 'jb';
            $articleid = $v['id'];
        }else{
            $articleid = $v['articleid'];
            if(stripos($art_url, 'http://')===false){
                $catid = $v['catid'];
                if($catid){
                    $wheres=" catid=".$catid;
                    $ret_cat=$this->_categoryurl_obj->getcategory($wheres);
                    if($ret_cat){
                        $cat_url =  $ret_cat[0]['url'];
                        $cat_path_arr=explode("/",$cat_url);
                        $boot_domain_arr = explode('.',$cat_path_arr[2]);
                        $domain = $boot_domain_arr[0];
                    }
                }
            }else{
                $boot_domain_arr = explode('.',$path_arr[2]);
                $domain = $boot_domain_arr[0];
            }
        }
        $art_file_name = $articleid.'.shtml';
        return array('domain'=>$domain,'art_file_name'=>$art_file_name,'articleid'=>$articleid);
    }


    //相关热词
    public function relate_words($wd, $page, $size) {
        $filter_array = $this->getFilterArray();
        return App_Model_Search::search_words_all($wd, $page, $size,$filter_array);
    }

    private function search_relarticle($wd, $page, $size) {
        return App_Model_Search::search_article($wd, $page, $size);
    }

    private function search_ask($wd, $page, $size) {
        return App_Model_Search::search_ask($wd, $page, $size);
    }
    
    private function getFilterArray(){
        return array('typeid' =>  array(2,3,4,5,6,7,8,9));
//        return array('typeid' => array(0,2,3,4));
    }


}
