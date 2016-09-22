<!DOCTYPE html>
<html>
<!-- head -->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>问题详情</title>
	<meta name="description" content="页面描述" />
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="black" name="apple-mobile-web-app-status-bar-style">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta content="telephone=no" name="format-detection">
	<link rel="stylesheet" type="text/css" href="/css/common.css">
	<link rel="stylesheet" type="text/css" href="/css/index.css">
</head>
<!-- head -->
<body>
<div class="main">
	<!-- header stars -->
	<header class="main-hd personal-hd">
		<h2 class="main-hd-bt">回复详情</h2>
		<a href="/" class="return-index">首页</a>
	</header>
	<!-- header ends -->
	<!-- 主内容 stars -->
	<section class="main-bd">
		<!-- reply-xq start -->
		<div class="reply-xq">
			<h3 class="reply-bt">
				<{$result.title}>
			</h3>
			<div class="re-question pdlf25">
				<p class="p-info">
					<span class="s-time">提问于：<{$result.ctime}></span>
					<{if $result.sexnn eq '1'}>男<{else if $result.sexnn eq '2'}>女<{/if}>  <{if $result.age gt '0'}><{$result.age}>岁<{/if}>
				</p>
				<p class="p-ques">
					<{$result.content}>
				</p>
			</div>
			<h3 class="reply-bt reply-btbg mt24">
				我要回答
			</h3>
			<div class="w-huida pdtp25">
				<form action="">
					<div class="wytw-quses">			
						<textarea class="wytw-quse2"
							placeholder="在此输入回答内容"></textarea>
						<div class="wrply-btns">
							<input type="submit" class="wrply-input wrpl-ti" value="提交">
						    <a href="#" class="wrply-input wrpl-backs">取消</a>
						</div>
					</div>
				</form>
			</div>				
		</div>
		<!-- reply-xq end -->
	</section>
	<!-- 主内容 ends -->
	<!-- footer stars -->
	   <{include file="footer/footer.html"}>
	<!-- footer ends -->
</div>
</body>
<script type="text/javascript" src="/scripts/sea.js"></script>
<script type="text/javascript">
    seajs.use("play.js")
</script>
</html>