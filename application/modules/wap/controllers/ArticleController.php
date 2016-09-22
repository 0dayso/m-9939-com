<?php

/**
 * *潘红晶 
 * 日期 2015年5月
 * */
class ArticleController extends App_Controller_Action {

    var $_article_obj = null;
    var $_categoryurl_obj = null;
    var $_zxads_obj = null;
    var $_ask_obj = null;
    var $_ads_obj = null;
    var $domainurl;

    function init() {
        parent::init();
        $this->initView();

        $this->_article_obj = new App_Model_Article();
        $this->_categoryurl_obj = new App_Model_Categoryurl();
        $this->_zxads_obj = new App_Model_Zxads();
        $this->_ask_obj = new App_Model_Ask();
        $this->domain = "http://m.9939.com/";
    }

    public function dispatchAction() {
        $channel_enname = $this->channel_enname;
        switch ($channel_enname) {
            case 'jb': {
                    $this->showjbAction();
                    break;
                }
            default : {
                    $this->showAction();
                }
        }
    }

    //各频道文章
    function showAction() {
        $template_path = 'Article/article_new.tpl';
//        $template_path = 'Article/article.tpl';
        $url = md5($_SERVER['REQUEST_URI']);
        
        $browser = $this->user_agent;
        $ads_uc = '';
        if($browser == 'uc'){
            $ads_uc = $this->_zxads_obj->ads(4605); //uc广告
        }else{
            $ads_uc = $this->_zxads_obj->ads(4497); //uc广告
        }
        $this->view->assign('ads_uc',$ads_uc);
        
        $this->display($template_path, $url);
        $article_url = $_SERVER['REQUEST_URI'];
        //获取相关文章 开始
        $caturl = explode("/", trim($url, '/'));

        $id = intval($this->getParam('id'));
        
        if ($id) {
            $where = " articleid=" . $id;
            $result = $this->_article_obj->getarticle($where);
            if ($result && is_array($result)) {
                $art_where = " articleid=" . $result[0]['articleid'];
                $result_art = $this->_article_obj->getarticle_detail($art_where);
            }
        }

        $url_cat = explode("/", trim($_SERVER['REQUEST_URI'], '/'));//用于获取所属栏目名称
        $curr_catid = $result[0]['catid'];
        if ($curr_catid == 0) {
            $base_domain_url = sprintf('http://%s.9939.com/', $caturl[0]);
            $cate_result = $this->_categoryurl_obj->getCatdirByURL($base_domain_url);
            $cat_result = $cate_result;
        } else {
            $cate_where = " catid=" . $curr_catid;
            $cate_result = $this->_categoryurl_obj->getcategory($cate_where);
            $arrparentid = explode(",", $cate_result[0]['arrparentid']);

            $cat_where = " catid=" . $arrparentid[1];
            $cat_result = $this->_categoryurl_obj->getcategory($cat_where);
            
        }
        $domain = "";
        $catid = "";
        $initURL = isset($cate_result[0]['url']) ? $cate_result[0]['url'] : '';
        if (!empty($initURL)) {
            $initURLArr = explode("9939.com", $initURL);
            $initDomain = str_replace('http://', '', $initURLArr[0]);// trim($initURLArr[0], "http://");
            $initPartURL = isset($initURLArr[1]) ? $initURLArr[1] : '';
            $domain = trim($initDomain, ".");
            $tempCatid = ($initPartURL == '/') ? '' : $initPartURL;
            $catid = trim($tempCatid, "/");
        }
        $catdir = array();
        $catdir['parentdir_url'] = $domain;
        $catdir['catid'] = $catid . "/";
        $catdir['parentdir_name'] = mb_substr($cat_result[0]['catname'], 0, 2);
        $catdir['catdir_url'] = $cate_result[0]['catdir'];
        $catdir['catdir_name'] = $cate_result[0]['catname'];
        
        //过滤 非两性频道下 articleid 小于 1714030 文章的图片
        if($id < 1714030 && $domain != 'lx'){
            $str = $result_art[0]['content'];
            $pattern = '/\<img[\s\S]+?\>/';
            $str =  preg_replace($pattern, '', $str);
            $str = strip_tags($str,'<p>');
            $result_art[0]['content'] =  $str;
        }
        $result[0]['content'] = $result_art[0]['content'];//
        $result[0]['copyfrom'] = $result_art[0]['copyfrom'];
        $result[0]['inputtime'] = date("Y-m-d", $result[0]['inputtime']);
        $keywords = explode(" ", $result[0]['keywords']);
        //获取资讯广告 文章详情页面（文章来源广告位）
        $zx_adstext = $this->article_ads(4213);
        //获取资讯广告 文章详情页面（相关文章下边广告位）
        $zx_adsimage = $this->article_ads(4214);
        
        $base_cat_dir = $cat_result[0]['catdir'];
        $wheres_url = " parentdir like '%" . $base_cat_dir . "%' ";
        if ($curr_catid > 0) {
            $wheres_url = " parentdir like '%" . $base_cat_dir . "%' and catid='" . $curr_catid . "'";
        }
        if ($wheres_url) {
            $result_url = $this->_categoryurl_obj->getcategory($wheres_url);
//            if ($result_url[0]['child'] > 0) {
//                $where_art = " catid in ('" . $result_url[0]['arrchildid'] . "') and status='20' ORDER BY articleid desc LIMIT 0,5";
//            } else {
//                $where_art = " catid = '" . $result_url[0]['arrchildid'] . "' and status='20' ORDER BY articleid desc LIMIT 0,5";
//            }
            
            $where_list = '';
            $index_name = '';
            $tmp_child_ids =$result_url[0]['arrchildid'];
            $tmp_catids = explode(',', $tmp_child_ids);  
            $tmp_father_id = $tmp_catids[0];
            if(isset(QConfigs_Site_Config::$site_template_map[$tmp_father_id])){
                $where_list = " channel_id ='$tmp_father_id'  and status='20' ";
            }else{
                $where_list = " catid in ('" . $tmp_child_ids . "') and status='20' ";
                $index_name = 'index_cat_status_articleid';
            }
            $where_list.=' ORDER BY articleid desc LIMIT 0,5';
            $article_list = $this->_article_obj->getRelateArticleWithCache($where_list);
            $article = array();
            foreach ($article_list as $key => $val) {
                $wheres = " catid=" . $val['catid'];
                $res_cat = $this->_categoryurl_obj->getcategory($wheres);
                $pdir = trim($res_cat[0]['parentdir'], "/");
                $parentdir = explode("/", $pdir);
                $val['catdir'] = "/" . $parentdir[0] . "/" . $res_cat[0]['catdir'];
                $val['channel'] = "/" . $parentdir[0] . "/";
                $val['art_base_path'] = $this->wap_root_channel_url . "article";
                $tmp_article_id = $val['articleid'];

                if ($tmp_article_id != $id && count($article) < 4) {
                    $article[] = $val;
                }
            }
        }
        $article_last = $this->neighborArticle($result[0]['articleid'],$result[0]['catid'], false);
        $article_next = $this->neighborArticle($result[0]['articleid'],$result[0]['catid'], true);

        //性爱图片部分：
        $attachments = array();
        $xatpArr = array(
            2576,2729,2730,2731,2732,2733,2735,2737,2738,2739,2754,2756,2757,
            2760,2761,2764,2765,2768,2771,2772,2774,2776,2778,2780,2781,2783);
        if(in_array($curr_catid, $xatpArr)){
            $template_path = "Article/xatp_article.tpl";
            $attachments = $this->getThumbs($result[0]['content']);
            $article = $this->handleArticles($article);
        }

        $pc_article_url = $result['0']['url'];
        $this->view->assign('article', $article); //相关文章
        //相关文章结束
         
        //四个频道的文章
        $fourCateArt = $this->fourCatArt(); 
        //相关问答
        $askAndAnswerArr = $this->getRelAsk($url_cat['0']);
        //广告位    $id = 0, $num = 1, $ofset = 0, $class_name=''
        $ads_1 = $this->_zxads_obj->ads(4510);
        $ads_2 = $this->_zxads_obj->ads(4511);
        $ads_3 = $this->_zxads_obj->ads(4512);
        $ads_4 = $this->_zxads_obj->ads(4533);
        $ads_common = $this->_zxads_obj->ads(4535);
        $ads_foot = $this->_zxads_obj->ads(4537);
        $ads_quan = $this->_zxads_obj->ads(4538);
        $ads_4541 = $this->_zxads_obj->ads(4541);
        $ads_4542 = $this->_zxads_obj->ads(4542);
        $ads_4567 = $this->_zxads_obj->ads(4567);
        
        $is_lx = is_int(strpos($domain, 'lx'));
        $ads_lx = $is_lx ? '' : $this->_zxads_obj->ads(4534);//两性频道文章页广告位

        $ads_zhushou = $this->_zxads_obj->getAdsHandle(4530,8);
        //标题下方
//        $ads_1 = $this->_zxads_obj->getAdsHandle('4510', 1);
        $ads_hotpic = $this->_zxads_obj->getAdsHandle(4527,6);      //热图推荐
        $this->view->assign('result', $result[0]);
        $this->view->assign('article_url', $article_url);
        $this->view->assign('keywords', $keywords); //文章关键子
        $this->view->assign('pc_article_url', $pc_article_url); //文章关键子
        $this->view->assign('catdir', $catdir); //面包屑导航
        $this->view->assign('zx_adstext', $zx_adstext); //获取资讯广告 文章详情页面（文章来源广告位）
        $this->view->assign('zx_adsimage', $zx_adsimage); //获取资讯广告 文章详情页面（相关文章下边广告位）
        $zx_adscount = !empty($zx_adsimage) ? count($zx_adsimage) : 0;
        $this->view->assign('zx_adscount', $zx_adscount);
        $this->view->assign('article_last', $article_last);
        $this->view->assign('article_next', $article_next);
        $this->view->assign('fourCateArt', $fourCateArt);
        $this->view->assign('askAndAnswerArr', $askAndAnswerArr);//相关问答
        $this->view->assign('ads_1', $ads_1);   //广告1
        $this->view->assign('ads_2', $ads_2);   //广告2
        $this->view->assign('ads_3', $ads_3);   //广告3
        $this->view->assign('ads_4', $ads_4);   //广告3
        $this->view->assign('ads_zhushou', $ads_zhushou);   //广告 底部健康助手
        $this->view->assign('ads_lx', $ads_lx);   //两性文章广告
        $this->view->assign('ads_common', $ads_common);   //$ads_common
        $this->view->assign('ads_foot', $ads_foot);   //$ads_foot

        $this->view->assign('attachments', $attachments);   //性爱图片部分
        $this->view->assign('ads_hotpic', $ads_hotpic);   //性爱图片部分
        $this->view->assign('ads_quan', $ads_quan);   //
        $this->view->assign('ads_4541', $ads_4541);   //广告 4541
        
        $this->view->assign('ads_4542', $ads_4542);   //广告 4542
        $this->view->assign('ads_4567', $ads_4567);   //广告 4567
        echo $this->view->render($template_path, $url);
    }

