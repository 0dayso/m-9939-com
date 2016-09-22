<!doctype html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>提问成功提示</title>

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


<body style="background: #f2f2f2;">
	<!--header-->
	<header>
		<a href="http://m.9939.com/"></a>
		<a href="javascript:" title = "提问成功提示" >提问成功提示</a>
		<a href="" class="circ" id = "usercenterID"></a>
	</header>
	<!--ends-->
	<div class="blahe"></div>

	<article class="submi">
		<p>
			<span><img src="/images/rig.png"></span><span>提交成功！</span>
		</p>
		<p>
			用户名：<span><{$username}></span>密码：<span><{$password}></span>
			<input type = "hidden" name = "hiddenUser" value = "<{$userid}>" id = "hiddenUserID"/>
		</p>
		<p>
			为方便下次查看医生回答，<span>请修改↓</span>
		</p>
	</article>

	<form action="/ask/updateuser" method="post" class="frdata quaf"> 
		<p>
			<input type="text" placeholder="请输入用户名" name = "username" id = "username" value = "<{if isset($upUsername) && !empty($upUsername)}><{$upUsername}><{/if}>" autofocus />
			<input type = "hidden" name = "userid" value = "<{$userid}>" id = "userid"/>
			<input type = "hidden" name = "beforePassword" value = "<{$password}>"/>
		</p>
		<p>
			<input type="password" placeholder="请输入密码" name = "password" id = "password" value = "<{if isset($upPassword) && !empty($upPassword)}><{$upPassword}><{/if}>"  />
		</p>
		<p>
			<input type="password" placeholder="请确认密码" name = "repassword" id = "repassword"  />
		</p>
		<input type="submit" value="确  认" id = "submit" >
	</form>
	
	<div id = "showInfo" style="<{if isset($errorInfo) && !empty($errorInfo)}>display: block;<{else}>display: none;<{/if}>color: rgb(255, 0, 0); height: 15px; width: 200px; margin: 0px auto 20px; font-size: 18px;" >
		<{if isset($errorInfo) && !empty($errorInfo)}>
			<{$errorInfo}>
		<{/if}>
	</div>

	<!-- 底部 部分 Start -->
	<{include file="footer/ask_doctor_footer.html"}>
	<!-- 底部 部分 End -->
	
	    <iframe id="child" src="" style = "display: none;"></iframe>
	    <input type = "hidden" value = "<{if isset($errorInfo) && !empty($errorInfo)}>01<{else}>00<{/if}>" id = "usernameExist" />
	    
	    <script>
	    $(document).ready(function(e) {
	    	window.localStorage.removeItem("userid");
	        window.localStorage.setItem("userid", $("#hiddenUserID").val());
	    
	    	$("#child").attr("src", "http://m.9939.com/iframe.php?userid=" + $("#hiddenUserID").val() + "&id=" + Math.random());
	    	
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
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->
	
	<script src="/scripts/sea.js"></script>
	<script type="text/javascript">
		seajs.use("updateUserInfo.js");	
	</script>

</body>
</html>
