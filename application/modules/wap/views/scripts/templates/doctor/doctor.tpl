<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title><{$doctorBasicInfo.truename}>_在线咨询医生_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="keywords" content="<{$doctorBasicInfo.truename}>,<{$doctorBasicInfo.best_dis}>" />
<meta name="description" content="<{$doctorBasicInfo.memo|mb_substr:0:20:'utf-8'}>" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta http-equiv="Cache-Control" content="no-cache">
<meta content="telephone=no" name="format-detection">

<link rel="stylesheet" type="text/css" href="/css/body.css">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/index.css">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/other.css?201608221">

<script src="/scripts/jquery-1.11.2.min.js"></script>
<script src="/scripts/page.js"></script>

</head>


<body>
<article class="main-hd personal-hd">
	 <a href="http://m.9939.com/" class="j_logo"><img src="/images/jjlo.png"></a>
	<h2 class="main-hd-bt">医生详情</h2>
	
	<!-- 右侧快捷按钮 Start -->
	<div class="hd-right">
		<div class="personal">
			<a href="javascript:;" class="personal-btn"><img src="/images/f_sym.png"></a>
		</div>
     <!--ends-->   
	</div>
</article>
<{include file="navigation/fast_navigation_ask.html"}>
<!-- 右侧快捷按钮 End -->	
	
	<div class="blahe" style = "height: 0.12em;" ></div>
	<article class="doctor docbo">
		<div>
			<img src="<{$doctorBasicInfo.pic}>" 
				 alt="<{$doctorBasicInfo.nickname}>" 
				 title = "<{$doctorBasicInfo.nickname}>" 
				 width = 80.4 height = 80.4 />
		</div>
		<div>
			<p>
				<span><{$doctorBasicInfo.truename}></span><{$doctorBasicInfo.zhicheng}>
			</p>
			<p>
				<span><{$doctorBasicInfo.doc_hos}></span><{$doctorBasicInfo.doc_keshi}>
			</p>
			<p>
				<span><img src="/images/sta_01.png"></span><span><img
					src="/images/sta_01.png"></span><span><img
					src="/images/sta_01.png"></span><span><img
					src="/images/sta_02.png"></span><span><img
					src="/images/sta_02.png"></span>
			</p>
		</div>
		<div>
			<a href="/ask/doctor/<{$doctorid}>" title = "向TA提问" >向TA提问</a>
			<input type = "hidden" id = "doctorid" value = "<{$doctorid}>" />
		</div>
	</article>
	<section class="aclo">
		<a href="">
			<h3>积分</h3>
			<p><{$doctorBasicInfo.credit}>分</p>
		</a>
		<a href="/doctor/blog/<{$doctorid}>/1">
			<h3>日志</h3>
			<p><{$doctorLogNum}></p>
		</a>
		<a href="/doctor/friends/<{$doctorid}>">
			<h3>TA的好友</h3>
			<p><{$doctorBasicInfo.friendnum}></p></a>
	</section>
	
	<article class="breif gooda dode bego addcon">
		<h3>擅长</h3>
		<p>
			<a href = "/doctor/goodat/<{$doctorid}>" style = "color: #333;">
				<{$doctorBasicInfo.best_dis}>
			</a>
		</p>
	</article>
	<article class="breif dode bego addcon">
		<h3>简介</h3>
		<p>
			<a href = "/doctor/abstract/<{$doctorid}>" style = "color: #333;">
				<{$doctorBasicInfo.memo}>
			</a>
		</p>
	</article>
	
	<!-- 相关问答信息 Start -->
	<article class="arnav">已回答问题</article>
	<div id = "fatherHTMLID">
	</div>
	<!-- 相关问答信息 End -->
	
	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->	
	
	<script type="text/javascript">
		$(document).ready(function(){
			//异步分页操作
			$.ajax({
				  url: "/doctor/detaildoctorpage/uid/" + $("#doctorid").val() ,
				  cache: false, 
				  success: function(html){
				  		//将得到的信息，添加到 n3Tab33ContentDep 下面
				  		$("#fatherHTMLID").html(html);
				  }
			});
		});
	</script>	
	
	<script src="/scripts/sea.js"></script>
	<script type="text/javascript">
		seajs.use("play.js");
	</script>		
	
</body>
</html>
