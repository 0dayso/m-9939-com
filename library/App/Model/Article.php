<?php

/**
 * *潘红晶 
 * 日期 2015-5 
 * */
class App_Model_Article extends QModels_Article_Table {

    protected $_name = 'article';

    function init() {
        parent::init();
        $this->_dbzx = $GLOBALS['dbzx'];
    }

    /**
     * 得到图谱的上一个图谱文章信息
     * @author gaoqing
     * 2016年3月10日
     * @param int $catID 当前图谱所在分类ID
     * @param int $articleID 当前图谱ID
     * @return array 图谱的下一个图谱文章信息
     */
    public function getLatestArticles($catID, $articleID, $offset, $count) {
        $latestArticles = array();

        $sql = "SELECT * FROM `article`  WHERE catid = " . $catID . " AND status = 20 order by `articleid` desc limit " . $offset . ", " . $count . " ";
        $latestArticles = $this->_dbzx->fetchAll($sql);
        return $latestArticles;
    }

    /**
     * 得到图谱的上一个图谱文章信息
     * @author gaoqing
     * 2016年3月09日
     * @param int $articleID 当前图谱ID
     * @param int $catID 当前图谱所在分类ID
     * @return array 图谱的下一个图谱文章信息
     */
    public function getPreArticle($articleID, $catID) {
        $preArticle = array();

        $sql = "SELECT * FROM `article`  WHERE articleid > '" . $articleID . "' AND catid = '" . $catID . "' AND status = 20 order by `articleid` desc limit 0, 1 ";
        $temp = $this->_dbzx->fetchAll($sql);
        if (!empty($temp)) {
            $preArticle = $temp[0];
        }
        return $preArticle;
    }

    /**
     * 得到图谱的下一个图谱文章信息
     * @author gaoqing
     * 2016年3月09日
     * @param int $articleID 当前图谱ID
     * @param int $catID 当前图谱所在分类ID
     * @return array 图谱的下一个图谱文章信息
     */
    public function getNextArticle($articleID, $catID) {
        $nextArticle = array();

        $sql = "SELECT * FROM `article`  WHERE articleid < '" . $articleID . "' AND catid = '" . $catID . "' AND status = 20 order by `articleid` desc limit 0, 1 ";
        $temp = $this->_dbzx->fetchAll($sql);
        if (!empty($temp)) {
            $nextArticle = $temp[0];
        }
        return $nextArticle;
    }

    public function getarticle($where, $force_index = '') {
        if ($where) {
            $sSQL = "SELECT articleid,title,catid,inputtime,updatetime,keywords,description,thumb,url FROM " . $this->_name;
            if (!empty($force_index)) {
                $sSQL.=" force index({$force_index}) ";
            }
            $sSQL.=" WHERE " . $where;
            $result = $this->_dbzx->fetchAll($sSQL);
            return $result;
        }
    }

    public function getArticleFromCache($where) {
        if ($where) {
            $sSQL = "SELECT lum_id,wap_url,articleid,title,catid,keywords,description,thumb,url,inputtime FROM article_cache WHERE " . $where;
            $result = $this->_dbzx->fetchAll($sSQL);
            return $result;
        }
    }

    public function getRelateArticleWithCache($where) {
        if ($where) {
            $sSQL = "SELECT articleid,title,catid,inputtime,updatetime,keywords,description,thumb,url FROM " . $this->_name . " WHERE " . $where;
            $cacheName = md5($sSQL);
            $cacheDir = "pages/relatearticle";
            $result = QLib_Cache_Client::getCache($cacheDir, $cacheName);
            if (!$result) {
                $result = $this->_dbzx->fetchAll($sSQL);
                $time = 24;
                QLib_Cache_Client::setCache($cacheDir, $cacheName, $result, $time);
            }
            return $result;
        }
    }

    public function getcount($where, $force_index = '') {
        if ($where) {
            $sSQL = "SELECT count(*) FROM " . $this->_name;
            if (!empty($force_index)) {
                $sSQL.=" force index({$force_index}) ";
            }
            $sSQL .= " WHERE " . $where;
            $result = $this->_dbzx->fetchOne($sSQL);
            return $result;
        }
    }

    public function getarticle_detail($where) {
        if ($where) {
            $sSQL = "SELECT * FROM article_detail WHERE " . $where;
            $result = $this->_dbzx->fetchAll($sSQL);
            return $result;
        }
    }

//============================ 2015-12-11: 新增 【热搜】、【专题】部分 Start ==========================//
    public function List_ArticleByIds($articleids = array()) {
        if (count($articleids) == 0) {
            return false;
        }
        $ids = implode(',', $articleids);
        $sql = "select * from article where articleid in ($ids) order by articleid desc";
        $result = $this->db_v2_read->fetchAll($sql);
        return $result;
    }

