define(function(require){
	//库 声明
	var $ = require('zepto');
        
        function showLoginState(){
            var userid = window.localStorage.getItem('userid');
            var username = window.localStorage.getItem('username');
            var link = "http://wapask.9939.com/doctor/usercenter?userid=" + userid;
            if (typeof (userid)!="undefined" && parseInt(userid)>0){
                $('.login').hide();
                $('.lotal').attr('href', link);
                $(".lotal > span").text(username);
                $('.lotal').show();
            } else {
                $('.login').show();
            }
        }
        //头部导航弹出
        var bool=true;
        $('a.clna,a.personal-btn,.lin_02').click(function(){
            showLoginState();
            if(bool){
                    $('.heabar').removeClass('disn').addClass('shay');
                    bool=false;
            }
            else{
                    $('.heabar').removeClass('shay').addClass('disn');	
                    bool=true;		
            }
        });
        $('span.arrow').click(function(){
                $('.heabar').removeClass('shay').addClass('disn');	
                bool=true;	
        });
});