    //疾病文章
    public function showjbAction() {
        $template_path = 'Article/article_jb.tpl';
//        $template_path = 'Article/article_jb_new.tpl';
        $url = md5($_SERVER['REQUEST_URI']);
        $browser = $this->user_agent;
        $ads_uc = '';
        if($browser == 'uc'){
            $ads_uc = $this->_zxads_obj->ads(4605); //uc广告
        }else{
            $ads_uc = $this->_zxads_obj->ads(4497); //uc广告
        }
        $this->view->assign('ads_uc',$ads_uc);
        $this->display($template_path, $url);

        $id = intval($this->_getParam('id'));
        $title = '';
        if ($id) {
            $articleid = array($id);
            $result = $this->_article_obj->List_DiseaseArticleByIds($articleid);
            $result[0]['inputtime'] = date("Y-m-d", $result[0]['inputtime']);
            $keywords = explode(" ", $result[0]['keywords']);
            $title =  $result[0]['title'];
        }
        $domain = 'jb';
        $catdir_name = '疾病文章';
        $catdir = array();
        $catdir['parentdir_url'] = $domain;
        $catdir['catid'] = "";
        $catdir['parentdir_name'] = '疾病';
        $catdir['catdir_url'] = "#";
        $catdir['catdir_name'] = $catdir_name;

        //获取资讯广告 文章详情页面（文章来源广告位）
        $zx_adstext = $this->article_ads(4213);
        //获取资讯广告 文章详情页面（相关文章下边广告位）
        $zx_adsimage = $this->article_ads(4214);
        
        $ads_4542 = $this->_zxads_obj->ads(4542);
        $ads_4567 = $this->_zxads_obj->ads(4567);

        //获取相关文章
        $wd = empty($result[0]['keywords'])?$title:$result[0]['keywords'];
        $page = 0;
        $size = 5;
        $res = $this->search_relarticle($wd, $page, $size);
        $article = array();
        foreach ($res['list'] as $k => $v) {
            $parse_result = $this->parseArtUrl($v);
            $domain = $parse_result['domain'];
            $artid = $parse_result['articleid'];
            $art_base_path = $this->domain . $domain . '/article';
            $article[$k]['title'] = $v['title'];
            $article[$k]['articleid'] = $artid;
            $article[$k]['art_base_path'] = $art_base_path;
        }
        $pc_article_url = 'http://jb.9939.com/' . $result['0']['url'];
       
        $pc_article_url = $result['0']['url'];
        $this->view->assign('article', $article); //相关文章
        
        $this->view->assign('article', $article); //相关文章
        $this->view->assign('result', $result[0]);
        $this->view->assign('keywords', $keywords); //文章关键子
        $this->view->assign('pc_article_url', $pc_article_url); //文章关键子
        $this->view->assign('catdir', $catdir); //面包屑导航
        $this->view->assign('zx_adstext', $zx_adstext); //获取资讯广告 文章详情页面（文章来源广告位）
        $this->view->assign('zx_adsimage', $zx_adsimage); //获取资讯广告 文章详情页面（相关文章下边广告位）
        $zx_adscount = !empty($zx_adsimage) ? count($zx_adsimage) : 0;
        $this->view->assign('zx_adscount', $zx_adscount);
        $this->view->assign('ads_4542', $ads_4542);   //广告 4542
        $this->view->assign('ads_4567', $ads_4567);   //广告 4567
        echo $this->view->render($template_path, $url);
    }

