<!doctype html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>我的提问_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="description" content="页面描述" />
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta http-equiv="Cache-Control" content="no-cache">
<meta content="telephone=no" name="format-detection">

<link rel="stylesheet" type="text/css" href="/css/body.css">

<script src="/scripts/jquery-1.11.2.min.js"></script>
<script src="/scripts/gundong.js"></script>
<script src="/scripts/page.js"></script>

</head>


<body>
	<!--header-->
	<header class="myque">
		<a href="http://m.9939.com"></a>
		<a href="javascript:" title = "我的提问" >我的提问</a>
		<a href="" class="circ" id = "usercenterID"></a>
	</header>
	<script>
			$(document).ready(function(){
				/*
				 * 1、从本地缓存中，得到 userid
				 * 	1.1、如果存在 userid，则表明当前用户登录过，直接跳转到用户中心界面
				 * 	1.2、如果不存在 userid，则直接跳转到用户登录界面
				 */
				 
				 var url = "http://wapask.9939.com/login";
				 
				 var userid = window.localStorage.getItem('userid');
				 if(userid != null && userid != ''){
				 	url = "http://wapask.9939.com/doctor/usercenter?userid=" + userid;
				 }
				$("#usercenterID").attr('href', url);
			});
		</script>
	<!--ends-->
	<div class="blahe"></div>

	<ul class="reply">
		<{if count($userAskArr) != 0 }>
			<{foreach $userAskArr as $userAskKey => $userAsk}>
				<li>
					<a href="/user/asks/<{$userAsk.id}>/<{$userid}>">
						<h2><{$userAsk.title}></h2>
						<p>
							<span><{if $userAsk.answernum == 0 }>暂无回复<{/if}><{if $userAsk.answernum != 0 }><{$userAsk.answernum}> 个回复<{/if}></span>
							<span><{$userAsk.status}></span>
							<span><{$userAsk.ctime}></span>
						</p>
					</a>
				</li>
			<{/foreach}>
			
			<{else}>
				<li>暂无提问！</li>
		<{/if}>
		
	</ul>

	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->

</body>
</html>
