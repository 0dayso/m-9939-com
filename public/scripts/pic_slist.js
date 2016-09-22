/**
 * Created by gaoqing on 2016/3/7.
 * 图谱下的单列表页的 js 脚本
 */

addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
function hideURLbar(){
    window.scrollTo(0,1);
}
$(function(){
    $('.caty_btn').click(function(){
        var windowHeight =$(window).height();
        height = $(document).height(),
            width=$('.mask ul').width()+45,
            node = $('<div id="wmask" style="position:absolute;top:0;left:0;width:100%; min-height:100%; height:'+ height +'px;opacity:0.1;z-index:20;background:#262626;"></div>'),
            self = $(this),
            $('.mask ul').css('max-height',windowHeight);
        $('body').append(node);
        $('.mask').css({"display":"block"});
        var dHeight = $('.mask ul li').height();
        if(dHeight>=windowHeight){
            $('.mask').css({"height":windowHeight});
        }else{
            $('.mask').css({"height":dHeight});
        }
        $('.mask').animate({translate3D:'0, 0, 0'}, 200);
        $('#wmask').click(function(){
            $(this).remove();
            $('.mask').animate({translate3D:width+'px, 0 ,0'}, 200);
            $('.mask').css("display","none");
        });
        $('.mask-close,.arrow_close').click(function(){
            $('#wmask').trigger('click');
        });
    });
});
$(function(){
    var $btn= $(".caty a"),
        $catyLi = $(".caty li");
    $btn.on("click",function(){
        var $catyUl = $(this).next("ul");
        $catyUl.toggleClass("display_none");
    })
    $(document).on("click",function(e){
        var $target = $(e.target);
        if($target.closest(".caty ul").length == 0 && $target.closest(".caty a").length == 0){
            $(".caty ul").addClass("display_none");
        }
    })
    $catyLi.on("click",function(e){
        var txt = $(this).text();
        var liId=$(this).attr("id");
        $(this).parents(".caty ul").addClass("display_none");
        $(this).parents().find($btn).find("span").text(txt);
        $("#hot_answer_list").hide();
        $(".hot_list").hide();
        $("#"+liId+"_bd").show();
    })
});
window.mySwipe = new Swipe(document.getElementById('slider'), {
    startSlide: 0,
    speed: 600,
    auto: 4000,
    continuous: true,
    disableScroll: false,
    stopPropagation: false,
    callback: function(index,elm) {},
    transitionEnd: function(index, elem) {}
});
window.mySwipe = new Swipe(document.getElementById('slider2'), {
    startSlide: 0,
    speed: 600,
    auto: 40000,
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
    transitionEnd: function(index, elem) {}
});
var bullets = document.getElementById('curren_bar').getElementsByTagName('span');
$(function(){
    var $imgTs = $(".item_pic"),
        $item = $imgTs.find("li"),
        img = $item.find("img");
    window.onload = function(){
        var width = (window.innerWidth > 0) ? window.innerWidth : screen.width,
            imgW = (width-30)/2,
            imgH = imgW/290*126,
            topimgH = width/640*110;
        img.css({"width":imgW,"height":imgH});
        $item.css("width",imgW);
    };
});
$("#more").click(function(){
    $("#five").hide();
    $("#ten").show();
});
$("#waitAnswer").click(function(){
    var wenwoUser="";
    if(wenwoUser==null||wenwoUser==""){
        thisHref=window.location.href;
        window.location.href="/login?source=" + thisHref;
        return;
    }
    var hg="";
    $(".hot_list").hide();
    $("#hot_answer_list").show();
    if(!hg){
        $("#no_set_area").show();
        return;
    }
    $.ajax({
        type: "POST",
        url: "/question/newgwfmaqnl",
        success: function(data){
            $("#hot_answer_list").html(data);
        }
    });
});
$("#setBtn").click(function(){
    window.location.href="/help/index";
});
$(".change").live("click",function(){
    $.ajax({
        type: "POST",
        url: "/question/newgwfmaqnl",
        success: function(data){
            $("#hot_answer_list").html(data);
        }
    });
});
$(".yl_cl").click(function(){
    $("#hot_answer_list").hide();
    $(".hot_list").hide();
    $(".caty a").find("span").text("选择分类");
    $("#five").show();
});
function quetionDetail(qid){
    window.location.href = "/b/"+qid + ".html";
};

