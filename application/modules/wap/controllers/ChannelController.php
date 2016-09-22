<?php

/**
 * *潘红晶 
 * 日期 2015年5月
 * */
class ChannelController extends App_Controller_Action {

    var $_article_obj = null;
    var $_categoryurl_obj = null;
    var $_art_obj = null;
    var $_zxads_obj = null;
   

    function init() {
        parent::init();
        $this->_article_obj = new App_Model_Article();
        $this->_categoryurl_obj = new App_Model_Categoryurl();
        $this->_art_obj = new App_Model_Article();
        $this->_zxads_obj = new App_Model_Zxads();
        $this->view->pc_url = isset($this->cate_info_params['pc_url']) ? $this->cate_info_params['pc_url'] : '';
    }

    function dispatchAction() {
        $arr_cat_info = $this->cate_info_params;
        $child = $arr_cat_info['child'];
        switch ($child) {
            case 1: {
                    $this->navAction();
                    break;
                }
            default : {
                    $this->listAction();
                }
        }
    }

    public function beautyAction(){
        $this->disableCache();
        $text_ads = $this->_zxads_obj->ads(4611);
        $pic_ads = $this->_zxads_obj->getAdsHandle(4612,20);

        $this->view->assign('text_ads', $text_ads);
        $this->view->assign('pic_ads', $pic_ads);

        echo $this->view->render('channel/beauty.tpl');
    }