    public function List_DiseaseArticleByIds($articleids = array()) {
        if (count($articleids) == 0) {
            return false;
        }
        $ids = implode(',', $articleids);
        $sql = "select id,title,keywords,description,url,content,inputtime,copyfrom from 9939_disease_article where id in ($ids) order by id desc";
        $result = $this->db_v2jb_read->fetchAll($sql);
        return $result;
    }

    public function neighborDisArticle($articleid, $flag = true) {
        if ($articleid) {
            $artcon = $flag ? 'id < ' . $articleid : ' id > ' . $articleid;
            $order = $flag ? ' desc ' : ' asc ';
            $sql = "select id,title,keywords,description,url,content,inputtime,copyfrom from 9939_disease_article where " . $artcon . " order by id " . $order . " LIMIT 0,1";
            $result = $this->db_v2jb_read->fetchAll($sql);
            if ($result && is_array($result)) {
                $date_path = date('Y/md', $result['0']['inputtime']);
                $article_path = sprintf("%s/%s/%d.shtml", 'article', $date_path, $v['id']);
                $result['0']['url'] = 'http://jb.9939.com/' . $article_path;
                $result['0']['url'] = $this->getNewRuleURL($result['0']['url']);
                return $result['0'];
            } else {
                return array();
            }
        }
    }

    //============================ 2015-12-11: 新增 【热搜】、【专题】部分 End ==========================//

    /**
     * catid 获取分类下的文章
     * @param type $catid
     * @param type $offsize
     * @param type $pnum
     * @return type
     */
    public function getArticlesByCateid($catid, $offsize = 0, $pnum = 5) {
        $total = $offsize * $pnum;
        if ($total > 15) {
            return $this->getArticlesFromDbForCateid($catid, $offsize, $pnum);
        } else {
            $where = " lum_id='$catid'  order by articleid desc limit $offsize,$pnum ";
            return $this->getArticleFromCache($where);
        }
    }

    private function getArticlesFromDbForCateid($catid, $offsize = 0, $pnum = 5) {
        $_categoryurl_obj = new App_Model_Categoryurl();
        $_article_obj = new App_Model_Article();
        $cat = $_categoryurl_obj->getcategory('catid = ' . $catid);

        $where_list = '';
        $index_name = '';
        $tmp_child_ids = $cat['0']['arrchildid'];
        $tmp_catids = explode(',', $tmp_child_ids);
        $tmp_father_id = $tmp_catids[0];
        if (isset(QConfigs_Site_Config::$site_template_map[$tmp_father_id])) {
            $where_list = " channel_id ='$tmp_father_id'  and status='20' ";
        } else {
            $where_list = " catid in ('" . $tmp_child_ids . "') and status='20' ";
            $index_name = 'index_cat_status_articleid';
        }
        $where_list = " ORDER BY articleid desc LIMIT " . $offsize . "," . $pnum . "";
        $article_arry = $_article_obj->getarticle($where_list, $index_name);
        foreach ($article_arry as $k => $v) {
            //http://drug.9939.com/rqyy/2009/1118/46.shtml
            $article_arry[$k]['url'] = $this->getNewRuleURL($article_arry[$k]['url']); //修改
        }
        return $article_arry;
    }

    public function getNewRuleURL($linkurl) {
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
                $articleArr = $this->getarticle(" articleid = " . $articleid);
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
     * 获取咨询文章最大值
     * @param type $order
     * @param type $offset
     * @param type $size
     */
    public function GetArtMaxId($where, $order, $offset = 0, $size = 10) {
        $sql = 'select * from article';
        if (!empty($where)) {
            $sql.=' where ' . $where;
        }
        if (!empty($order)) {
            $sql.=' order by ' . $order;
        }
        if (isset($offset) && isset($size)) {
            $sql.=' limit ' . $offset . ',' . $size;
        }
        return $this->db_v2_read->fetchRow($sql);
    }

    /**
     * 查询文章列表
     * @param type $where
     * @param type $orderBy
     * @param type $count
     * @param type $offset
     * @return type
     */
    public function getArtList($where = array(), $orderBy = '', $count = 1000, $offset = 0) {
        $sql = "select a.articleid,a.catid,a.title,a.description,a.keywords,a.url,a.inputtime,a.channel_id,b.copyfrom from article a ,article_detail b where a.articleid = b.articleid and $where order by $orderBy limit $offset,$count ";
        return $this->db_v2_read->fetchAll($sql);
    }

    /**
     * 获取当前咨询的分类
     * @param type $catid
     * @return type
     */
    public function getcategory($catid = '') {
        $array = array();
        if (!empty($catid)) {
            $sql = "select * from category where catid = $catid";
            $category = $this->db_v2_read->fetchRow($sql);
            if ($category) {
                $sql = "select * from category where catid in (" . $category['arrparentid'] . ")";
                $array = $this->db_v2_read->fetchAll($sql);
            }
        }
        return $array;
    }

}
