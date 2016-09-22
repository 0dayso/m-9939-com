<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>用户提问页面_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="keywords" content="久久问医,用户提问页面" />
<meta name="description" content="久久问医为您提供的用户提问页面" />
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
	<h2 class="main-hd-bt">我要提问</h2>
	
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
<div style = "width: 100%; height: 20px;"></div>
<form action="" method="post" class="frdata" id = "askDoctorForm">

		<input type="text" name = "title" id = "title" placeholder="请简述您的问题作为标题（限5字以上）" class="txt">
		<textarea name = "content" id = "content" placeholder="请详细描述您的病情、发病时间和治疗情况（限20个字以上）"></textarea>
		<input type="text" name = "help" id = "help" placeholder="想得到怎样的帮助?（限5字以上）" class="txt">
		<div style = "height: 15px;"></div>
		<p class="sex">
			<label>性&nbsp;&nbsp;&nbsp;&nbsp;别</label><span><input
				type="radio"  checked value="1" name = "sex">男<input
				type="radio"  value="2" name = "sex" >女</span>
		</p>
		<p>
			<label>年&nbsp;&nbsp;&nbsp;&nbsp;龄</label><input
				type="text" placeholder="如：28岁" name = "age" id = "age">
		</p>
<!-- 		<p>
			<label>选择科室</label><input type="text" placeholder="男科" name = "department" id = "department">
		</p>
		<p>
			<label>手&nbsp;&nbsp;机&nbsp;号</label><input type="text"
				placeholder="填写后以上回复及时短信通知您" name = "phone" id = "phone">
		</p> -->
		<div>
			<label>验&nbsp;&nbsp;证&nbsp;码</label><input type="text" placeholder="" name = "checknum" id = "checknum" >
			<div style = "margin: 4px 5px; width: 93px; height: 37px;">
				<img src="/php/generate_check_num.php" id = "checkCode"  />
				<input type = "hidden" name = "initCheckNum" id = "initCheckNum" value = "" />
			</div>
		</div>
		
		<div id = "showInfo" style = "display: none; width: 200px; height: 20px; color: red; margin: 2px auto 0px; font-size: 18px; "></div>
        
		<input type="submit" value="提交问题" name = "submit" id = "submit">
		
	</form>
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->

</body>
	<script src="/scripts/sea.js"></script>
	<script type="text/javascript">
		seajs.use("play.js");
		seajs.use("singleAskPage.js");	
	</script>
</html>