     /**
      * 首页
      */
    function indexAction() {
//        $template_path = 'channel/channel.tpl';
        $template_path = 'channel/channel_new.tpl';
        $uri = md5($_SERVER['REQUEST_URI']);
        $browser = $this->user_agent;
        $ads_uc = '';
        if($browser == 'uc'){
            $ads_uc = $this->_zxads_obj->ads(4566); //uc广告
        }else{
            $ads_uc = $this->_zxads_obj->ads(4497); //uc广告
        }
        $this->view->assign('ads_uc',$ads_uc);
        $this->display($template_path, $uri);
        $caturl = $this->url_path_params;
        $tempCatidArr = $this->cate_info_params;
        $parenturl = empty($tempCatidArr) ? '' : $tempCatidArr['wap_url'];
        $catid = empty($tempCatidArr) ? 0 : $tempCatidArr['catid'];
        $caturl[0] = trim($tempCatidArr['parentdir'], "/");
        //得到 catid => /jkhf/bwby/ 的 map 对象  -----	：新增
        $catidMap = $this->_categoryurl_obj->getAllCatidMap();
//        var_dump($catid);exit();
        //轮播图
//        $slider = $this->_zxads_obj->getAdsHandle('3317', 6);
        $slider = $this->_zxads_obj->getPic($catid,$catid, 4,'index');
        //广告位    $id = 0, $num = 1, $ofset = 0, $class_name=''
//        $ads_1 = $this->_zxads_obj->ads(4499);
        $ads_2 = $this->_zxads_obj->ads(4500);
        $ads_3 = $this->_zxads_obj->ads(4501);
        $ads_quan = $this->_zxads_obj->ads(4538);
        $ads_4567 = $this->_zxads_obj->ads(4567);
        $ads_hotpic = $this->_zxads_obj->getAdsHandle(4527,6);
        
        //首页的 11 篇文章
        $articles_11 = $this->Channel_article($catid, 0, 11);

        $filterids = array();
        foreach ($articles_11 as $kk => &$vv) {
            $filterids[] = $vv['articleid'];
            $vv['url'] = $this->_article_obj->getNewRuleURL($vv['url']);
        }
        if ($catid) {
            $wheres = " catid='" . $catid . "'";
        } else {
            $wheres = " catdir='" . $caturl[0] . "' and parentid='0'";
        }
        if ($wheres) {
            $result = $this->_categoryurl_obj->getcategory($wheres);
            if ($result[0]['child'] > 0) {
                $wheres_catname = " catdir='" . $caturl[0] . "' and parentid='0'";
                $channel_catname = $this->_categoryurl_obj->getcategory($wheres_catname);
                if ($result[0]['parentid'] > 0) {
                    $this->view->assign('upcatname', $result[0]['catname']);  //获取上一级别的栏目名称
                    $this->view->assign('parenturl', $parenturl);  //获取上一级别的ID
                    $this->view->assign('channel_catname', $channel_catname[0]['catname']); //获取频道名称
                } else {
                    $this->view->assign('channel_catname', "");
                }
                $where_channel = " parentid='" . $result[0]['catid'] . "'";
                $channel_arry = $this->_categoryurl_obj->getcategory($where_channel);
                foreach ($channel_arry as $key => $val) {
                    if (isset($caturl) && !empty($caturl) && !in_array("nav.shtml", $caturl)) {
                        $child_art = $this->Channel_article($val['catid'],0,16);
                        $filterArt = $this->filterArt($filterids,$child_art);
                        $channel_arry[$key]['art'] = $filterArt;
                    }
                    $pdir = trim($channel_arry[$key]['parentdir'], "/");
                    $parentdir = explode("/", $pdir);
                    $channel_arry[$key]['catdir'] = "/" . $parentdir[0] . "/" . $channel_arry[$key]['catdir'];

                    //将 catdir 设置为其所在的域名  	-----	：新增
                    $cat_url = $val['url'];
                    $matchArr = $this->resolveURL($cat_url);
                    $domain = empty($matchArr) ? '' : (isset($matchArr[1]) ? $matchArr[1] : '');

                    $channel_arry[$key]['catdir'] = $domain;
                    $channel_arry[$key]['catid'] = $catidMap[$val['catid']] . "/";
                    $channel_arry[$key]['parentdir'] = '/' . $domain;
                }
            }
        }
        foreach ($result as $key => $val) {
            $settings = $result[$key]['setting'];
            eval("\$setting=$settings;");
            $result[$key]['setting'] = $setting;
        }
        $this->view->assign('channels_url', $tempCatidArr['channel_enname']);
        $this->view->assign('setting', $result[0]['setting']);   //获取网站描述
        $this->view->assign('channels', $result[0]['catname']);  //当前栏目名称
        $this->view->assign('catid', $catidMap[$result[0]['catid']]);  //当前频道ID
        $this->view->assign('channel_arry', $channel_arry);   //当前栏目的子栏目以及信息
        $this->view->assign('articles_11', $articles_11);   //开始的11篇文章
        $this->view->assign('slider', $slider);   //轮播图
//        $this->view->assign('ads_1', $ads_1);   //广告1
        $this->view->assign('ads_2', $ads_2);   //广告2
        $this->view->assign('ads_3', $ads_3);   //广告3
        $this->view->assign('ads_hotpic', $ads_hotpic);   //热图
        $this->view->assign('ads_quan', $ads_quan);   //
        $this->view->assign('ads_4567', $ads_4567);   // 4567
        
        echo $this->view->render($template_path, $uri);
    }
    
