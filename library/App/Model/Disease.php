<?php

/**
 * *潘红晶 
 * 日期 2015-5 
 * */
class App_Model_Disease extends QModels_Article_Table {

    protected $_name = '9939_disease_content';

    function init() {
        parent::init();
        $this->_db = $this->getAdapter();
    }

    /**
     * 疾病列表
     * 	
     * @param 从第几条记录开始 $iStartNo
     * @param 条数 $iNum
     * @param 所属类别 $iCID 
     * @param 标题长度 $iTitleLen
     * @param 简介长度 $iIntroLen
     * @param 条件 $sWhere	 
     * @param 排序 $sOrder
     * @param 需要显示的字段 $sNeedField 	 	 
     * @param 状态 $status	 
     * @return array
     */
    public function getlist($iStartNo, $iNum, $iSection = 0, $iTitleLen = 0, $sWhere = "", $sOrder = "", $sNeedField = "", $iStatus = '99') {
        $sBasicField = "a.contentid,a.title, a.url ";
        $sNeedField = $sNeedField ? $sNeedField . "," . $sBasicField : $sBasicField;

        $sBasicOrder = " a.contentid desc";
        $sOrder = ($sOrder) ? $sOrder : $sBasicOrder;

        $sWhere = ($sWhere) ? $sWhere : 1;
        $sWhere .= ($iStatus == -1) ? "" : " AND a.status='$iStatus'";
        $sWhere .= ($iSection > 0) ? " AND b.keshi like'%$iSection%'" : "";

        $sLimit = ($iNum > 0) ? "LIMIT $iStartNo,$iNum" : "";
        $sSQL = "SELECT $sNeedField FROM 9939_dzjb a, 9939_disease_content b where a.contentid=b.contentid and a.type='1'  and $sWhere ORDER BY $sOrder $sLimit";
        $result = $this->_db->fetchAll($sSQL);
        for ($i = 0; $i < count($result); $i++) {
            $result[$i]['newTitle'] = ($iTitleLen > 0) ? mb_substr($result[$i]['title'], 0, $iTitleLen, 'utf-8') : $result[$i]['title'];
        }
        return $result;
    }
    
    /**
     * 获取疾病文章
     */
    public function getDiseaseArticle($offset = 0, $length = 5) {
        $sql = "SELECT * FROM 9939_disease_article where status=99 ORDER BY id DESC LIMIT " . $offset . "," . $length;
        $res = $this->db_v2jb_read->fetchAll($sql);
        foreach ($res as $k => $v) {
            $res[$k]['url'] = $this->handleUrl($v['url']);
        }
        return $res;
    }

    //疾病url article/2015/0129/296874.shtml
    private function handleUrl($url) {
        $arr = explode('/', $url);
        $end = array_pop($arr);
        return 'http://m.9939.com/jb/article/' . $end;
    }

    /**
     * 获取热门疾病,多发疾病
     * 
     * */
    public function getjb($sValue) {
        if ($sValue) {
            $sSQL = "select contentid,url,title from 9939_dzjb where contentid=" . $sValue;
            $result = $this->_db->fetchAll($sSQL);
            for ($i = 0; $i < count($result); $i++) {
                $result[$i]['newTitle'] = mb_substr($result[$i]['title'], 0, 6);
            }
            if (!empty($result)) {
                return $result[0];
            }
            return false;
        }
    }

    /**
     * 获取某条疾病详情
     * 
     * */
    public function getjbDetails($where) {
        if ($where) {
            $sSQL = "SELECT * FROM 9939_dzjb a,9939_disease_content b WHERE $where";
            $result = $this->_db->fetchAll($sSQL);
            return $result;
        }
    }

    public function getjbDetail($where) {
        if ($where) {
            //$sSQL = "SELECT a.title,a.contentid,a.description,b.content FROM 9939_dzjb a,9939_disease_content b WHERE $where";
            $sSQL = "SELECT a.title,a.contentid FROM 9939_dzjb a,9939_disease_content b WHERE $where";
            $result = $this->_db->fetchAll($sSQL);
            return $result;
        }
    }

    public function getjbcount($where) {
        if ($where) {
            $sSQL = "SELECT count(a.contentid) FROM 9939_dzjb a,9939_disease_content b WHERE $where";
            $result = $this->_db->fetchOne($sSQL);
            return $result;
        }
    }

    /**
     * 获取就诊科室
     * 
     * */
    public function getsectionkeshi($id) {
        if ($id) {
            $sSQL = "SELECT name FROM 9939_section_category  WHERE id=$id";
            $result = $this->_db->fetchOne($sSQL);
            return $result;
        }
    }

    /**
     * 获取所属部位
     * 
     * */
    public function getbuwei($id) {
        if ($id) {
            $sSQL = "SELECT name FROM 9939_buwei_category  WHERE id=$id";
            $result = $this->_db->fetchOne($sSQL);
            return $result;
        }
    }

}
