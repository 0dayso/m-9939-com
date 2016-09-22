<!doctype html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>日志列表</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="description" content="页面描述" />
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
	<h2 class="main-hd-bt">日志列表</h2>
	
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

<article class="doctor">
	<div>
		<img src="<{$doctorBasicInfo.pic}>" alt="<{$doctorBasicInfo.nickname}>" title="<{$doctorBasicInfo.nickname}>">
	</div>
    <div>
	    <p>
		    <span><{$doctorBasicInfo.nickname}></span>
		    <{$doctorBasicInfo.zhicheng}>
		</p>
		<p>
		    <span><{$doctorBasicInfo.doc_hos}></span>
		    <{$doctorBasicInfo.doc_keshi}>
	    </p>
	    <p>
		    <span>
		    	<img src="/images/sta_01.png">
		    </span>
		    <span>
		    	<img src="/images/sta_01.png">
		    </span>
		    <span>
		    	<img src="/images/sta_01.png">
		    </span>
		    <span>
		    	<img src="/images/sta_02.png">
		    </span>
		    <span>
		    	<img src="/images/sta_02.png">
		    </span>
	    </p>
    </div>
    <div><a href="/ask/doctor/<{$doctorBasicInfo.uid}>">向TA提问</a></div>
</article>
<article class="arnav docna">
	<b><{$doctorBasicInfo.nickname}></b>主治医生的日志（<label><{$doctorBlogCount}></label>）
</article>

<ul class="arclo">
	<{foreach $doctorBlogArr as $key => $doctorBlog }>
		<li>
			<a href="/doctor/blog/detail/<{$doctorid}>/<{$doctorBlog.blogid}>">
				<h3><{$doctorBlog.subject}></h3>
				<p>
					<span>发布于<{$doctorBlog.date}></span>
					<span><{$doctorBlog.time}></span>
					<span>有<{$doctorBlog.viewnum}>人浏览</span>
				</p>
			</a>
		</li>
	<{/foreach}>
</ul>

	<article class="paget">
		<{$pageHTML}>
	</article>

	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->	
	
	<script src="/scripts/sea.js"></script>
	<script type="text/javascript">
		seajs.use("play.js");
	</script>	

</body>
</html>
