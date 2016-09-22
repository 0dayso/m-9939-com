<?php
/**
**图集 model
**/
class App_Model_Attachment extends QModels_Article_Table{

	protected $_name = 'attachment';

	
	function init(){
		parent::init();
		$this->_dbzx=$GLOBALS['dbzx'];
	}

    /**
     * 根据文章的 id, 得到其对应的图集
     * @author gaoqing
     * @date 2016-03-07
     * @param int $articleid 文章id
     * @return array 对应的图集
     */
    public function getAttsByArtid($articleid, $count = null, $offset = null){
        $attachments = array();
        $where = " articleid = '". $articleid ."' ";
        $order = "aid";
        $attachments = $this->fetchAll($where, $order, $count, $offset)->toArray();

        return $attachments;
    }

    /**
     * 得到图集总数
     * @author gaoqing
     * @date 2016-03-07
     * @param int $articleid 文章id
     * @return int 对应的图集总数
     */
    public function getAttSizeByArtid($articleid){
        $count = 0;

        $where = " articleid = '". $articleid ."' ";
        $attachments = $this->fetchAll($where, null, null, null)->toArray();
        if(isset($attachments)){
            $count = count($attachments);
        }
        return $count;
    }

}