    /**
     * 多列表
     */
    function navAction() {
//        $template_path = 'channel/more_channel.tpl';
        $template_path = 'channel/more_channel_new.tpl';

        //性爱图片部分
        $pc_url = $this->cate_info_params['pc_url'];
        $curChannel = array();
        if(strpos($pc_url, "xatp") != 0){
            $template_path = 'channel/xatp_mlist.tpl';
            $curChannel = $this->getCurrChannel();
        }

        $uri = md5($_SERVER['REQUEST_URI']);
        $browser = $this->user_agent;
        $ads_uc = '';
        if($browser == 'uc'){
            $ads_uc = $this->_zxads_obj->ads(4566); //uc广告
        }else{
            $ads_uc = $this->_zxads_obj->ads(4497); //uc广告
        }
        $this->view->assign('ads_uc',$ads_uc);
        $this->display($template_path, $uri);

        $caturl = $this->url_path_params;
        //临时变量：
        $tempCatidArr = $this->cate_info_params;
        $parenturl = empty($tempCatidArr) ? '' : $tempCatidArr['wap_url'];
        $catid = empty($tempCatidArr) ? 0 : $tempCatidArr['catid'];
        $caturl[0] = trim($tempCatidArr['parentdir'], "/");
        $channel_id = empty($tempCatidArr) ? '0' : $tempCatidArr['channel_id'];
        //得到 catid => /jkhf/bwby/ 的 map 对象  -----	：新增
        $catidMap = $this->_categoryurl_obj->getAllCatidMap();
        $pparentidarr = empty($tempCatidArr) ? 0 : explode(',', $tempCatidArr['arrparentid']);
        $pparentid = $pparentidarr['1'];
        $lum_id = empty($tempCatidArr) ? 0 : $tempCatidArr['lum_id'];
//       var_dump($tempCatidArr);exit();
        //轮播图
        $slider = $this->_zxads_obj->getPic($pparentid,$lum_id, 4,'cat');
        //广告位    $id = 0, $num = 1, $ofset = 0, $class_name=''
        $ads_1 = $this->_zxads_obj->ads(4507);
        $ads_2 = $this->_zxads_obj->ads(4509);
        $ads_common = $this->_zxads_obj->ads(4535);
        $ads_quan = $this->_zxads_obj->ads(4538);
        $ads_4567 = $this->_zxads_obj->ads(4567);
        $ads_hotpic = $this->_zxads_obj->getAdsHandle(4527,6);
        
        if ($catid) {
            $wheres = " catid='" . $catid . "'";
        } else {
            $wheres = " catdir='" . $caturl[0] . "' and parentid='0'";
        }
        $section = array();
        if ($wheres) {
            $result = $this->_categoryurl_obj->getcategory($wheres);
            if ($result[0]['child'] > 0) {
                if ($channel_id > 0) {
                    $wheres_catname = " catid='" . $channel_id . "' and parentid='0'";
                } else {
                    $wheres_catname = " catdir='" . $caturl[0] . "' and parentid='0'";
                }
                $channel_catname = $this->_categoryurl_obj->getcategory($wheres_catname);
                if ($result[0]['parentid'] > 0) {
                    $this->view->assign('upcatname', $result[0]['catname']);  //获取上一级别的栏目名称
                    $this->view->assign('parenturl', $parenturl);  //获取上一级别的ID
                    $this->view->assign('channel_catname', $channel_catname[0]['catname']); //获取频道名称
                } else {
                    $this->view->assign('channel_catname', "");
                }
                $where_channel = " parentid='" . $result[0]['catid'] . "'";
                $channel_arry = $this->_categoryurl_obj->getcategory($where_channel);
                foreach ($channel_arry as $key => $val) {
                    if (isset($caturl) && !empty($caturl) && !in_array("nav.shtml", $caturl)) {
                        $channel_arry[$key]['art'] = $this->Channel_article($val['catid']);
                    }
                    $pdir = trim($channel_arry[$key]['parentdir'], "/");
                    $parentdir = explode("/", $pdir);
                    $channel_arry[$key]['catdir'] = "/" . $parentdir[0] . "/" . $channel_arry[$key]['catdir'];

                    //将 catdir 设置为其所在的域名  	-----	：新增
                    $cat_url = $val['url'];
                    $matchArr = $this->resolveURL($cat_url);
                    $domain = empty($matchArr) ? '' : (isset($matchArr[1]) ? $matchArr[1] : '');
                    $channel_arry[$key]['tmp_catid'] = $val['catid'];
                    $channel_arry[$key]['catdir'] = $domain;
                    $channel_arry[$key]['catid'] = $catidMap[$val['catid']] . "/";
                    $channel_arry[$key]['parentdir'] = '/' . $domain;
                    
                    $section[] = array(
                        'cat' => $channel_arry[$key],
                        'art' => $this->getSubChannelArts($channel_arry[$key]['tmp_catid'], 0, 5),
                        'moreurl' => $this->getChannelWapURL($val['child'], $cat_url),
                    );
                    
                }
            }
        }
        foreach ($result as $key => $val) {
            $settings = $result[$key]['setting'];
            eval("\$setting=$settings;");
            $result[$key]['setting'] = $setting;
        }

        //
        $this->view->assign('channels_url', $tempCatidArr['channel_enname']);
        $this->view->assign('setting', $result[0]['setting']);   //获取网站描述
        $this->view->assign('channels', $result[0]['catname']);  //当前栏目名称
        $this->view->assign('catid', $catidMap[$result[0]['catid']]);  //当前频道ID
        $this->view->assign('channel_arry', $channel_arry);   //当前栏目的子栏目以及信息
        $this->view->assign('section', $section);//前两个子栏目的钱五篇文章
        $this->view->assign('slider', $slider);//轮播图
        $this->view->assign('ads_1', $ads_1);   //广告1
        $this->view->assign('ads_2', $ads_2);   //广告2
        $this->view->assign('ads_common', $ads_common);   //广告
        $this->view->assign('ads_hotpic', $ads_hotpic);   //热图
        $this->view->assign('ads_quan', $ads_quan);   //
        $this->view->assign('ads_4567', $ads_4567);   // 4567
        $this->view->assign('curChannel', $curChannel);
        echo $this->view->render($template_path, $uri);
    }

