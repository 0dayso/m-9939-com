<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><{$user.username}>的个人页面_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="keywords" content="久久问医,<{$user.username}>的个人页面" />
<meta name="description" content="久久问医<{$user.username}>的空间、个人信息页面." />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta http-equiv="Cache-Control" content="no-cache">
<meta content="telephone=no" name="format-detection">

<link rel="stylesheet" type="text/css" href="/css/body.css">

<script src="/scripts/jquery-1.11.2.min.js"></script>
<script src="/scripts/page.js"></script>
<script src="/scripts/gundong.js"></script>

</head>


<body>
<!--header-->
<header>
	<a href="http://m.9939.com/"></a>
	<a href="javascript:">个人中心</a>
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
<section class="persc">
    <article class="detai">
    	<span><img src="<{$user.pic}>"></span>
    	<span><{$user.username}></span>
    </article>
    <ul class="spest">
    	<li><a href="javascript:"><span><img src="/images/per_01.png"></span><span>会员等级</span><span class="level"><{$user.groupname}></span></a></li>
    	<li><a href="http://wapask.9939.com/doctor/userdetail?userid=<{$user.uid}>"><span><img src="/images/per_02.png"></span><span>个人资料</span></a></li>
        <li><a href="http://wapask.9939.com/ask/userasklist?userid=<{$user.uid}>"><span><img src="/images/per_03.png"></span><span>我的提问</span></a></li>
        <li><a href="http://wapask.9939.com/doctor/gousermsg?userid=<{$user.uid}>"><span><img src="/images/per_04.png"></span><span>消息</span></a></li>
        <li><a href="http://wapask.9939.com/doctor/goupdatepd?userid=<{$user.uid}>"><span><img src="/images/per_05.png"></span><span>修改密码</span></a></li>
    </ul>
</section>
<article class="finmo shmor logout"><a href="" id = "logout">退出登录</a></article>
	
	<input type = "hidden" value = "<{$user.uid}>" id = "hidden_userid" />
	<input type = "hidden" value = "<{$login}>" id = "isLogin" />
	<iframe id="child" src="" style = "display: none;"></iframe>
	<iframe id="remove" src="" style = "display: none;"></iframe>

	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->
	
	<script>
		$(document).ready(function(){
		
			//如果是登录成功，则将当前用户的 id 保存到本地缓存中
			var isLogin = $("#isLogin").val();
			if(isLogin == 1){
				window.localStorage.removeItem('userid');
				window.localStorage.setItem('userid', $("#hidden_userid").val());
			}
			
			//添加 m.9939.com 中的本地缓存(userid)
			$("#child").attr("src", "http://m.9939.com/iframe.php?userid=" + $("#hidden_userid").val() + "&id=" + Math.random());
		});
		
		$("#logout").on('click', function(){
			window.localStorage.removeItem('userid');
			
			//删除 m.9939.com 中的本地缓存(userid)
			$("#remove").attr("src", "http://m.9939.com/remove.php?id=" + Math.random());
			
			$(this).attr('href', 'http://wapask.9939.com/login/logout?userid=' + $("#hidden_userid").val());
		});
	</script>

</body>
</html>
