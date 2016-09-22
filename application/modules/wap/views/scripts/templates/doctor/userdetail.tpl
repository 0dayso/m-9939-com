<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><{$userDetail.username}>个人资料_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="description" content="页面描述" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta http-equiv="Cache-Control" content="no-cache">
<meta content="telephone=no" name="format-detection">

<link rel="stylesheet" type="text/css" href="/css/body.css">

<!-- easyui 部分 Start -->
<link rel="stylesheet" type="text/css" href="/easyui/themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="/easyui/themes/icon.css"> 
<!-- easyui 部分 End -->

<script src="/scripts/jquery-1.11.2.min.js"></script>
<script src="/scripts/page.js"></script>
<script src="/scripts/gundong.js"></script>

<!-- easyui 部分 Start -->
<script type="text/javascript" src="/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/easyui/locale/easyui-lang-zh_CN.js"></script>
<!-- easyui 部分 End -->

</head>


<body>
<!--header-->
<header>
	<a href="http://m.9939.com/"></a>
	<a href="javascript:">个人资料</a>
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
    	<span><img src="<{$userDetail.pic}>"></span>
    	<span><{$userDetail.username}></span>
    </article>
    
    <ul class="accep">
    	<input type = "hidden" name = "userid" value = "<{$userDetail.uid}>" id = "userid" />
    	<li><span>手机号：</span><input style="width: 40%;" type="text" placeholder="手机号码"  value = "<{$userDetail.telephone}>" name = "telephone" id = "telephone" ><a href = "javascript:checknum();" class="level" style = "float:right; font-size:0.8em;  background:#31c19f; border-radius:4px; color:#fff; padding:6px 4px; margin-top:-2px;" id = "getCheckNum" >获取验证码</a>
    		<!--<input type = "button" value = "获取验证码" id = "getCheckNum" />-->
    	</li>
        <li><span>验证码：</span><input type="text" placeholder="请输入验证码" id = "checknum" /></li>
        <li><span>昵&nbsp;&nbsp;&nbsp;称：</span><input type="text" placeholder="<{$userDetail.nickname}>" value = "<{$userDetail.nickname}>" id = "nickname" name = "nickname"></li>
        <li>
        	<span>性&nbsp;&nbsp;&nbsp;别：</span>
        	<span><input type="radio"  <{if $userDetail.gender == 1 }> checked<{/if}> name = "gender" value = "1"  >男</span>
        	<span><input type="radio"  <{if $userDetail.gender == 2 }> checked<{/if}> name = "gender" value = "2"  >女</span>
        </li>
        <li><span>身&nbsp;&nbsp;&nbsp;高：</span><input type="text" placeholder="<{$userDetail.hight}>" value = "<{$userDetail.hight}>" name = "hight" id = "height" >(单位/cm)</li>
        <li><span>体&nbsp;&nbsp;&nbsp;重：</span><input type="text" style="width: 25%;" placeholder="<{$userDetail.weight}>" value = "<{$userDetail.weight}>" name = "weight" id = "weight" >(单位/kg)</li>
        <li><span>出生日期：</span><input type="text" placeholder="<{$userDetail.birthday}>" value = "<{$userDetail.birthday}>" name = "birthday" id = "birthday" class="easyui-datebox"  /></li>
        <li>
        	<span>血型：</span>
        	<span><input type="radio"  <{if $userDetail.blood == 1 }> checked<{/if}>  name = "blood" value = "1"  >A</span>
        	<span><input type="radio"  <{if $userDetail.blood == 2 }> checked<{/if}>  name = "blood" value = "2" >B</span>
        	<span><input type="radio"  <{if $userDetail.blood == 3 }> checked<{/if}>  name = "blood" value = "3" >O</span>
        	<span><input type="radio"  <{if $userDetail.blood == 4 }> checked<{/if}>  name = "blood" value = "4" >AB</span>
        	<span><input type="radio"  <{if $userDetail.blood == 0 }> checked<{/if}>  name = "blood" value = "0" >未知</span>
        </li>
        <li>
        	<span>婚姻状况：</span>
        	<span><input type="radio"  <{if $userDetail.marriage == 2 }> checked<{/if}>  name = "marriage"  value = "2" >已婚</span>
        	<span><input type="radio"  <{if $userDetail.marriage == 1 }> checked<{/if}> name = "marriage"  value = "1">未婚</span>
        </li>
    </ul>