    /*
     * 显示栏目文章列表
     * 
     * 
     */

    function listAction() {
//        $template_path = 'channel/catlist.tpl';
        $template_path = 'channel/catlist_new.tpl';
        $uri = md5($_SERVER['REQUEST_URI']);
        
        //性爱图片部分
        $pc_url = $this->cate_info_params['pc_url'];
        $curChannel = array();
        if(strpos($pc_url, "xatp") != 0){
            $template_path = 'channel/xatp_slist.tpl';
            $curChannel = $this->getCurrChannel();
        }
        $browser = $this->user_agent;
        $ads_uc = '';
        if($browser == 'uc'){
            $ads_uc = $this->_zxads_obj->ads(4566); //uc广告
        }else{
            $ads_uc = $this->_zxads_obj->ads(4497); //uc广告
        }
        $this->view->assign('ads_uc',$ads_uc);
        $this->display($template_path, $uri);
        
        
        $page = intval($this->getParam('page'));
        $caturl = $this->url_path_params;
        $domain = empty($caturl) ? "" : $caturl[0];
        $tempCatidArr = $this->cate_info_params;
        $id = empty($tempCatidArr) ? 0 : $tempCatidArr['catid'];
        $pparentidarr = empty($tempCatidArr) ? 0 : explode(',', $tempCatidArr['arrparentid']);
        $pparentid = $pparentidarr['1'];
        $lum_id = empty($tempCatidArr) ? 0 : $tempCatidArr['lum_id'];
        if ($id) {
            $wheres = " catid='" . $id . "'";
        }
        if ($wheres) {
            $result = $this->_categoryurl_obj->getcategory($wheres);
            
            if ($result[0]['arrparentid']) {
                $catid_array = explode(',', $result[0]['arrparentid']);
                $where_cat = " catid='" . $catid_array[1] . "'";
                $catname_array = $this->_categoryurl_obj->getcategory($where_cat);

                //获取域名信息 ---xinzeng bufen 
                $channelPath = $pdir = $domain;
                $catdir = explode("/", $pdir);
                $channel_catdir = "/" . $catdir[0] . "/";
                $result[0]['catdir'] = "/" . $catdir[0];
                $result[0]['art_base_path'] = $channel_catdir . "article";
            }
            
//            $where_count = " catid in ('" . $result[0]['arrchildid'] . "') and status='20'";
            
            $where_list = '';
            $index_name = '';
            $tmp_child_ids =$result[0]['arrchildid'] ;
            $tmp_catids = explode(',', $tmp_child_ids);  
            $tmp_father_id = $tmp_catids[0];
            if(isset(QConfigs_Site_Config::$site_template_map[$tmp_father_id])){
                $where_list = " channel_id ='$tmp_father_id'  and status='20' ";
            }else{
                $where_list = " catid in ('" . $result[0]['arrchildid'] . "') and status='20'";
                $index_name = 'index_cat_status_articleid';
            }
            $total = $this->_article_obj->getcount($where_list,$index_name);
            
            $pnum = 20; //每页显示多少条数据
            $page = $page <= 1 ? 1 : $page;
            $total_page = ceil($total / $pnum);
            $page = $page >= $total_page ? $total_page : $page;
            if ($page == 0) {
                $offsize = 0;
            } else {
                $offsize = ($page - 1) * $pnum;
            }
            $where_list .= " ORDER BY articleid desc LIMIT " . $offsize . "," . $pnum . "";
            $article_arry = $this->_article_obj->getarticle($where_list,$index_name);
        }
        foreach ($result as $key => $val) {
            $settings = $result[$key]['setting'];
            eval("\$setting=$settings;");
            $result[$key]['setting'] = $setting;
        }
        
        //轮播图
        $catid = $catid_array[1];
        $slider = $this->_zxads_obj->getPic($pparentid,$lum_id, 4,'cat');
        //广告位    $id = 0, $num = 1, $ofset = 0, $class_name=''
        $ads_1 = $this->_zxads_obj->ads(4502);
        $ads_2 = $this->_zxads_obj->ads(4503);
        $ads_3 = $this->_zxads_obj->ads(4504);
        $ads_4 = $this->_zxads_obj->ads(4505);
        $ads_5 = $this->_zxads_obj->ads(4506);
        $ads_common = $this->_zxads_obj->ads(4535);
        $ads_quan = $this->_zxads_obj->ads(4538);
        $ads_4567 = $this->_zxads_obj->ads(4567);
        $ads_hotpic = $this->_zxads_obj->getAdsHandle(4527,6);
        
        //新增部分 ：
        $matchArr = $this->resolveURL($result[0]['url']);
        $catid = empty($matchArr) ? "" : (isset($matchArr[2]) ? $matchArr[2] : '');
        $result[0]['catid'] = $catid . "/";
        $result[0]['catdir'] = "/" . $domain;

        $pageup = $page - 1;
        $pagenp = $page + 1;
        if ($total_page > 1) {
            if ($page == $total_page) {
                $page_html = '<a href="' . $result[0]['catdir'] . '/' . $result[0]['catid'] . 'list.shtml?page=' . $pageup . '" class="curr">上一页</a><a href=""><span>' . $page . '</span>/' . $total_page . '页</a>';
            } else if ($total_page > 1 && ($page == 0 || $page == 1)) {
                $page_html = '<a style="display:none;"></a><a href=""><span>' . $page . '</span>/' . $total_page . '页</a><a href="' . $result[0]['catdir'] . '/' . $result[0]['catid'] . 'list.shtml?page=' . $pagenp . '" class="curr">下一页</a>';
            } else {
                $page_html = '<a href="' . $result[0]['catdir'] . '/' . $result[0]['catid'] . 'list.shtml?page=' . $pageup . '" class="curr">上一页</a><a href=""><span>' . $page . '</span>/' . $total_page . '页</a><a href="' . $result[0]['catdir'] . '/' . $result[0]['catid'] . 'list.shtml?page=' . $pagenp . '" class="curr"">下一页</a>';
            }
        }else if($total_page == 1){
            $page_html = '<a style="display:none;"></a><a><span>1</span>/1页</a><a style="display:none;"></a>';
        }else{
            $page_html = '';
        }

        //性爱图片部分
        if(strpos($pc_url, "xatp") != 0){
            $article_arry = $this->handleArticles($article_arry, 'list');
            $page_html = $this->getPageHTML($page, $total_page, strstr($_SERVER['REQUEST_URI'], "?", true));
        }

        $this->view->assign('setting', $result[0]['setting']);   //获取网站描述
        $this->view->assign('channels_name', $catname_array[0]['catname']);  //所在频道
        $this->view->assign('channel_catdir', $channel_catdir);  //所在频道URL
        $this->view->assign('channels', $result[0]['catname']);  //当前栏目名称
        $this->view->assign('catdir', $result[0]['catdir']);  //当前栏目URL
        $this->view->assign('art_base_path', $result[0]['art_base_path']);  //当前文章的根目录

        $this->view->assign('catid', $catid);  //当前栏目
        $this->view->assign('article_arry', $article_arry);   //获取文章列表
        $this->view->assign('page_html', $page_html);   //分页
        $this->view->assign('page', $page);   //当前页码
        $this->view->assign('slider', $slider);   //轮播图
        $this->view->assign('ads_1', $ads_1);   //ads
        $this->view->assign('ads_2', $ads_2);   //ads
        $this->view->assign('ads_3', $ads_3);   //ads
        $this->view->assign('ads_4', $ads_4);   //ads
        $this->view->assign('ads_5', $ads_5);   //ads
        $this->view->assign('ads_common', $ads_common);   //ads_common
        $this->view->assign('ads_hotpic', $ads_hotpic);   //热图
        $this->view->assign('ads_quan', $ads_quan);   //
        $this->view->assign('ads_4567', $ads_4567);   // 4567

        $this->view->assign('curChannel', $curChannel);   //性爱图片部分
        echo $this->view->render($template_path, $uri);
    }

