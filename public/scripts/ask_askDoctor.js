
		$(document).ready(function(){
			$("#initCheckNum").val();
			
			//读取验证码的值
			$.getJSON("/php/check_num.json", function(json){
			  	$("#initCheckNum").val(json.check_num);
			});
			
			//验证码刷新功能
			$("#checkCode").on('click', function(){
				$(this).attr('src', "/php/generate_check_num.php?cd=" + Math.random() );
				
				
				//读取验证码的值
				setTimeout(function(){
					$.getJSON("/php/check_num.json?id=" + Math.random(), function(json){
						$("#initCheckNum").val(json.check_num);
					});	
				}, 1000);
			});
			
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
			hiddenErrorBlock($("#title"));
			hiddenErrorBlock($("#content"));
			hiddenErrorBlock($("#checknum"));
			hiddenErrorBlock($("#age"));
			hiddenErrorBlock($("#help"));
			
			/**
			 * 得到汉字的长度
			 */
			function getRealLen( str ) {  
			    return str.replace(/[^\x00-\xff]/g, '__').length; //这个把所有双字节的都给匹配进去了  
			}
			
			$("#submit").on('click', function(){
				
				//标题
				var title = $("#title").val();
				//内容
				var content = $("#content").val();
				//验证码
				var checknum = $("#checknum").val();
				var initChecknum = $("#initCheckNum").val();
				var age = $("#age").val();
				var reg = new RegExp("^[0-9]*$");
				var help = $("#help").val();
				
				//标题验证：
				if(getRealLen(title) < 10){
					
					$("#showInfo").show();
					$("#showInfo").text("标题小于5个字！");
					return false;
				}
				//内容验证：
				if(getRealLen(content) < 40){
					
					$("#showInfo").show();
					$("#showInfo").text("病情描述小于20个字！");
					return false;
				}
				//想要得到的帮助
				if(help.length != 0){
					if(getRealLen(help) < 10){
						$("#showInfo").show();
						$("#showInfo").text("想要得到帮助小于5个字");
						return false;
					}
					if(getRealLen(help) > 60){
						$("#showInfo").show();
						$("#showInfo").text("想要得到帮助大于30个字");
						return false;
					}
				}				
				//年龄验证：
				if(!reg.test(age)){
					
					$("#showInfo").show();
					$("#showInfo").text("年龄必须是数字！");
					return false;
				}else{
					if(age.length == 0){
						
						$("#showInfo").show();
						$("#showInfo").text("年龄不能为空！");
						return false;
					}
					if(parseInt(age) > 150){
						
						$("#showInfo").show();
						$("#showInfo").text("您的年龄有点大哦！");
						return false;
					}
				}
				//验证码验证：
				if(checknum.toLowerCase() != initChecknum.toLowerCase()){
					
					$("#showInfo").show();
					$("#showInfo").text("验证码不正确！");
					return false;
				}
				
				//判断是否重复提交
				var successTime = window.localStorage.getItem("successTime");
				var time = new Date().getTime();
				if(successTime == undefined || successTime == null){
					successTime = time;
				}else{
					successTime = parseInt(successTime);
				}
				if(time - successTime > 0 && time - successTime < 60*1000){
					$("#showInfo").show();
					$("#showInfo").text("不能重复提交！");
					return false;
				}
				
				$("#askDoctorForm").attr('action', 'http://wapask.9939.com/ask/askDoctor?userid='+window.localStorage.getItem('userid'));
				
				//操作成功后，记录当前操作时间，避免重复提交
				var currentTime = new Date().getTime();
				window.localStorage.removeItem("successTime");
				window.localStorage.setItem("successTime", currentTime);
				
				return true;
			});
			
		});