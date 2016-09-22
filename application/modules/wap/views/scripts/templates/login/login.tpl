<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>用户登录页面_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="keywords" content="久久问医,用户登录页面" />
<meta name="description" content="久久问医的用户登录页面" />
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
		<a href="javascript:">登 录</a>
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
	<form action="/login/login" method="post" class="frdata quaf coden dcancel">
		<p>
			<input type="text" placeholder="用户名/邮箱/手机号" id = "username" name = "username" autofocus />
			<input type = "hidden" name = "login" value = "1" />
		</p>
		<p>
			<input type="password" placeholder="密码" id = "password" name = "password" />
		</p>
		<div id = "showInfo" style="<{if isset($error) && !empty($error)}>display: block;<{else}>display: none;<{/if}>color: rgb(255, 0, 0); height: 15px; width: 150px; margin: 0px auto; font-size: 18px;" >
			<{if isset($error) && !empty($error)}>
			<{$error}>
			<{/if}>
		</div>
		<input type="submit" value="登录" id = "submit" />
		
		<!-- 其他操作部分 Start -->
		<!--<p class="cor999">
			<a href="">没有账号？立即注册</a>
			<a href="" class="fr">修改密码</a>
		</p>
		<div class="third-login">
			<p>用第三方登录</p>
		</div>
		<div class="pabetr">
			<a class="" href=""><img src="/images/xqq.gif"></a> 
			<a class="" href=""><img src="/images/xweb.gif"></a>
		</div>-->
		<!-- 其他操作 End -->
		
	</form>

	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->
	
	<script>
	$(document).ready(function(){
		/**
		 * 隐藏错误显示区域
		 * @author gaoqing
		 * 2015-09-10
		 */
		function hiddenErrorBlock(controlObj){
			//当输入框获取焦点时，隐藏 错误显示信息
			$(controlObj).on('focus', function(){
				
				//隐藏错误显示区域
				$("#showInfo").hide();
			});
		}
		//当错误提示信息显示的时候，如果再重新输入信息的话，错误提示要隐藏
		hiddenErrorBlock($("#username"));
		hiddenErrorBlock($("#password"));
		
		$("#submit").on('click', function(){
			
			//显示信息的对象
			var showInfo = $("#showInfo");
			
			//验证用户输入的用户名是否合法
			var username = $("#username").val();
			if(username.length == 0){
				
				$("#showInfo").show();
				showInfo.text("用户名不能为空！");
				return false;
			}
			var password = $("#password").val();
			if(password.length == 0){
				
				$("#showInfo").show();
				showInfo.text("密码不能为空！");
				return false;
			}
			return true;	
		});
	});	
	</script>

</body>
</html>
