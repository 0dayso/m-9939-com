/**
 * Created by gaoqing on 2016/3/9.
 * 文章页的脚本文件
 */
$(function(){
    var heis=$(window).height();

    var heir=heis-88;
    var rheight=0;//记录原来图片域的高度

    /*获取图片路径*/
    var ind=$('.swipe li').find(':first img').attr('src');
    $('.doar').css('background-image','url('+ind+')');

    $('.doarr').click(function(){

        /*for(var i=0;i<=5;i++){

         if(ind.eq(i).attr('style').substr(-27,1)=='(')
         {
         var imsrc=ind.eq(i).find('img').attr('src');
         $('.doar').css('background-image','url('+imsrc+')');
         }

         }*/
        var intervalID=0;
        rheight=$(".swipe").height();//获取原div高度，用于还原
        $(this).removeClass('shol').addClass('dino');

        $('.lispa,.rehea').removeClass('dino').addClass('shol');
        $('.reagin').removeClass('shol').addClass('dino');

        $('.resy').addClass('nres').appendTo($('.apeand'));

        var fundisp=function(){
            var hei=$(".swipe").height();
            var heisa=hei/10;
            //保留80px高度，使标题栏出现
            if(hei>49){

                $(".swipe").height(hei-heisa);//逐渐减小高度
            }else{
                clearInterval(intervalID);
            }
        }
        intervalID=setInterval(fundisp,0.1);
    });
    $('.doar').click(function(){
        var intervalID2=0;
        //var wheight=$(window).height()-80;
        $('.lispa,.rehea').removeClass('shol').addClass('dino');
        $('.doarr,.reagin').removeClass('dino').addClass('shol');

        var fundisp2=function(){
            var hei=$(".swipe").height();

            if(hei<heir-33){
                $(".swipe").height(hei+heir/10);
            }else{
                clearInterval(intervalID2);
            }
        }
        intervalID2=setInterval(fundisp2,2);
    });
});
$(function () {
    $('.lstrc').click(function(){
        $('.feux0,.sio').show();
    });
    $('.cairet').click(function(){
        $('.feux0,.sio').hide();
    });


    //加载文章列表
    $.ajax({
        type : "GET",
        url : "/article/articledatas",
        data : "articleid="+$("#articleIDVal").val()+"&page=1",
        dataType: "html",
        success: function(res){
            scroll(0,0);
            $("#articleDatas").html(res);
        }
    });

});
/*2.2*/
window.mySwipe = new Swipe(document.getElementById('slider2'), {
    startSlide: 0,
    speed:0,
    auto:0,
    continuous: false,
    disableScroll: false,
    stopPropagation: false,
    callback: function(index,elm) {
        var i = bullets.length;
        while (i--) {
            bullets[i].className = ' ';
        }
        bullets[index].className = 'current';
    },
    transitionEnd: function(index, elem) {
        var cuva=$(elem).find("img").attr("src");
        $('.doar').css('background-image','url('+cuva+')');

    }
});
var bullets = document.getElementById('curren_bar').getElementsByTagName('span');


