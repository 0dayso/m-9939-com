<?php
header("Content-Type:text/html;charset=utf-8");

/**
 * 医生的实体类
 * @author gaoqing
 * 2015-08-26
 */
class App_Model_Doctor extends App_BaseTable{
	
	//设置当前 model 的默认值
	protected $_name = null;
	protected $_primary = null;
	protected $_db = null;
	
	/** 表名称 */
	private $table_name = "member";
	
	/** 数据库连接对象 */
	private $conntion = null;
	
	protected function _setup(){
		$this->_name = "member";
		$this->_primary = "uid";
		$this->_db = $GLOBALS['dbwd'];
		
		parent::_setup();
	}
	
	public function init() {
		parent::init();
		
		$this->conntion = $GLOBALS['dbwd'];
		
		//假的：方便开发
		//$this->conntion = $this->getAdapter();
	}
	
	/**
	 * 修改用户的信息
	 * @author gaoqing
	 * 2015年9月10日
	 * @param int $uid 要修改的用户 id
	 * @param array $data 要修改的信息
	 * @return int 修改后成功的行数
	 */
	public function updateUserInfo($uid, $data) {
		$updateRowNum = 0;
	
		$where = $this->_db->quoteInto("uid = ?", $uid);
		$updateRowNum = $this->update($data, $where);
	
		return $updateRowNum;
	}
	
	/**
	 * 得到所有科室的医生分页信息 
	 * @author gaoqing
	 * 2015年9月7日
	 * @param int $start 分页的开始位置
	 * @param int $pageSize 分页时每页显示数
	 * @return array 所有科室的医生分页信息 
	 */
	public function getAllDepartmentDoctors($start, $pageSize) {
		$doctorBasicInfoArr = array();
		
		$sql = " SELECT m.uid, m.nickname, m.credit, m.friendnum, m.pic, m.groupname, ".
				" md2.truename, md2.zhicheng, md2.doc_hos, md2.doc_keshi, md2.memo, md2.best_dis, md2.description ".
				" FROM member m, member_detail_2 md2 ".
				" where m.uid = md2.uid and m.status = 1 and m.uType = 2 and md2.doc_keshi != '' ".
				" ORDER BY m.credit DESC, m.experience DESC LIMIT  " . $start . ", " . $pageSize;
		
		$statement = $this->conntion->prepare($sql);
		$statement->execute();
		
		while ($doctorBasicInfo = $statement->fetch(PDO::FETCH_ASSOC)) {
			$doctorBasicInfo['pic'] = "http://home.9939.com/upload/pic". $doctorBasicInfo['pic'];
				
			$doctorBasicInfo['best_dis'] = $this->cutString($doctorBasicInfo['best_dis'], 11, 1);
			$doctorBasicInfo['truename'] = empty($doctorBasicInfo['truename']) ? $doctorBasicInfo['nickname'] : $doctorBasicInfo['truename'];
				
			$doctorBasicInfoArr[] = $doctorBasicInfo;
		}
		return $doctorBasicInfoArr;		
	}
	
	/**
	 * 得到所有地区的医生分页信息 
	 * @author gaoqing
	 * 2015年9月7日
	 * @param int $start 分页的开始位置
	 * @param int $pageSize 分页时每页显示数
	 * @return array 所有科室的医生分页信息 
	 */
	public function getAllAreaDoctors($start, $pageSize) {
		$doctorBasicInfoArr = array();
		
		$sql = " SELECT m.uid, m.nickname, m.credit, m.friendnum, m.pic, m.groupname, ".
				" md2.truename, md2.zhicheng, md2.doc_hos, md2.doc_keshi, md2.memo, md2.best_dis, md2.description ".
				" FROM member m, member_detail_2 md2 ".
				" where m.uid = md2.uid and m.status = 1 and m.uType = 2 and md2.address != '' ".
				" ORDER BY m.viewnum, m.experience DESC, m.credit DESC LIMIT  " . $start . ", " . $pageSize;
		
		$statement = $this->conntion->prepare($sql);
		$statement->execute();
		
		while ($doctorBasicInfo = $statement->fetch(PDO::FETCH_ASSOC)) {
			$doctorBasicInfo['pic'] = "http://home.9939.com/upload/pic". $doctorBasicInfo['pic'];
				
			$doctorBasicInfo['best_dis'] = $this->cutString($doctorBasicInfo['best_dis'], 11, 1);
			$doctorBasicInfo['truename'] = empty($doctorBasicInfo['truename']) ? $doctorBasicInfo['nickname'] : $doctorBasicInfo['truename'];
				
			$doctorBasicInfoArr[] = $doctorBasicInfo;
		}
		return $doctorBasicInfoArr;		
	}
	
