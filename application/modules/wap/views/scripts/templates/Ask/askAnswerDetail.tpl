<!doctype html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title><{$askInfo.title}>_<{$askInfo.classname}>_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="keywords" content="<{$askInfo.title}>" />
<meta name="description" content="<{$askInfo.title}> <{$askInfo.content|mb_substr:0:20:'utf-8'}>" />
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta http-equiv="Cache-Control" content="no-cache">
<meta content="telephone=no" name="format-detection">

<link rel="stylesheet" type="text/css" href="/css/body.css">
<link rel="stylesheet" type="text/css" href="/css/1125.css">
<script src="/scripts/jquery-1.11.2.min.js"></script>
<script src="/scripts/gundong.js"></script>
<script src="/scripts/page.js"></script>

</head>


<body>
	<!--header-->
	<header>
		<a href="http://m.9939.com/"></a>
		<a href="javascript:">疾病详情</a>
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

	<nav>
		<a href="http://m.9939.com/" title = "">首页</a>>
		<a href="http://wapask.9939.com" title = "问医">问医</a>>
		<a href="/disease/<{$askInfo.classid}>.html" title = "<{$askInfo.classname}>"><{$askInfo.classname}></a>>
		<a href="javascript:" title = "疾病详情">疾病详情</a>
	</nav>

	<article class="symp">
		<span></span>
		<p><{$askInfo.title}></p>
	</article>
	<article class="sick">
		<h3>
			病情描述：<span>(<{$askInfo.sexnn}><{if $askInfo.age != 0 }>，<{$askInfo.age}>岁<{/if}>)</span>
		</h3>
		<p><{$askInfo.content}></p>
		
		<{if isset($askInfo.help) && !empty($askInfo.help) }>
			<div style = "height: 20px;"></div>
			<div style = "height: 20px; font-size: 20px; color:#999; ">想要得到的帮助：</div><p><{$askInfo.help}></p>
		<{/if}>
		
		<aside><{$askInfo.ctime}></aside>
	</article>

	<!-- 医生的回答部分 Start -->
	<{foreach $askDoctorAnswer as $key => $doctorAnswer }>
		<{if count($doctorAnswer.doctor) != 0  }>
			<article class="doctor docbo docur">
				<div>
					<img src="<{$doctorAnswer.doctor.pic}>" alt="<{$doctorAnswer.doctor.truename}>" title = "<{$doctorAnswer.doctor.truename}>" >
				</div>
				<div>
					<p>
						<span><{$doctorAnswer.doctor.truename}></span><{$doctorAnswer.doctor.zhicheng}>
					</p>
					<p>
						<span><{$doctorAnswer.doctor.doc_hos}></span><{$doctorAnswer.doctor.doc_keshi}>
					</p>
				</div>
				<div>
					<a href="/ask/doctor/<{$doctorAnswer.doctor.uid}>">向TA提问</a>
				</div>
			</article>
		<{/if}>
		<article class="sick disein">
			<p>
				<b>病情分析：</b> <{$doctorAnswer.answer.content}>
			</p>
			
			<{if isset($doctorAnswer.answer.suggest) && !empty($doctorAnswer.answer.suggest) }>
				<div style = "height: 10px;"></div>
				<p> <b>指导意见：</b> <{$doctorAnswer.answer.suggest}></p>
			<{/if}>
			
		</article>
	<{/foreach }>
	<!-- 医生的回答部分 End -->

	<article class="finmo shmor akst">
		<a href="/ask/goAskDoctor">我要提问</a>
	</article>

	<article class="know adv">
		<{include file="ads/ads_askAnswerDetail_01.html"}>
	</article>

	<h3 class="reask">相关问答</h3>
	<ul class="ques">
		<{foreach $relateAskInfoArr as $key => $relateAskInfo  }>
			<li>
				<span><{$relateAskInfo.answernum}>条回复</span>
				<a href="/id/<{$relateAskInfo.id}>-<{$relateAskInfo.classid}>.html" title = "<{$relateAskInfo.title}>"><{$relateAskInfo.shorttitle}></a>
			</li>
		<{/foreach}>
	</ul>

<!-- 	<article class="finmo shmor">
		<a href="">显示更多医生</a>
	</article> -->

	<article class="know adv">
		<{include file="ads/ads_askAnswerDetail_02.html"}>
	</article>

	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	<!-- 百度弹出广告 Start -->
	<{include file="ads/ads_askAnswerDetail_js.html"}>
	<!-- 百度弹出广告 End -->	
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->
	
</body>
</html>
