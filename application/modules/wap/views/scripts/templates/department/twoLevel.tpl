<!doctype html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title><{$departmentName}></title>

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
<script src="/scripts/page.js"></script>

</head>


<body>
	<!--header-->
	<header>
		<a href="http://m.9939.com/"></a>
		<a href="javascript:"  title = "<{$departmentName}>"><{$departmentName}></a>
		<a href="javascript:"></a>
	</header>
	<!--ends-->
	<div class="blahe"></div>

	<nav>
		<a href="http://m.9939.com/" title = "首页">首页</a>>
		<a href="http://m.9939.com/askdoctor/" title = "问医">问医</a>>
		<a href="http://m.9939.com/department/more/" title = "疾病科室">疾病科室</a>>
		<a href="javascript:" title = "<{$departmentName}>"><{$departmentName}></a>
	</nav>
	<article class="searc">
		<input type="search" id = "searchWords" placeholder="请描述疾病或症状..."><a href="" id = "searchBtn">搜索</a>
		<a href="/ask/goAskDoctor">提问</a>
	</article>
	
	<article>
		<{include file="ads/ads_twoLevel_01.html"}>
	</article>
	
	<div class="thre"></div>

	<section class="doct">
		<ul class="sympt uniqu">
			<li><a class="cont"><{$departmentName}></a>
				<dl>
						<{if count($childArr) != 0 }>
							<{foreach $childArr as $key => $child }>
								<dd>
									<a href="/search/detailDisease/classid/<{$child.id}>/diseaseName/<{$child.name}>"><{$child.name}></a>
								</dd>
							<{/foreach }>					
						<{/if}>
				</dl>
			</li>
		</ul>
	</section>

	<article class="arnav">
		为您找到<span><{$departmentName}></span>相关问题<{$askCount}>个
	</article>
	<ul class="lopre">
		
		<{foreach from = $askAndAnswerArr item = askAndAnswer key = key}>
			<li>
				<h3>
					<{$askAndAnswer.ask.title}>
				</h3>
				<div class="care">
					<p><{$askAndAnswer.answer.content}>&nbsp;&nbsp;&nbsp;&nbsp;<a href = "/ask/askdetail/askid/<{$askAndAnswer.ask.id}>" ><span style="color:#00B489;" > 查看详情 </span></a></p>
					<div class="agree">
						<span class="sp_02"><{$askAndAnswer.doctor.doc_keshi}></span>|
						<span class="sp_03"><{$askAndAnswer.doctor.nickname}></span>
						<span class="sp_01"><{$askAndAnswer.answer.praise}></span>|
						<span class="sp_04"><{$askAndAnswer.ask.answernum}>个回答</span>
					</div>
				 </div>
			 </li>
		<{/foreach}>		
	</ul>
	<article class="paget">
		<{$pageHTML}>
	</article>

	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	<script>
		$(document).ready(function(){
			//设置 搜索 部分的 a 的 href 值
			$("#searchBtn").on('click', function(){
				searchWords = $("#searchWords").val();
				
				$(this).attr("href", "/search/index/searchWords/" + searchWords);
			});
		});
	</script>
	
</body>
</html>
