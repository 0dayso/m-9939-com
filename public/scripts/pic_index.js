/**
 * Created by gaoqing on 2016/3/7.
 * 图谱下的首页的 js 脚本
 */

$("#toggle").click(function() {
    var t = $(this);
    t.toggleClass("toggle");
    if (t.hasClass("toggle")) {
        $(".navmore").show();
        $(this).find('.togglemore').hide();
    } else {
        $(".navmore").hide();
        $(this).find('.togglemore').show();
    };
});
$(".nav li").click(function() {
    $(this).siblings().removeClass("current");
    $(this).addClass("current");
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