    private function Channel_article($catid, $offset = 0, $length = 6) {
        if ($catid) {
//            $where = " catid=" . $catid;
//            $result = $this->_categoryurl_obj->Getcategory($where);
//            $whereart = " catid in (" . $result[0]['arrchildid'] . ") and status='20' ORDER BY articleid desc LIMIT ".$offset.",".$length;
//            $relevant_art = $this->_art_obj->getarticle($whereart,' index_cat_status_articleid ');
            $whereart = " lum_id = " . $catid . " ORDER BY articleid desc LIMIT ".$offset.",".$length;
            $relevant_art = $this->_art_obj->getArticleFromCache($whereart);
            foreach ($relevant_art as $key => $val) {
                $wheres = " catid=" . $val['catid'];
                $res_cat = $this->_categoryurl_obj->getcategory($wheres);
                $pdir = trim($res_cat[0]['parentdir'], "/");
                $parentdir = explode("/", $pdir);
                $relevant_art[$key]['catdir'] = "/" . $parentdir[0] . "/" . $res_cat[0]['catdir'];
                $relevant_art[$key]['channel'] = "/" . $parentdir[0] . "/";
                $relevant_art[$key]['art_base_path'] = "/" . $parentdir[0] . "/article";

                //xinzeng bufen 
                $matchArr = $this->resolveURL($res_cat[0]['url']);
                $domain = empty($matchArr) ? "" : $matchArr[1];
                $catid = empty($matchArr) ? "" : (isset($matchArr[2]) ? $matchArr[2] : "");

                $relevant_art[$key]['art_base_path'] = "/" . $domain . "/article";
                $relevant_art[$key]['channel'] = "/" . $domain . "/";
                $relevant_art[$key]['catdir'] = "/" . $domain;
                $relevant_art[$key]['catid'] = "/" . $catid;
            }
            
            return $relevant_art;
        }
    }

