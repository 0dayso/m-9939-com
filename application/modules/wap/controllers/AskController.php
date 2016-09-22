<?php
/**
**潘红晶 
* 日期 2015年5月
**/
class AskController extends Q_Controller_Smarty{
    var $_ask_obj                       = null;
    
    /** 医生实体类 */
    private $doctor = null;
    
    /** HTML 的过滤器 */
    private $htmlFilter = null;
    
    /** 整数 的过滤器 */
    private $intFilter = null;    
    
    /** 整理字符串 */
    private $stringTrim = null;
    
    function init(){
		parent::init();
		$this->initView();

        $this->_ask_obj             = new App_Model_Ask();
        
        $this->htmlFilter = new Zend_Filter_HtmlEntities();
        $this->intFilter = new Zend_Filter_Int();
        $this->stringTrim = new Zend_Filter_StringTrim();
        $this->doctor = new App_Model_Doctor();        
	}
	
	/**
	 * 用户问答详情页
	 * @author gaoqing
	 * 2015年9月10日
	 * @param void 空
	 * @return void 空
	 */
	public function useraskdetailAction() {
		$request = $this->getRequest();
		
		$initUserid = $request->getParam("userid", 0);
		$initAskid = $request->getParam("askid", 0);
		
		$userid = $this->intFilter->filter($initUserid);
		$askid = $this->intFilter->filter($initAskid);
		
		//1、根据问题 id ，查询出问题的信息
		$askInfo = $this->_ask_obj->getAskInfo($askid, true);
		
		//2、根据问题 id，查询出所有回答（回答信息中，包括回答信息、回答医生信息）
		$bestAnswerID = empty($askInfo['bestanswer']) ? 0 : $askInfo['bestanswer'];
		$answerInfo = $this->_ask_obj->getAskDoctorAnswer($askid, $bestAnswerID);
		
		$this->view->assign("userid", $userid);
		$this->view->assign("askid", $askid);
		$this->view->assign("askInfo", $askInfo);
		$this->view->assign("answerInfo", $answerInfo);
		
		$md5URL = md5(uniqid());
		echo $this->view->render("Ask/userAskDetail.tpl", $md5URL);
	}
	
	/**
	 * 验证用户是否存在
	 * @author gaoqing
	 * 2015年9月10日
	 * @param void 空
	 * @return void 空
	 */
	public function checkuserexistAction() {
		$request = $this->getRequest();
		
		$initUsername = $request->getParam("username", "");
		$username = $this->htmlFilter->filter($initUsername);
		
		//用户存在标识（1：存在；0：不存在）
		$userExistFlag = "0";
		$user = $this->_ask_obj->getUserByName($username);
		if (!empty($user)) {
			$userExistFlag = "1";
		}
		$result = array('flag' => $userExistFlag);
		echo json_encode($result);
	}
	