	/**
	 * 得到所有地区的医生数 
	 * @author gaoqing
	 * 2015年9月7日
	 * @param void 空
	 * @return void 空
	 */
	public function getAllAreaDoctorsCount() {
		$allAreaDoctorsCount = 0;
		
		$sql = $this->getSQL(true, " count(*) ", ' AND address != "" ', null, null, null, "member_detail_2");
		$statement = $this->conntion->prepare($sql);
		$statement->execute();
		$temp = $statement->fetch(PDO::FETCH_NUM);
		
		if (!empty($temp)) {
			$allAreaDoctorsCount = $temp[0];
		}
		return $allAreaDoctorsCount;
	}
	
	/**
	 * 得到所有科室的医生数 
	 * @author gaoqing
	 * 2015年9月7日
	 * @param void 空
	 * @return void 空
	 */
	public function getAllDepartmentDoctorsCount() {
		$allDepartmentDoctorsCount = 0;
		
		$sql = $this->getSQL(true, " count(*) ", ' AND doc_keshi != "" ', null, null, null, "member_detail_2");
		$statement = $this->conntion->prepare($sql);
		$statement->execute();
		$temp = $statement->fetch(PDO::FETCH_NUM);
		
		if (!empty($temp)) {
			$allDepartmentDoctorsCount = $temp[0];
		}
		return $allDepartmentDoctorsCount;
	}
	
	/**
	 * 添加会员
	 * @author gaoqing
	 * 2015年9月7日
	 * @param array $user 会员信息
	 * @return int 会员 ID
	 */
	public function addMember($user) {
		$userID = 0;
		if (!empty($user)) {
			$userID = $this->insert($user);
		}
		return $userID;
	}
	
	/**
	 * 根据医生的 id, 得到当前医生的基本信息
	 * @author gaoqing
	 * 2015年9月2日
	 * @param int $uid 医生的 id
	 * @param boolean $isComplete 是否是需要完整信息 （擅长、简介 完整输出）默认不是完整信息
	 * @return array 当前医生的基本信息
	 */
	public function getDoctorBasicInfoByid($uid, $isComplete = false) {
		$doctorBasicInfoArr = array();
		
		$sql = " SELECT m.uid, m.nickname, m.credit, m.friendnum, m.pic, m.groupname, ". 
			   " md2.truename, md2.zhicheng, md2.doc_hos, md2.doc_keshi, md2.memo, md2.best_dis, md2.description ".
			   " FROM member m, member_detail_2 md2 ".
			   " where m.uid = md2.uid and m.status = 1 and m.uType = 2 and m.uid = ?   ";
		
		$statement = $this->conntion->prepare($sql);
		$statement->execute(array($uid));
		
		while ($doctorBasicInfo = $statement->fetch(PDO::FETCH_ASSOC)) {
			$doctorBasicInfo['pic'] = "http://home.9939.com/upload/pic". $doctorBasicInfo['pic'];
			$doctorBasicInfo['memo'] = empty($doctorBasicInfo['memo']) ? $doctorBasicInfo['description'] : $doctorBasicInfo['memo'];
			
			//显示简短信息
			if (!$isComplete) {
				$doctorBasicInfo['best_dis'] = $this->cutString($doctorBasicInfo['best_dis'], 73, 1);
				$doctorBasicInfo['memo'] = $this->cutString($doctorBasicInfo['memo'], 55, 1);
			}
			$doctorBasicInfo['truename'] = empty($doctorBasicInfo['truename']) ? $doctorBasicInfo['nickname'] : $doctorBasicInfo['truename'];
			
			$doctorBasicInfoArr = $doctorBasicInfo;
		}
		//处理为空的情况
		if (empty($doctorBasicInfoArr)) {
			$doctorBasicInfoArr['uid'] = 0;
			$doctorBasicInfoArr['nickname'] = "";
			$doctorBasicInfoArr['credit'] = 0;
			$doctorBasicInfoArr['friendnum'] = 0;
			$doctorBasicInfoArr['pic'] = "";
			$doctorBasicInfoArr['groupname'] = "";
			$doctorBasicInfoArr['truename'] = "";
			$doctorBasicInfoArr['zhicheng'] = "";
			$doctorBasicInfoArr['doc_hos'] = "";
			$doctorBasicInfoArr['doc_keshi'] = "";
			$doctorBasicInfoArr['memo'] = "";
			$doctorBasicInfoArr['best_dis'] = "";
			$doctorBasicInfoArr['description'] = "";
		}
		return $doctorBasicInfoArr;
	}
	
