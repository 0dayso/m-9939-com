<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>用户注册页面_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="keywords" content="久久问医,用户注册页面" />
<meta name="description" content="久久问医的用户注册页面，提供用户注册信息." />
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
	<a href="javascript:">注 册</a>
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

<form action="/login/register" method="post" class="frdata quaf  dcancel scar">
    <p><label><i>*</i>请输入用户名</label><input type="text" placeholder="(4-16位的字母与数字组合)" id = "username" name = "username" value = "<{$username}>" /></p>
    <p><label><i>*</i>请输入邮箱</label><input type="text" placeholder="请填写您常用的邮箱地址" id = "email" name = "email" value = "<{$email}>" /></p>
    <p><label><i>*</i>个性化昵称</label><input type="text" placeholder="(中英文即可)" id = "nickname" name = "nickname" value = "<{$nickname}>" /></p>
    <p><label><i>*</i>密码</label><input type="password" placeholder="确保密码的准确输入" id = "password" name = "password" value = "<{$password}>"  /></p>
    <p><label><i>*</i>再次确认密码</label><input type="password" placeholder="确保密码的准确输入" id = "repassword"  /></p>
    
   	<div id = "showInfo" style="<{if isset($error) && !empty($error)}>display: block;<{else}>display: none;<{/if}>color: rgb(255, 0, 0); height: 15px; width: 200px; margin: 0px auto; font-size: 18px;" >
		<{if isset($error) && !empty($error)}>
		<{$error}>
		<{/if}>
	</div>
    
    <input type="submit" value="注册" id = "submit" />
      
    <!-- 第三方登录 Start -->
    <!--<div class="third-login"><p>用第三方登录</p></div>
    <div class="pabetr">
	 	 <a class="" href=""><img src="/images/xqq.gif"></a>
		 <a class=""  href=""><img src="/images/xweb.gif"></a>
	</div>-->
    <!-- 第三方登录 End -->
    
</form>
	<input type = "hidden" value = "00" id = "usernameExist" />
	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->
	
	<script src="/scripts/sea.js"></script>
	<script type="text/javascript">
		seajs.use("register.js");	
	</script>
	
</body>
</html>
