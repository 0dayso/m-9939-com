<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>科室列表</title>

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
		<a href="javascript:" title = "科室列表">科室列表</a>
		<a href="javascript:"></a>
	</header>
	<!--ends-->

	<div class="blahe"></div>

	<nav>
		<a href="http://m.9939.com/" title = "首页">首页</a>>
		<a href="http://m.9939.com/askdoctor/" title = "问医">问医</a>>
		<a href="http://m.9939.com/department/more/" title = "疾病科室">疾病科室</a>>
		<a href="javascript:" title = "更多科室">更多科室</a>
	</nav>

	<article class="searc">
		<input type="search" placeholder="请描述疾病或症状..."><a href="">搜索</a><a
			href="/ask/goAskDoctor">提问</a>
	</article>

	<article class="know adv">
		<{include file="ads/ads_moreDepartment_01.html"}>
	</article>
	
	<div class="thre"></div>

	<section class="doct">
		<ul class="sympt">
		
			<{if count($allDepartmentArr) != 0 }>
				<{foreach $allDepartmentArr as $key => $allDepartment}>
					<li><a class="cont"><{$allDepartment.father.name}></a>
					<dl>
							<{foreach $allDepartment.child as $childKey => $child}>
								<dd>
									<a href="/department/index/level/two/department/<{$child.name}>" title = "<{$child.name}>" ><{$child.name}></a>
								</dd>
							<{/foreach}>
						</dl>
					</li>
				<{/foreach}>
			<{/if}>
		</ul>
	</section>

	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
</body>
</html>