	/**
	 * 得到医生的详细信息
	 * @author gaoqing
	 * 2015年9月6日
	 * @param int $uid 医生的 id
	 * @return array 医生的简短详细信息
	 */
	public function getDoctorDetail($uid) {
		$simpleDoctorDetail = array();
		
		$sql = $this->getSQL(true, " md2.truename, md2.zhicheng, md2.doc_hos, md2.doc_keshi, md2.memo, md2.best_dis, md2.description ", "", 0, 1, null);
		$statement = $this->conntion->prepare($sql);
		$statement->execute(array($uid));
		$simpleDoctorDetail = $statement->fetch(PDO::FETCH_ASSOC);
		
		return $simpleDoctorDetail;
	}
	
	/**
	 * 得到指定数量医生的简单信息 
	 * @author gaoqing
	 * 2015年8月26日
	 * @param int $num 要获取医生的数量
	 * @param mixed $other 其他条件
	 * @return array 指定数量医生的简单信息集
	 */
	public function getDoctorSimpleInfos($num) {
		$doctorSimpleInfoArr = array();
		
		$sql = " SELECT m.uid, m.nickname, m.pic, md2.zhicheng FROM member m, member_detail_2 md2 where m.uid = md2.uid and m.status = 1 and m.uType = 2 order by m.experience DESC limit 0, " . $num;
		$statement = $this->conntion->prepare($sql);
		$statement->execute();
		
		while ($doctorSimpleInfo = $statement->fetch(PDO::FETCH_ASSOC)) {
			$doctorSimpleInfo['pic'] = "http://home.9939.com/upload/pic" . $doctorSimpleInfo['pic'];
			
			$doctorSimpleInfoArr[] = $doctorSimpleInfo;
		}
		return $doctorSimpleInfoArr;
	}
	
	/**
	 * 得到查询的 SQL 语句
	 * @author gaoqing
	 * 2015年8月31日
	 * @param boolean $isSimple 是否使用最简单的条件
	 * 						      （当为 true 时，如果 $start、$limitLen、$order 都为 null 时，则不使用默认的值，直接不添加相应的条件）
	 * @param int $selectField 要查询的字段
	 * @param int $where 查询条件
	 * @param int $start 查询条数限制的 开始 位置值
	 * @param int $limitLen limit 中的限制长度值
	 * @param int $order 排序规则
	 * @param string $dbName 表名称
	 * @return string 查询医生的 SQL 语句
	 */
	private function getSQL(
				$isSimple = true, 
				$selectField = null, 
				$where = null, 
				$start = null,
				$limitLen = null, 
				$order = null,
				$dbName = "member") 
	{
		$sql = "";
	
		//查询字段
		$selectFieldStr = empty($selectField) ? " * " : $selectField ;
	
		//查询条件
		$baseWhere = ($dbName == "member" ? " WHERE status = 1  " : " WHERE 1 = 1 ");
		$whereStr = empty($where) ? $baseWhere : $baseWhere . $where ;
		
		$defaultOrderStr = " ";
		if (!$isSimple) {
			$defaultOrderStr = " ORDER BY uid ";
		}
		//排序条件
		$orderStr = empty($order) ? $defaultOrderStr : $order ;
	
		//查询条数限制
		$limitStr = "";
		if (!empty($limitLen)) {
			$startNum = empty($start) ? 0 : $start;
			$limitStr = " LIMIT " . $startNum ." , " . $limitLen;
		}
		$sql = " SELECT ". $selectFieldStr ." FROM " . $dbName . $whereStr . $orderStr . $limitStr;
		return $sql;
	}	
	
	
	
	
}


?>