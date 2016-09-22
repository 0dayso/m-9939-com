<?php

/**
 * *潘红晶 
 * 日期 2015-5 
 * */
class App_Model_Categoryurl extends App_BaseTable {

    protected $_name = 'category';

    /** 数据库连接对象 */
    private $conntion = null;

    function init() {
        $this->_dbzx = $GLOBALS['dbzx'];
        $this->conntion = $GLOBALS['dbzx'];
    }

    public function getcategory($where) {
        if ($where) {
            $sSQL = "SELECT catid,parentid,arrparentid,arrchildid,catname,parentdir,catdir,url,child,setting FROM " . $this->_name . " WHERE " . $where;
            $result = $this->_dbzx->fetchAll($sSQL);
            return $result;
        }
    }
    /**
     *  获取 某一栏目下 所有子栏目 的  信息
     */
    public function getSubCatgory($catid = 0) {
        $sql = "SELECT catid, catname, parentid FROM `Category` 
			  WHERE parentid =".$catid." 
			      OR parentid IN ( SELECT catid FROM `Category` WHERE parentid =".$catid.")
                  ORDER BY parentid ASC , catid ASC ";

        //$result = $this->_db->fetchAll("SELECT catname,catid FROM `Category` where parentid = '$catid'");

        $result = $this->_dbzx->fetchAll($sql);
        return $result;
    }
    /**
     * 生成 category 的缓存文件 <br />
     * 格式：url => array("arrparentid" => "", "url" => "");
     * @author gaoqing
     * 2015年12月7日
     * @param void 空
     * @return void 空
     */
    public function generateCategoryCache() {
    	$sSQL = "SELECT arrparentid, url, catdir, parentdir, catid, child, parentid, arrchildid, catname FROM category where isHidden = 0  " ;
    	$statement = $this->conntion->prepare($sSQL);
    	$statement->execute();
    	
    	$categoryStr = "<?php ";
    	$categoryStr .= "return array(" . PHP_EOL;
    	
    	while ($temp = $statement->fetch(PDO::FETCH_ASSOC)) {
    		//得到当前分类的相关信息
    		$this->getRelativeInfo($temp);
    		
    		$categoryStr .= "'". $temp['wap_url'] ."' => array(" . PHP_EOL;
    		
    		foreach ($temp as $key => $val){
    			$categoryStr .= "'". $key ."' => ";
    			if (is_array($val)) {
    				$categoryStr .= "array(";
    				foreach ($val as $innerVal){
    					$categoryStr .= "'". $innerVal ."',";
    				}
    				$categoryStr .= ")";
    			}else if(is_int($val)){
    				$categoryStr .=  $val;
    			}else {
    				$categoryStr .= "'". $val ."'";
    			}
    			$categoryStr .= "," . PHP_EOL;
    		}
    		$categoryStr .= ")," . PHP_EOL;
    	}
    	
    	$categoryStr .= ");" . PHP_EOL;
    	$categoryStr .= " ?>";
    	
    	//生成到缓存文件中
    	$filename = "/data/www/develop/trunk/m-9939-com/public/cache/url_category.php";
    	file_put_contents($filename, $categoryStr);
    }
	