    function showAction() {
        echo $this->view->render('channel/show.html');
    }
    
    //过滤文章数组
    public function filterArt($filterids, $articles) {
        $reArt = array();
        $n=0;
        foreach ($articles as $k => $v) {
            
            if(in_array($v['articleid'], $filterids)){
                continue;
            }
            
            $reArt[$n] = $articles[$k];
            
            if($n == 4){
                break;
            }
            $n++;
        }
        return $reArt;
    }

    /**
     * 得到子栏目 指定条数的文章集
     * @author gaoqing
     * @date 2016-03-18
     * @param int $subcatid 子栏目id
     * @param int $offset 查询的起始为啥
     * @param int $size 查询的条数
     * @return array 指定条数的文章集
     */
    private function getSubChannelArts($subcatid, $offset, $size){
       
        $subArticles = array();
//        $articles = $this->_article_obj->getArticlesByCateid($subcatid, $offset, $size);
        $articles = $this->Channel_article($subcatid, $offset, $size);
        
        $subArticles = $this->handleArticles($articles);
        return $subArticles;
    }

    /**
     * 得到内容中的所有图片
     * @author gaoqing
     * @date 2016-03-18
     * @param int $articleid 文章id
     * @return array 内容中的所有图片
     */
    private function getThumbs($articleid){
        $matcheImgs = array();

        //得到文章的内容信息 content
        $where = " articleid = '". $articleid ."'";
        $articleDetail = $this->_article_obj->getarticle_detail($where);
        if(isset($articleDetail) && !empty($articleDetail)){
            $content = $articleDetail[0]['content'];
            $content = trim($content);

            //获取 content 中的图片数
            if(isset($content) && !empty($content)){
                $pattern = '/\<img[\s\S]+?\/\>/';
                preg_match_all($pattern, $content, $matcheImgs);
            }
        }
        if(!empty($matcheImgs)){
            $matcheImgs = $matcheImgs[0];
        }
        return $matcheImgs;
    }