</section>
<div id = "showInfo" style="<{if isset($error) && !empty($error)}>display: block;<{else}>display: none;<{/if}>color: rgb(255, 0, 0); height: 15px; width: 150px; margin: 10px auto 0px; font-size: 18px;" >
	<{if isset($error) && !empty($error)}>
	<{$error}>
	<{/if}>
</div>
<article class="finmo shmor logout"><a href="javascript:submit();" id = "submit" >保存</a></article>

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
		hiddenErrorBlock($("#telephone"));
		hiddenErrorBlock($("#checknum"));
		hiddenErrorBlock($("#nickname"));
		hiddenErrorBlock($("#height"));
		hiddenErrorBlock($("#weight"));
		
	});
	
	$('#birthday').datebox({    
		onSelect: function(date){
			$('#birthday').val(date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate());
		}
	});
	
	function checknum(){
		$.ajax({
	    	type: "POST",
	    	url:  "/doctor/send",
	    	data: "dst=" + $("#telephone").val(),
	    	dataType:'json',
	    	success: function(msg){
	    		if(msg != null && msg.checknum != "0"){
	    			
	    			//验证码发送成功时，进行值得设置
	    			if(msg.result.flag == 1){
			    		window.localStorage.removeItem("checknum");
			    		window.localStorage.removeItem("time");
			    		window.localStorage.setItem("checknum", msg.checknum);
			    		window.localStorage.setItem("time", msg.time);
	    			}
	    		}
	    	}
	    });
	}
	
	function submit(){
		var telephone = $("#telephone").val();
		var nickname = $("#nickname").val();
		var height = $("#height").val();
		var weight = $("#weight").val();
		var checknum = $("#checknum").val();
		
		var showInfo = $("#showInfo");
		
		//手机号验证：
		var telephoneReg = new RegExp("^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$");
		if(telephone.length != 0 && !telephoneReg.test(telephone)){
			$("#showInfo").show();
			showInfo.text("手机号不正确！");
			return ;
		}
		
		//判断验证码是否正确
		if(checknum.length == 0){
			$("#showInfo").show();
			showInfo.text("请进行手机验证！");
			return ;
		}else{
			//判断时间是否过时
			var currentTimeFull = Date.parse(new Date());
			var currentTime = parseInt(currentTimeFull) / 1000;
			var checknumTime = window.localStorage.getItem("time");
			
			if(currentTime - checknumTime > 60){
				$("#showInfo").show();
				showInfo.text("验证码超时！");
				return ;
			}else{
				
				//判断验证码是否正确
				if(checknum != window.localStorage.getItem("checknum")){
					$("#showInfo").show();
					showInfo.text("验证码不正确！");
					return ;
				}
			}
		} 
		
		//验证昵称
		if(nickname.length == 0){
			$("#showInfo").show();
			showInfo.text("昵称不能为空！");
			return ;
		}
		
		 //验证身高
		var heightReg = new RegExp("^[1-2][0-9]*$");
		if(!heightReg.test(height)){
			$("#showInfo").show();
			showInfo.text("身高是数字！");
			return ;
		}
		
		//验证体重
		var weightReg = new RegExp("^[1-7][0-9]*(\.)?[0-9]*$");
		if(!weightReg.test(weight)){
			$("#showInfo").show();
			showInfo.text("体重是数字！");
			return ;
		} 
		
		//执行 ajax 请求
		$.ajax({
			   type: "POST",
			   url: "/doctor/updateuserdetail",
			   data: {
				   'userid': $("#userid").val(),
				   'telephone': $("#telephone").val(),
				   'nickname': $("#nickname").val(),
				   'gender': $("input[name=gender]:checked").val(),
				   'hight': $("#height").val(),
				   'weight': $("#weight").val(),
				   'birthday': $("#birthday").datebox('getValue'),
				   'blood': $("input[name=blood]:checked").val(),
				   'marriage': $("input[name=marriage]:checked").val()
			   },
			    success: function(){
		    		window.history.go(-1);
			  }  
			});
	}
	</script>

</body>
</html>
