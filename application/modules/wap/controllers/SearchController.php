<?php

/**
 * 搜索模块的 controller 
 * @author gaoqing
 * 2015-08-28
 */
 class SearchController extends Q_Controller_Smarty{
 	
 	/** 疾病 Model */
 	private $disease = null;
 	
 	/** 问答 Model */
 	private $ask = null;
 	
 	/** 科室 Model */
 	private $department = null;
 	
 	/** HTML 的过滤器 */
 	private $htmlFilter = null;
 	
 	/** 整数 的过滤器 */
 	private $intFilter = null;
 	
 	/**
 	 * 初始化方法
 	 * @see Zend_Db_Table_Abstract::init()
 	 * @author gaoqing
 	 * 2015-08-28
 	 */
 	public function init(){
 		parent::init();
 		$this->initView();
 		
 		$this->disease = new App_Model_Disease();
 		$this->ask = new App_Model_Ask();
 		$this->department = new App_Model_Department();
 		$this->htmlFilter = new Zend_Filter_HtmlEntities();
 		$this->intFilter = new Zend_Filter_Int();
 	}
 	
 	/**
 	 * 疾病详情
 	 * @author gaoqing
 	 * 2015年8月31日
 	 * @param void 空
 	 * @return void 空
 	 */
 	public function detaildiseaseAction(){
 		
 		/*
 		 * 1、得到并处理前台传递过来的参数（疾病id diseaseID）
 		 * 2、根据疾病id diseaseID ,得到疾病的基本信息（9939_dzjb: title, thumb, description）diseaseBasicInfoArr
 		 * 3、根据疾病id diseaseID ,得到疾病相关的症状信息 （9939_dzjb: title, content_id）symptomArr
 		 * 4、根据疾病id diseaseID ,得到疾病相关的药品信息（9939_yaopin: ypId, ypName, ypPic, ypUrl）drugArr
 		 * 5、根据疾病的名称，查询相关的问答信息（）askAndAnswerArr
 		 */
 		
 		//1、得到并处理前台传递过来的参数（疾病id diseaseID）
 		$request = $this->getRequest();
 		$initDiseaseID = $request->getParam("diseaseID", 0);
 		$diseaseID = $this->intFilter->filter($initDiseaseID);
 		
 		//注：如果传递过来的是科室下的 疾病名称，需要通过疾病名称，查询到其相应的 疾病id
 		$classid = $request->getParam("classid", 0);
 		if (!empty($classid)) {
 			//通过 科室疾病 的 id, 查询科室疾病的名称
 			$diseaseNameParam = $this->department->getClassNameByClassid($classid);
 			$diseaseID = $this->disease->getDiseaseIDByName($diseaseNameParam);
 		}
 		
 		//2、根据疾病id diseaseID ,得到疾病的基本信息（9939_dzjb: title, thumb, description）diseaseBasicInfoArr
 		$diseaseBasicInfoArr = $this->disease->getDiseaseBasicInfoArr($diseaseID);
 		
 		//3、根据疾病id diseaseID ,得到疾病相关的症状信息 （9939_dzjb: title, content_id）symptomArr
 		$symptomArr = $this->disease->getSymptomArr($diseaseID);
 		
 		//4、根据疾病id diseaseID ,得到疾病相关的药品信息（9939_yaopin: ypId, ypName, ypPic, ypUrl）drugArr
 		$drugArr = $this->disease->getDrugArr($diseaseID);
 		
 		//5、根据疾病的名称，查询相关的问答信息（）askAndAnswerArr
 		$diseaseName = empty($diseaseBasicInfoArr) ? "" : $diseaseBasicInfoArr['title'];
 		
 		//得到当前疾病名称所对应的所有问答数
 		$askCount = $this->ask->getAskCountByTittle($diseaseName);
 		
 		$this->view->assign("diseaseBasicInfoArr", $diseaseBasicInfoArr);
 		$this->view->assign("symptomArr", $symptomArr);
 		$this->view->assign("drugArr", $drugArr);
 		$this->view->assign("askCount", $askCount);
 		$this->view->assign("diseaseID", $diseaseID);
 		
 		$md5URL = md5($_SERVER['REQUEST_URI']);
 		echo $this->view->render("askdoctor/detailDisease.tpl", $md5URL);
 	}
	/**
	 * 疾病详情的分页方法
	 * @author gaoqing
	 * 2015年9月9日
	 * @param void 空
	 * @return void 空
	 */
	 public function detaildiseasepageAction() {
	 	
	 	// /search/detailDisease/diseaseID/139112/currentPage/2
	 	
 		$request = $this->getRequest();
 		
 		$initDiseaseID = $request->getParam("diseaseID", 0);
 		$initDiseaseName = $request->getParam("diseaseName", "");
 		$initCurrentPage = $request->getParam("currentPage", 1);
 		
 		$diseaseID = $this->intFilter->filter($initDiseaseID);
 		$currentPage = $this->intFilter->filter($initCurrentPage);
 		$diseaseName = $this->htmlFilter->filter($initDiseaseName);
	 
		//得到当前疾病名称所对应的所有问答数
 		$askCount = $this->ask->getAskCountByTittle($diseaseName);
 		
 		//分页相关的参数组装
 		$pageSize = 7;
 		$start = ($currentPage - 1) * $pageSize;
 		$pageNum = ceil($askCount / $pageSize);
 		
 		//得到分页的问答信息集
 		$askAndAnswerArr = $this->ask->getAskAndAnswers($diseaseName, $start, $pageSize);
 		
 		//得到分页 HTML
 		$pageBaseURL = "/search/detaildiseasepage/diseaseID/". $diseaseID . "/diseaseName/". urlencode($diseaseName) ."/currentPage/";
 		$pageHTML = $this->getCommonAjaxPageHTML("fatherHTMLID", $pageBaseURL, $currentPage, $pageNum);
 		
 		$this->view->assign("askAndAnswerArr", $askAndAnswerArr);
 		$this->view->assign("pageHTML", $pageHTML);
 		
 		$md5URL = md5($_SERVER['REQUEST_URI']);
 		echo $this->view->render("askdoctor/detailDiseasePage.tpl", $md5URL);
	}

 	
 	/**
 	 * 搜索疾病 部分的入口方法 
 	 * @author gaoqing
 	 * 2015年8月28日
 	 * @param void 空
 	 * @return void 空
 	 */
 	public function indexAction() {
 		//得到 request 对象
 		$request = $this->getRequest();
 		
 		//得到搜索的关键词
 		$searchWords = $request->getParam("searchWords", "");
 		$initCurrentPage = $request->getParam("currentPage", 1);
 		
 		if (!empty($searchWords)) {
 			
	 		//过滤参数
	 		$searchWords = $this->htmlFilter->filter($searchWords);
	 		$intCurrentPage = $this->intFilter->filter($initCurrentPage);
	 		
	 		//得到当前 关键词 下的所有疾病数
	 		$diseaseCount = $this->disease->getDiseaseCountByKeywords($searchWords);
	 		
	 		//分页相关的参数组装
	 		$currentPage = empty($intCurrentPage) ? 1 : $intCurrentPage;
	 		$pageSize = 3;
	 		$start = ($currentPage - 1) * $pageSize;
	 		$pageNum = ceil($diseaseCount / $pageSize);
	 		
	 		//根据相应的 关键词 查询对应的疾病信息
	 		$diseaseArr = $this->disease->getDiseasesByKeywords($searchWords, $start, $pageSize);
	 		
	 		//分页的通用路径
	 		$pageBaseURL = '/search/' . urlencode($searchWords) . '/';
	 		//分页的 HTML
	 		$pageHTML = $this->getPageHTML($pageBaseURL, $currentPage, $pageNum);
	 		
	 		//传递参数到模板中
	 		$this->view->assign("searchWords", $searchWords);
	 		$this->view->assign("diseaseCount", $diseaseCount);
	 		$this->view->assign("diseaseArr", $diseaseArr);
	 		$this->view->assign("diseaseArrSize", count($diseaseArr) - 1);
	 		$this->view->assign("pageHTML", $pageHTML);
 		}
 		
 		$md5URL = md5($_SERVER['REQUEST_URI']);
 		echo $this->view->render('askdoctor/search.tpl', $md5URL);
 	}
 	
 	/**
 	 * 得到 ajax 分页的 HTML 字符串
 	 * @author gaoqing
 	 * 2015年9月06日
 	 * @param string $pageBaseURL 分页的基路径
 	 * @param int $currentPage 当前页
 	 * @param int $pageNum 总的记录数
 	 * @return string 疾病分页的 HTML 字符串
 	 */
 	private function getCommonAjaxPageHTML($fatherHTMLID, $pageBaseURL, $currentPage, $pageNum) {
 	
 		//上一页
 		$preCurrentPage = $currentPage == 1 ? 1 : ($currentPage - 1);
 		$prePage = '<a href="javascript:" id = "prePage"  >上一页</a>';
 	
 		//下一页
 		$nextCurrentPage = $currentPage == $pageNum ? $pageNum :  ($currentPage + 1);
 		$nextPage = '<a href="javascript:" id = "nextPage"  >下一页</a>';
 	
 		if ($pageNum == 0) {
 			$currentPage = 0;
 		}
 		$pageHTML =
 		$prePage .
 		'<span>' . $currentPage . '/' . $pageNum . '</span>'.
 		$nextPage;
 			
 		if ($pageNum != 0) {
 			//添加 ajax js 部分
 			$pageHTML .= '<script type="text/javascript" > ';
 	
 			if ($currentPage != 1) {
 				$pageHTML .= ' $("#prePage").click(function(){    $.ajax({url: "'. $pageBaseURL .  $preCurrentPage .'", cache: false, success: function(html){$("#'. $fatherHTMLID .'").html(html);}  });    });  ' ;
 			}
 			if ($currentPage != $pageNum){
 				$pageHTML .= ' $("#nextPage").click(function(){    $.ajax({url: "'. $pageBaseURL . $nextCurrentPage .'", cache: false, success: function(html){$("#'. $fatherHTMLID .'").html(html);}  });    });  ' ;
 			}
 			$pageHTML .= ' </script>';
 		}
 		return $pageHTML;
 	} 	
 	
 	/**
	 * 得到分页的 HTML 字符串
	 * @author gaoqing
	 * 2015年9月06日
	 * @param string $pageBaseURL 分页的基路径
	 * @param int $currentPage 当前页
	 * @param int $pageNum 总的记录数
	 * @return string 疾病分页的 HTML 字符串
	 */
	private function getPageHTML($pageBaseURL, $currentPage, $pageNum) {
	
		//上一页
		$preCurrentPage = $currentPage == 1 ? 1 : ($currentPage - 1);
		$prePageURL = $pageBaseURL . $preCurrentPage;
		if ($currentPage == 1) {
			$prePageURL = "javascript:";
		}
		$prePage = '<a href="'. $prePageURL .'">上一页</a>';
	
		//下一页
		$nextCurrentPage = $currentPage == $pageNum ? $pageNum :  ($currentPage + 1);
		$nextPageURL = $pageBaseURL . $nextCurrentPage;
		if ($currentPage == $pageNum) {
			$nextPageURL = "javascript:";
		}
		$nextPage = '<a href="'. $nextPageURL .'">下一页</a>';
	
		if ($pageNum == 0) {
			$currentPage = 0;
		}
		$pageHTML =
		$prePage .
		'<span>' . $currentPage . '/' . $pageNum . '</span>'.
		$nextPage;
	
		return $pageHTML;
	}	

 	
 	
 	
 	
 	
 }


?>