    /**
     * 得到 wap 端的 url 地址
     * @author gaoqing
     * @date 2016-03-08
     * @param int $child 是否有子栏目（0：没有；1：有）
     * @param string $picURL pc端 url 地址
     * @return string wap 端的 url 地址
     */
    private function getChannelWapURL($child, $picURL)
    {
        $wapURL = "/";
        $matchArr = $this->resolveURL($picURL);
        if(!empty($matchArr)){
            $wapURL .= $matchArr[1] . DIRECTORY_SEPARATOR;
        }
        if(isset($matchArr[2]) && !empty($matchArr[2])){
            $wapURL .= $matchArr[2] . DIRECTORY_SEPARATOR;
        }
        if($child == 0){
            $wapURL .= "list.shtml";
        }
        return $wapURL;
    }

    /**
     * 得到图片的路径
     * @author gaoqing
     * @date 2016-03-09
     * @param string $partURL 图片部分路径
     * @return string 完整图片的路径
     */
    private function getPicURL($partURL){
        $picURL = "";
        $init_temp = strstr($partURL, 'uploadfile');
        $file_folder = empty($init_temp) ? '/uploadfile/' : '/';
        $picURL = 'http://www.9939.com' . $file_folder . $partURL;
        return $picURL;
    }

    /**
     * 得到当前栏目信息
     * @author gaoqing
     * @date 2016-03-18
     * @return array 当前栏目的信息
     */
    private function getCurrChannel(){
        $parents = $this->getParentInfo($this->cate_info_params['arrparentid']);
        $curChannel = array(
            'catid' => $this->cate_info_params['catid'],
            'catname' => $this->cate_info_params['catname'],
            'url' => $this->getChannelWapURL($this->cate_info_params['child'], $this->cate_info_params['url']),
            'channel_url' => $this->cate_info_params['channel_url'],
            'parent' => $parents,
        );
        return $curChannel;
    }