	/**
	 * 更改用户名及密码的方法
	 * @author gaoqing
	 * 2015年9月10日
	 * @param void 空
	 * @return void 空
	 */
	public function updateuserAction() {
		$request = $this->getRequest();
		
		//1、得到用户名 、密码
		$initUserid = $request->getParam("userid", 0);
		$initUserName = $request->getParam("username", "");
		$initPassword = $request->getParam("password", "");
		$initBeforePassword = $request->getParam("beforePassword", "");
		
		$userid = $this->intFilter->filter($initUserid);
		$username = $this->htmlFilter->filter($initUserName);
		$password = $this->htmlFilter->filter($initPassword);
		$beforePassword = $this->htmlFilter->filter($initBeforePassword);
		
		//根据用户名，查询当前用户名是否存在
		$userByName = $this->_ask_obj->getUserByName($username);
		
		//用户存在：
		if (isset($userByName) && !empty($userByName)) {
			
			//根据用户的 id ，查询用户的原始基本信息
			$user = $this->doctor->getUser($userid);
			$this->view->assign("userid", $userid);
			$this->view->assign("username", $user['username']);
			$this->view->assign("password", $beforePassword);
			$this->view->assign("upUsername", $username);
			$this->view->assign("upPassword", $password);
			
			//返回 “用户名存在”的提示
			$this->view->assign("errorInfo", "用户名存在！");
			
			$md5URL = md5($userid);
			echo $this->view->render("Ask/updateUserInfo.tpl", $md5URL);
		}
		//用户不存在：
		else {
			
			//2、根据用户的 id ，修改该用户的 用户名、密码
			$updateRowNum = $this->doctor->updateUserInfo($userid, array("username" => $username, "password" => md5($password)));
			
			$rendTpl = "Ask/userAsk.tpl";
			
			//2.1、更新成功后，跳转到当前用户的问答列表中
			if ($updateRowNum) {
				
				//2.1.1、根据当前用户的 id ,查询其所有的提问
				$userAskArr = $this->_ask_obj->getAllAskByUserid($userid);
				
				$this->view->assign("userAskArr", $userAskArr);
				$this->view->assign("username", $username);
				$this->view->assign("password", md5($password));
			
			//2.2、修改失败后，跳转回之前修改的页面	
			}else {
				$rendTpl = "Ask/updateUserInfo.tpl";
			}
			
			$this->view->assign("userid", $userid);
	
			$md5URL = md5($userid);
			echo $this->view->render($rendTpl, $md5URL);
		}
		
	}
	
	/**
	 * 用户问答列表
	 * @author gaoqing
	 * 2015年9月16日
	 * @param void 空
	 * @return void 空
	 */
	public function userasklistAction(){
		$request = $this->getRequest();
		$userAskArr = array();
		$initUserid = $request->getParam("userid", 0);
		$userid = $this->intFilter->filter($initUserid);
		
		//判断用户是否登录，如果未登录，则跳转到登录界面
		Zend_Session::start();
		$authNamespace = new Zend_Session_Namespace('userid'.$userid);
		$key = "userid".$userid;
		if (isset($authNamespace->$key)) {
			if (!empty($userid)) {
				$userAskArr = $this->_ask_obj->getAllAskByUserid($userid);
			}
			$this->view->assign("userAskArr", $userAskArr);
			$this->view->assign("userid", $userid);
			
			$md5URL = md5(uniqid());
			echo $this->view->render("Ask/userAsk.tpl", $md5URL);
		}else {
			$this->_redirect("http://wapask.9939.com/login");
		}		
	}
	
	/**
	 * 问答详情
	 * @author gaoqing
	 * 2015年9月8日
	 * @param void 空
	 * @return void 空
	 */
	public function askdetailAction() {
		$request = $this->getRequest();
		
		$initAskID = $request->getParam("askid", 0);
		$initClassID = $request->getParam("classid", 0);
		$askID = $this->intFilter->filter($initAskID);
		$classid = $this->intFilter->filter($initClassID);
		
		//1、获取当前问题的具体信息
		$askInfo = $this->_ask_obj->getAskInfo($askID);
		
		//2、获取当前问题的所有医生回答信息
		$askDoctorAnswer = $this->_ask_obj->getAskDoctorAnswer($askID);
		
		if (!empty($askInfo) && empty($classid)) {
			$classid = $askInfo['classid'];
		}
		//3、相关问题信息
		$relateAskInfoArr = $this->_ask_obj->getRelateAskInfoArr($askID, $classid, 0, 6);
		
		$this->view->assign("askInfo", $askInfo);
		$this->view->assign("askDoctorAnswer", $askDoctorAnswer);
		$this->view->assign("relateAskInfoArr", $relateAskInfoArr);
		
		$md5URL = md5($_SERVER['REQUEST_URI']);
		echo $this->view->render("Ask/askAnswerDetail.tpl", $md5URL);
	}
	