    //获取资讯广告信息
    private function article_ads($placeid) {
        if ($placeid) {
            $zx_where = " placeid='$placeid' ";
            $zx_adsplace = $this->_zxads_obj->Getadsplace($zx_where);
            $where = " placeid='" . $zx_adsplace[0]['placeid'] . "' order by addtime desc limit 0," . $zx_adsplace[0]['items'] . "";
            $zx_ads = $this->_zxads_obj->Getads($where);
            if ($zx_ads && is_array($zx_ads)) {
                foreach ($zx_ads as $key_ads => $val_ads) {
                    if ($val_ads['imageurl']) {
                        $zx_ads[$key_ads]['imageurl'] = "http://www.9939.com/uploadfile/" . $val_ads['imageurl'];
                    }
                    //设置新规则下的 url 
                    $zx_ads[$key_ads]['newruleurl'] = $val_ads['linkurl'];
                }
            }
            return $zx_ads;
        }
    }

    private function getNewRuleURL($linkurl) {
        $newRuleURL = $linkurl;

        if (isset($linkurl) && !empty($linkurl)) {

            //具体的文章内容路径处理方式：
            if (strpos($linkurl, ".shtml")) {

                $linkURArr = explode("/", $linkurl);
                $linkURArrLength = count($linkURArr);
                $articleidStr = $linkURArr[$linkURArrLength - 1];
                $articleidArr = explode(".", $articleidStr);
                $articleid = empty($articleidArr) ? 0 : $articleidArr[0];
                //根据 $articleid 查询当前文章的 url
                $articleArr = $this->_article_obj->getarticle(" articleid = " . $articleid);
                $articleURL = empty($articleArr) ? "" : $articleArr[0]['url'];

                //获取域名
                $arr = explode("/", $articleURL);
                $fullDomain = $arr[2];
                $domainArr = explode(".", $fullDomain);
                $domain = $domainArr[0];

                //获取文章 id
                $length = count($arr);
                $id = $arr[$length - 1];

                $newRuleURL = "http://m.9939.com/" . $domain . "/article/" . $id;
                return $newRuleURL;
            }
        }

        return $newRuleURL;
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
    
    /**
     * 获取相邻文章
     * @param type $id
     * @param type $flag true 下一篇 false 上一篇
     */
    public function neighborArticle($articleid, $catid, $flag = true){
        if ($articleid) {
            $artcon = $flag ? ' and articleid < ' . $articleid : ' and articleid > ' . $articleid;
            $order = $flag ? ' desc ' : ' asc ';
            $where_art = " catid ='$catid' " . $artcon . " and status='20' ORDER BY articleid " . $order . " LIMIT 0,1";
            $result = $this->_article_obj->getarticle($where_art,' index_cat_status_articleid');
            if ($result && is_array($result)) {
                $result['0']['url']=$this->getNewRuleURL($result['0']['url']);
                return $result['0'];
                
            }else{
                return array();
            }
        }
    }
    /**
     * 获取新闻 两性 偏方 减肥 频道下的5篇文章
     */
    public function fourCatArt() {
        $cacheName = md5('getfourcattegoryarticles');
        $cacheDir = "pages/article_block";
        $result = QLib_Cache_Client::getCache($cacheDir, $cacheName);
        if (!$result) {
            $arr = array(
                '0' => array('9456', '/news/', '新闻'),
                '1' => array('2464', '/lx/', '两性'),
                '2' => array('2266', '/pianfang/', '偏方'),
                '3' => array('2094', '/fitness/', '减肥'),
            );
            $result = array();
            foreach ($arr as $k => $v) {
                $art = $this->_article_obj->getArticlesByCateid($v['0']);
                $result[$k] = array(
                    'article' => $art,
                    'url' => $v['1'],
                    'catname' => $v['2']
                );
            }
            $time = 24;
            QLib_Cache_Client::setCache($cacheDir, $cacheName, $result, $time);
        }
        return $result;
    }

    //热词 获取相关文章
    private function search_relarticle($wd, $page, $size) {
        return App_Model_Search::search_article($wd, $page, $size);
    }
    
    //相关问答
    public function getRelAsk($cat) {
        $cacheName = md5($cat . 'relate_ask');
        $cacheDir = "pages/article_block";
        $result = QLib_Cache_Client::getCache($cacheDir, $cacheName);
        if (!$result) {
            $askidArr = $this->getClassidArr($cat);
            $askAndAnswerArr = array();
            $userDifineWhere = array("where" => " AND classid in (?) AND examine = 1 and answernum>0 ", "condition" => $askidArr['0']);
            $res1 = $this->_ask_obj->getAskAndAnswers(null, 0, 2, $userDifineWhere);

            $userDifineWhere = array("where" => " AND classid in (?) AND examine = 1 and answernum>0  ", "condition" => $askidArr['1']);
            $res2 = $this->_ask_obj->getAskAndAnswers(null, 0, 1, $userDifineWhere);

            $userDifineWhere = array("where" => " AND classid in (?) AND examine = 1 and answernum>0  ", "condition" => $askidArr['2']);
            $res3 = $this->_ask_obj->getAskAndAnswers(null, 1, 1, $userDifineWhere);

            $result = array_merge($res1, $res2, $res3);

            $time = 24;
            QLib_Cache_Client::setCache($cacheDir, $cacheName, $result, $time);
        }
        return $result;
    }

    //资讯文章的相关问答
    public function getClassidArr($cat) {
        $catids = array(
            'zx' => array('312', '324', '308', '311', '301', '300'), //整形
            'zhongyi' => array('429', '430', '431'), //中医 
            'xinli' => array('9', '525', '248'), //心理
            'tijian' => array('32', '102', '428'), //体检
            'pianfang' => array('434', '435', '440'), //偏方
            'news' => array('3', '16', '22'), //新闻
            'beauty' => array('299', '339'), //美容
            'man' => array('221', '232'), //男性
            'lx' => array('524', '220', '219'), //两性
            'lady' => array('194', '208', '219'), //女性
            'js' => array('6', '5'), //健身
            'food' => array('437', '438', '442'), //饮食
            'drug' => array('437', '438', '442'), //药品
            'baby' => array('272', '11', '248'), //母婴
        );
        if (empty($cat) || !array_key_exists($cat, $catids)) {
            $cat = 'news';
        }
        $arr = array();
        $arr[] = $catids[$cat]['0'];
        $arr[] = $catids[$cat]['1'];
        if (count($catids[$cat]) >= 3) {
            $arr[] = $catids[$cat]['2'];
        } else {
            $arr[] = $catids[$cat]['1'];
        }
        return $arr;
    }

    /**
     * 得到内容中的所有图片
     * @author gaoqing
     * @date 2016-03-18
     * @param string $content 文章内容
     * @return array 内容中的所有图片
     */
    private function getThumbs($content){
        $matcheImgs = array();

        if(isset($content) && !empty($content)){
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
     * 处理文章的相关信息
     * @author gaoqing
     * @date 2016-03-18
     * @param array $articles 文章集
     * @return array 处理后的文章集
     */
    private function handleArticles($articles)
    {
        $handledArticles = array();
        if (isset($articles) && !empty($articles)) {
            foreach ($articles as $key => $article) {
                $article['date'] = date('Y-m-d', $article['inputtime']);
                $article['url'] = $this->getArticleWapURL($article['url']);

                //得到文章的内容信息 content
                $where = " articleid = '". $article['articleid'] ."'";
                $articleDetail = $this->_article_obj->getarticle_detail($where);
                $content = isset($articleDetail) ? $articleDetail[0]['content'] : "";

                //得到图片的总数
                $thumbs = $this->getThumbs($content);

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
     * 文章页数据集
     * @author gaoqing
     * @date 2016-03-14
     * @return string 视图
     */
    public function articledatasAction(){
        $viewName = "Article/xatp_article_datas.tpl";
        $md5URL = md5($_SERVER['REQUEST_URI']);

        //1、得到文章id $articleid
        $articleid = $this->getRequest()->getParam("articleid", 0);

        //2、根据 $articleid, 得到其相对应的栏目id: $catid 及图片附件集： $attachments
        if(isset($articleid) && !empty($articleid)){
            //得到文章所在栏目id
            $catid = $this->getCatidByArticleid($articleid);

            //根据栏目id, 得到该栏目下的文章集（不包括当前当前文章）
            $page = $this->getRequest()->getParam("page", 1);
            $url = "/pic/articledatas?articleid=" . $articleid;

            $articleDatas = $this->getPageInfo($page, $catid, $url, $articleid);
        }

        $this->view->assign("articleid", $articleid);
        $this->view->assign("articleDatas", $articleDatas);
        echo $this->view->render($viewName, $md5URL);
    }

    /**
     * 根据文章id, 得到其所在栏目的id
     * @author gaoqing
     * @date 2016-03-09
     * @param int $articleid 文章id
     * @return int 栏目的id
     */
    private function getCatidByArticleid($articleid)
    {
        $catid = 2576;
        $awhere = " articleid = '" . $articleid . "' AND status = 20 ";
        $articleInfo = $this->_article_obj->getarticle($awhere);
        if (isset($articleInfo) && !empty($articleInfo)) {
            $catid = $articleInfo[0]['catid'];
            return $catid;
        }
        return $catid;
    }

    /**
     * 得到分页信息集
     * @author gaoqing
     * @date 2015-03-07
     * @param int $page 当前页
     * @param int $catid 栏目id
     * @param int $uri uri 值
     * @param int $articleid 剔除的文章 id (如果不为0，则不包含 $articleid 的值)
     * @return array 分页信息集
     */
    private function getPageInfo($page, $catid, $uri, $articleid = 0)
    {
        $size = 12;
        $offset = ($page - 1) * $size;
        $reject = " ";
        if(!empty($articleid)){
            $reject .= " AND articleid != '" . $articleid . "'";
        }
        $where = " catid = '" . $catid . "' ". $reject ." AND status = 20 ";
        $total = $this->_article_obj->getcount($where);
        $pages = ceil($total / $size);

        //得到指定栏目的所有文章集
        $reject = " ";
        if(!empty($articleid)){
            $reject .= " AND articleid != '" . $articleid . "'";
        }
        $where = " catid = '". $catid ."' ". $reject ." AND status = 20 order by articleid DESC LIMIT ". $offset .", ". $size ." ";
        $articles = $this->_article_obj->getarticle($where);

        $articles = $this->handleArticles($articles);
        $pageHTML = $this->getAjaxPageHTML($page, $pages, $articleid);
        $articleDatas = array(
            "articles" => $articles,
            "pageHTML" => $pageHTML,
        );
        return $articleDatas;
    }

    /**
     * 得到 ajax 方式的分页代码
     * @author gaoqing
     * @date 2016-03-07
     * @param int $page 当前页
     * @param int $pages 总页数
     * @param int $articleid 文章的 id
     * @return string 分页代码
     */
    private function getAjaxPageHTML($page, $pages, $articleid){
        $pageHTML = '';
        $prePageHTML = '<a href="javascript:paging('. $articleid .', '. ($page - 1) .')">上一页</a>';
        if($page == 1){
            $prePageHTML = '';
        }
        $currPageHTML = '<span>'. $page .'/'. $pages .'</span>';

        $nextPageHTML = '<a href="javascript:paging('. $articleid .', '. ($page + 1) .')">下一页</a>';
        if($page == $pages){
            $nextPageHTML = '';
        }
        $pageHTML = $prePageHTML . $currPageHTML . $nextPageHTML;
        return $pageHTML;
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

}
