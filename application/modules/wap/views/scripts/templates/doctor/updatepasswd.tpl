<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>修改密码_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="description" content="页面描述" />
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
	<a href="javascript:">修改密码</a>
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

<form action="/doctor/updatepasswd" method="post" class="frdata quaf coden">
	<input type = "hidden" name = "userid" value = "<{$userid}>" />
    <p><input type="password" placeholder="请输入旧密码" autofocus id = "oldpasswd" name = "oldpasswd" /></p>
    <p><input type="password" placeholder="请输入新密码" id = "newpasswd" name = "newpasswd" /></p>
    <p><input type="password" placeholder="请输入确认密码" id = "renewpasswd" /></p>
    <p>密码由6-16位字母、数字及下划线组成</p>
    <input type="submit" value="确认修改" id = "submit" />
    <div id = "showInfo" style="display: none;color: rgb(255, 0, 0); height: 20px; width: 200px; margin: 0px auto; font-size: 18px;" ></div>
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
		hiddenErrorBlock($("#oldpasswd"));
		hiddenErrorBlock($("#newpasswd"));
		hiddenErrorBlock($("#renewpasswd"));
		
		$("#submit").on('click', function(){
			
			//显示信息的对象
			var showInfo = $("#showInfo");
			
			//判断两次输入的密码，是否一致
			var newpasswd = $("#newpasswd").val();
			var oldpasswd = $("#oldpasswd").val();
			var renewpasswd = $("#renewpasswd").val();
			if(newpasswd.length == 0 || oldpasswd.length == 0){
				
				$("#showInfo").show();
				showInfo.text("密码不能为空！");
				return false;
			}else if(newpasswd != renewpasswd){
				
				$("#showInfo").show();
				showInfo.text("两次输入的密码不一致！");
				return false;
			}
			return true;	
		});
	});
	</script>
	
</body>
</html>