	/**
	 * 向医生提问
	 * @author gaoqing
	 * 2015年9月7日
	 * @param void 空
	 * @return void 空
	 */
	public function askdoctorAction(){
		$request = $this->getRequest();
		
		/*
		 * 1、判断当前用户是否之前已经登录过
		 * 	1.1、如果未登录：
		 * 		1.1.1、生成一个随机用户，更新到数据库中
		 * 		1.1.2、得到当前新生成的用户的 id, 并将当前问题与当前用户进行关联
		 * 		1.1.3、更新当前提问的问题到数据库中，并跳转到 更新随机用户的用户信息中
		 * 	1.2、如果已登录：
		 * 		1.2.1、验证当前传递的用户信息，是否正确，如果不正确，则分配一个随机用户
		 * 		1.2.2、得到当前登录的用户 id,将提问的问题与用户 id 进行关联，更新到数据库中
		 * 		1.2.3、根据当前用户的 id ，得到当前用户下，所有的问题
		 * 		1.2.4、直接跳转到当前用户的问题列表中
		 */
		$md5URL = "";
		$initDoctorID = $request->getParam("doctorID", 0);
		$initUserid = $request->getParam("userid", 0);
		
		$userid = $this->intFilter->filter($initUserid);
		
		//默认的模式是：更新用户界面
		$renderTPL = "Ask/updateUserInfo.tpl";
		
		//1、判断当前用户是否之前已经登录过
		if (empty($userid)) {
			//1.1、如果未登录：
			$this->userNotExistHandle($request);
			$md5URL = md5($this->view->userid);
		}else {
		
			//判断用户是否登录，如果未登录，则跳转到登录界面
			Zend_Session::start();
			$authNamespace = new Zend_Session_Namespace('userid'.$userid);
			$key = "userid".$userid;
			if (isset($authNamespace->$key)) {
				//1.2、如果已登录：
				
				//1.2.1、验证当前传递的用户信息，是否正确，如果不正确，则分配一个随机用户
				$userInfo = $this->doctor->checkUserExist($userid, null, null);
				
				//用户信息正确：
				if (!empty($userInfo)) {
					
					//1.2.2、得到当前登录的用户 id,将提问的问题与用户 id 进行关联，更新到数据库中
					$askArr = $this->getAskArr($request, $userid);
					$askID = $this->_ask_obj->askDoctor($askArr);
					
					$this->view->assign("userid", $userid);
					
					//1.2.4、直接跳转到当前用户的问题列表中
					$this->_redirect("http://wapask.9939.com/ask/userasklist?userid=" . $userid);
					
				//用户信息不正确：	
				}else {
					$this->userNotExistHandle($request);
					$md5URL = md5($this->view->userid);
				}
			}
			//未登录：
			else {
				$this->userNotExistHandle($request);
				$md5URL = md5($this->view->userid);
			}
		}
		//跳转到修改用户名和密码的界面
		echo $this->view->render($renderTPL, $md5URL);
	}
	
	/**
	 * 用户不存在时的操作
	 * @author gaoqing
	 * 2015年9月14日
	 * @param Zend_Controller_Request_Abstract $request request对象
	 * @return void 空
	 */
	 private function userNotExistHandle($request) {
		
		//1、随机生成用户
		$randUser = $this->randExecuteUser();
		//未加密前的密码
		$initPassword = $randUser['initpassword'];
		unset($randUser['initpassword']);
		
		//插入到 member 表中
		$randUserID = $this->doctor->addMember($randUser);
		
		//2、得到提交的数据
		$askArr = $this->getAskArr($request, $randUserID);
		
		//3、更新到数据库中
		$askID = $this->_ask_obj->askDoctor($askArr);
		
 		//设置用户 userid 到 session 中
		Zend_Session::start();
		$authNamespace = new Zend_Session_Namespace('userid'.$randUserID);
		$key = "userid".$randUserID;
		if (!isset($authNamespace->$key)) {
			$authNamespace->$key = $randUserID;
			$authNamespace->setExpirationSeconds(2*7*24*60*60);
		}
		
		//输出所需信息（随机：用户名、密码、用户 id ）
		$this->view->assign("userid", $randUserID);
		$this->view->assign("username", $randUser['username']);
		$this->view->assign("md5password", md5($initPassword));
		$this->view->assign("password", $initPassword);
		
		return null;
	}

	
	/**
	 * 匿名用户的话，随机生成用户信息
	 * @author gaoqing
	 * 2015年9月7日
	 * @param void 空
	 * @return void 空
	 */
	private function randExecuteUser(){
		$randUser = array();
		
		//随机生成用户名和密码
		$aChars = range('a','z');
		shuffle($aChars);
		$sImpchars = implode('',$aChars);
		$username = substr($sImpchars,0,5);
		$pwd = rand(100000, 999999);
		
		//设置用户信息
		$randUser['username'] = $username;
		$randUser['initpassword'] = $pwd;
		$randUser['password'] = md5($pwd);
		$randUser['dateline'] = time();
		$randUser['nickname'] = $username;
		$randUser['uType'] = 1;
		$randUser['zdpassword'] = md5($pwd);	
		$randUser['from'] = 'wap';
		
		return $randUser;
	}
	