    /**
     * 根据父级 id 字符串集，查询其所有父级栏目的信息
     * @author gaoqing
     * @date 2016-03-04
     * @param string $arrparentid 父级 id 字符串集
     * @return array 所有父级栏目的信息
     */
    private function getParentInfo($arrparentid){
        $parents = array();
        if (isset($arrparentid) && !empty($arrparentid)){
            $arrparentid = ltrim($arrparentid, "0,");
            $parents = $this->_categoryurl_obj->getAllCategory($arrparentid);
            foreach($parents as &$parent){
                $url = $this->getChannelWapURL($parent['child'], $parent['url']);
                $parent['url'] = $url;
            }
        }
        return $parents;
    }

    /**
     * 处理文章的相关信息
     * @author gaoqing
     * @date 2016-03-18
     * @param array $articles 文章集
     * @param string $type 类型（nav: 多列表；list：单列表页）
     * @return array 处理后的文章集
     */
    private function handleArticles($articles, $type = "nav")
    {
        $handledArticles = array();
        if (isset($articles) && !empty($articles)) {
            foreach ($articles as $key => $article) {
                $article['date'] = date('Y-m-d', $article['inputtime']);
//                if(in_array($type, array('list','nav'))){
                    $article['url'] = $this->getArticleWapURL($article['url']);
//                }

                //得到图片的总数
                $thumbs = $this->getThumbs($article['articleid']);

                //得到当前文章的缩略图
                $articleThumb = $article['thumb'];
                $articleThumb = trim($articleThumb);
                $article['thumb'] = '<img width="140" height="115" src="' . $this->getPicURL($articleThumb) . '" alt="' . $article['title'] . '" title="' . $article['title'] . '">';
                if (!isset($articleThumb) || empty($articleThumb)) {
                    $article['thumb'] = empty($thumbs) ? $article['thumb'] : $thumbs[0];
                }
                $article['thumb_count'] = count($thumbs);
                $handledArticles[$key] = $article;
            }
            return $handledArticles;
        }
        return $handledArticles;
    }

    /**
     * 得到文章的 wap 端 url 地址
     * @author gaoqing
     * @date 2016-03-08
     * @param string $pcURL PC 端 URL 地址
     * @return string wap端 url 地址
     */
    private function getArticleWapURL($pcURL) {
        $wapURL = $pcURL;
        if (isset($pcURL) && !empty($pcURL)) {

            //具体的文章内容路径处理方式：
            if (strpos($pcURL, ".shtml")) {

                $linkURArr = explode("/", $pcURL);
                //获取域名：
                $fullDomain = $linkURArr[2];
                $domainArr = explode(".", $fullDomain);
                $domain = $domainArr[0];

                //获取文章id
                $linkURArrLength = count($linkURArr);
                $articleidStr = $linkURArr[$linkURArrLength - 1];
                $articleidArr = explode(".", $articleidStr);
                $articleid = empty($articleidArr) ? 0 : $articleidArr[0];

                $wapURL = "/" . $domain . "/article/" . $articleid . ".shtml";
                return $wapURL;
            }
        }
        return $wapURL;
    }

    /**
     * 得到分页代码
     * @author gaoqing
     * @date 2016-03-07
     * @param int $page 当前页
     * @param int $pages 总页数
     * @param int $uri uri 值
     * @return string 分页代码
     */
    private function getPageHTML($page, $pages, $uri){
        $pageHTML = '';
        $spliter = "?";
        if(strstr($uri, "?")){
            $spliter = "&";
        }
        $prePageHTML = '<a href="'. $uri . $spliter . 'page='. ($page - 1) .'">上一页</a>';
        if($page == 1){
            $prePageHTML = '';
        }
        $currPageHTML = '<span>'. $page .'/'. $pages .'</span>';

        $nextPageHTML = '<a href="'. $uri . $spliter . 'page='. ($page + 1) .'">下一页</a>';
        if($page == $pages){
            $nextPageHTML = '';
        }
        $pageHTML = $prePageHTML . $currPageHTML . $nextPageHTML;
        return $pageHTML;
    }

}