	/**
	 * 得到当前分类的相关信息
	 * 
	 * @author gaoqing
	 *         2015年12月7日
	 * @param array $category
	 *        	当前分类数据集
	 * @return void 空
	 */
	private function getRelativeInfo(&$category) {
		$urlArr = array();
		$pattern = "/http:\/\/([a-zA-Z]+).9939.com([\s\S]*)/";
		preg_match($pattern, $category ['url'], $urlArr);
		
		$domainName = isset($urlArr[1]) ? $urlArr[1] : "";
		$uri = isset ( $urlArr [2] ) ? $urlArr [2] : "";
		$uri = trim ( $uri, "/" );
		$wap_url = "";
		
		if (empty ( $uri )) {
			$pc_root_channel_url = 'http://www.9939.com';
			$wap_root_channel_url = 'http://m.9939.com';
			$wap_url = $wap_root_channel_url . "/" . $domainName;
			$url_path_params[] = $domainName;
			$category ['url_path_params'] = $url_path_params;
		}else{
		
		$url_path_params = explode ( "/", $uri );
		array_unshift ( $url_path_params, $domainName );
		$channel_enname = $url_path_params [0];
		$pc_root_channel_url = sprintf ( 'http://%s.9939.com/', $channel_enname );
		$domain = str_replace ( '//', '/', '/' . $channel_enname . '/' );
		$wap_root_channel_url = 'http://m.9939.com' . $domain;
		
		$last_url_name = $url_path_params [count ( $url_path_params ) - 1];
		$curr_path_arr = array ();
		switch (strtolower ( $last_url_name )) {
			case "nav.shtml" :
			case "list.shtml" :
				{
					$curr_path_arr = array_slice ( $url_path_params, 0, - 1 );
					break;
				}
			default :
				{
					if (stripos ( $last_url_name, '.shtml' ) !== false) {
						$curr_path_arr = array_slice ( $url_path_params, 0, - 1 );
					} else {
						$curr_path_arr = $url_path_params;
					}
					break;
				}
		}
		array_splice ( $curr_path_arr, 0, 1, trim ( $wap_root_channel_url, '/' ) );
		$wap_url = implode ( '/', $curr_path_arr );
		
		$category ['url_path_params'] = $url_path_params;
		}
		$parent_ids = explode ( ",", $category ['arrparentid'] );
		$channel_id = count ( $parent_ids ) >= 2 ? $parent_ids [1] : 0;
		
		$category ['channel_id'] = $channel_id;
		$category ['channel_enname'] = $domainName;
		$category ['wap_url'] = trim ( $wap_url, '/' ) . '/';
		$category ['pc_root_channel_url'] = trim ( $pc_root_channel_url, "/" ) . "/";
		$category ['channel_url'] = trim ( $wap_root_channel_url, "/" ) . "/";
		$category ['pc_url'] = trim ( $category ['url'], '/' ) . '/';
	}
    
    /**
     * 得到以频道 catid key , 后 url (/yfbj/yszy/) 为 value 的 map 值
     * @author gaoqing
     * 2015年10月22日
     * @return array catid 键值对数组
     */
    public function getAllCatidMap() {

        $sSQL = "SELECT catid,url FROM category ";
        $result = array();
        $statement = $this->conntion->prepare($sSQL);
        $statement->execute();

        while ($temp = $statement->fetch(PDO::FETCH_ASSOC)) {

            $url = $temp['url'];
            $domainArr = array();
            preg_match("/http:\/\/([\S]*?).9939.com\/([\S]*?)\/?$/", $url, $domainArr);
            $endURLPart = "";
            if (!empty($domainArr)) {
                $endURLPart = isset($domainArr[2]) ? $domainArr[2] : "";
            }
            $result[$temp['catid']] = $endURLPart;
        }
        return $result;
    }

    /**
     * 根据 url 得到频道的 catdir 的值
     * @author gaoqing
     * 2015年10月22日
     * @param string $url url的值
     * @return array catdir 的值
     */
    public function getCatdirByURL($url) {
        $url = trim($url, '/');
        $fullUrl = $url . "/";
        $sSQL = "SELECT catid,parentid,arrparentid,arrchildid,catname,parentdir,catdir,url,child,setting FROM category WHERE url in ('" . $url . "','" . $fullUrl . "')  AND parentid = 0 ";
        $statement = $this->conntion->prepare($sSQL);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);

        return $result;
    }

    /**
     * 根据 url 得到频道的 catid 的值
     * @author gaoqing
     * 2015年10月22日
     * @param string $url url的值
     * @return array catid 的值
     */
    public function getCatidByURL($url) {
        //去掉 "/"
        $length = strlen($url);
        $url = trim($url, '/');
        $fullUrl = $url . "/";
        $sSQL = "SELECT catid,parentid,arrparentid,arrchildid,catname,parentdir,catdir,url,child,setting  FROM category WHERE  url in ('" . $url . "','" . $fullUrl . "') ";
        $statement = $this->conntion->prepare($sSQL);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);

        return $result;
    }

    public function getAllChannel() {
        $sSQL = "SELECT arrchildid,url, child FROM " . $this->_name . " where parentid = 0";
        $result = $this->_dbzx->fetchAll($sSQL);

        return $result;
    }

    public function getAllCategory($arrchildidStr) {
        $result = array();
        if (isset($arrchildidStr) && !empty($arrchildidStr)) {

            $arrchildidArr = explode(",", $arrchildidStr);

            $where = implode(",", $arrchildidArr);
            $sSQL = "SELECT catid,parentid,parentdir,catdir,url,arrchildid,child, catname FROM " . $this->_name . " WHERE catid in (" . $where . ") ";
            $result = $this->_dbzx->fetchAll($sSQL);
        }
        return $result;
    }

}