	/**
	 * 得到提交的问题信息
	 * @author gaoqing
	 * 2015年9月7日
	 * @param Zend_Controller_Request_Abstract $request request 对象
	 * @param int $randUserID 随机生成的用户 ID
	 * @return array 提交的问题信息
	 */private function getAskArr($request, $randUserID) {
		$askArr = array();
		
		$initTitle = $request->getParam("title", 0);
		$initContent = $request->getParam("content", "");
		$initSex = $request->getParam("sex", 1);
		$initAge = $request->getParam("age", 0);
		$initHelp = $request->getParam("help", "");
		
		$askArr['title'] = $this->htmlFilter->filter($initTitle);
		$askArr['content'] = $this->htmlFilter->filter($initContent);
		$askArr['ctime'] = time();
		$askArr['age'] = $this->intFilter->filter($initAge);
		$askArr['sexnn'] = $this->intFilter->filter($initSex);
		$askArr['help'] = $this->htmlFilter->filter($initHelp);
		
		//设置默认的值
		$askArr['classid'] = 0;
		$askArr['isReal'] = 1;
		
		//来自 wap 站
		$askArr['source'] = 2;
		
		//分配默认的用户
		$askArr['userid'] = empty($randUserID) ? 0 : $randUserID;
		
		return $askArr;
	}

	
	/**
	 * 向医生提问的跳转页方法
	 * @author gaoqing
	 * 2015年9月7日
	 * @param void 空
	 * @return void 空
	 */
	public function goaskdoctorAction(){
		$request = $this->getRequest();
		
		$initDoctorID = $request->getParam("doctorID");
		
		$doctorID = $this->intFilter->filter($initDoctorID);
		
		$renderTpl = "Ask/askDoctor.tpl";
		
		//向医生提问部分
		if (isset($initDoctorID) && !empty($initDoctorID)) {
			
			//1、获取医生的疾病信息
			$doctorBasicInfo = $this->doctor->getDoctorBasicInfoByid($doctorID, true);	
			$this->view->assign("doctorBasicInfo", $doctorBasicInfo);
			$this->view->assign("doctorID", $doctorID);
		}else {
			
			//我要提问部分
			$renderTpl = "Ask/singleAskPage.tpl";
		}
		
		$md5URL = md5($_SERVER['REQUEST_URI']);
		echo $this->view->render($renderTpl, $md5URL);
	}
	
	function showAction(){
        $id = intval($this->getParam("askid"));
        $where=" id=".$id;
        $result=$this->_ask_obj->Getask($where);
        $result[0]['ctime']=date("Y-m-d H:i:s", $result[0]['ctime']);
        $this->view->assign('result',$result[0]);
        $url=md5($_SERVER['REQUEST_URI']);
        echo $this->view->render('Ask/Ask_details.tpl',$url);
	}
	
}