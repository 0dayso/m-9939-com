// JavaScript Document
$(function(){
	/*左上角弹出层*/
	var bool=true;
	$('.lin_02').click(function(){
		
		if(bool){
			$('.personal').show();	
			bool=false;
		}
		else{
			$('.personal').hide();	
			bool=true;		
		}
	});
	$('.f_nam').click(function(){
		$('.personal').hide();	
		bool=true;			
	});	
})
document.writeln('<div class="personal">');
document.writeln('<div class="f_nav">');
document.writeln('<div class="f_nam"><b>快速导航</b><a>X</a></div>');
document.writeln('<div class="cont"><b>资讯</b></div>');
document.writeln('<div class="c_col c_tot">');
document.writeln('<a href="/news/">新闻</a>');
document.writeln('<a href="/man/">男性</a>');
document.writeln('<a href="/lady/">女性</a>');
document.writeln('<a href="/oldman/">老人</a>');
document.writeln('<a href="/baby/">母婴</a>');
document.writeln('<a href="/food/">饮食</a>');
document.writeln('<a href="/fitness/">减肥</a>');
document.writeln('<a href="/js/">健身</a>');
document.writeln('<a href="/beauty/">美容</a>');
document.writeln('<a href="/lx/">两性</a>');
document.writeln('<a href="/xinli/">心理</a>');
document.writeln('<a href="/baojian/">保健</a>');
document.writeln('<a href="/zx/">整形</a>');
document.writeln('<a href="/zhongyi/">中医</a>');
document.writeln('<a href="/tijian/">体检</a>');
document.writeln('<a href="/pianfang/">偏方</a>');
document.writeln('<a href="/pic/">图谱</a>');
document.writeln('</div>');
document.writeln('<div class="cont"><b>服务</b></div>');
document.writeln('<div class="c_free c_tot fread">');
document.writeln('<a href="">免费问医生</a>');
document.writeln('<a href="">就医助手</a>');
document.writeln('<a href="">疾病百科</a>');
document.writeln('<a href="">查药店</a>');
document.writeln('</div>');
document.writeln('<div class="cont"><b>问答</b></div>');
document.writeln('<div class="c_free c_tot myans">');
document.writeln('<a href="javascript: locationJump()" id = "myAsk" >我的问答</a>');
document.writeln('</div>');
document.writeln('<div class="l_out"><a href = "http://wapask.9939.com/login" >登录</a><a href = "http://wapask.9939.com/login/goregister" >注册</a></div>');
document.writeln('</div>');
document.writeln('</div>');

function locationJump(){
    window.location.href = "http://wapask.9939.com/ask/userasklist?userid=" + window.localStorage.getItem("userid") + "&id=" + Math.random();
}