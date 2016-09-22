<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><{$search_name}>_久久母婴专题_久久健康</title>
<meta name="keywords" content="<{$metaKeywords}>" />
<meta name="description" content="<{$metaDescription}>" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<link rel="canonical" href="http://baby.9939.com/zhuanti/<{$search}>/">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/style2.css">
<script src="<{$smarty.const.__DOMAINURL__}>/scripts/js/jquery-1.11.2.min.js"></script>
<script src="<{$smarty.const.__DOMAINURL__}>/scripts/js/detail.js"></script>
<!--slide滚动-->
    <script type="text/javascript" src="<{$smarty.const.__DOMAINURL__}>/scripts/js/jquery.event.drag-1.5.min.js"></script>
    <script type="text/javascript" src="<{$smarty.const.__DOMAINURL__}>/scripts/js/jquery.touchSlider.js"></script>
    <script src="<{$smarty.const.__DOMAINURL__}>/scripts/js/slide.js"></script>
    <script src="<{$smarty.const.__DOMAINURL__}>/scripts/top_nav.js"></script>
<!--ends-->
</head>
<body>
<article class="head batop"><a href="/"></a><span><{$search_name}></span><a class="clna"></a><div class="fiti">母婴</div></article>
<article class="breas"><a href="/">首页</a><span>&gt;</span><a href="/baby/">母婴</a><span>&gt;</span><a href="/baby/zhuanti/">母婴专题</a></article>
<!--导航栏展开-->
<{include file="navigation/baby_navigation.html"}>
<!--ends-->
<h1 class="paiti"><{QLib_Utils_String::cutString($search_name, 9,0)}><span>的专题</span></h1>
<div class="shto">
    <script type="text/javascript">
        var cpro_id="u2545540";
        (window["cproStyleApi"] = window["cproStyleApi"] || {})[cpro_id]={at:"3",hn:"0",wn:"0",imgRatio:"1.7",scale:"20.6",pat:"6",tn:"template_inlay_all_mobile_lu_native",rss1:"#FFFFFF",adp:"1",ptt:"0",titFF:"%E5%BE%AE%E8%BD%AF%E9%9B%85%E9%BB%91",titFS:"14",rss2:"#000000",titSU:"0",ptbg:"70",ptp:"0"}
    </script>
    <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
</div>

<article class="mak">
    <{if $articles_one}>
        <{foreach from=$articles_one  key=kk item=art}>
            <{if $kk%3 == 0}>
                <h3><a href="<{$art.url}>"><{$art.title}></a></h3>
            <{elseif $kk%3 == 2}>
                <a href="<{$art.url}>"><{$art.title}></a></p>
            <{else}>
               <p><a href="<{$art.url}>"><{$art.title}></a><span>|</span>
            <{/if}>
        <{/foreach}>
    <{/if}>
</article>

<{if $articles_pic}>
    <{foreach from=$articles_pic  key=kk item=art}>
        <a href="<{$art.url}>" class="imsho" title="<{$art.title}>"><img src="<{$smarty.const.__DOMAINURL__}>/images/prb.jpg" title="<{$art.title}>"><div></div><p><{$art.title}></p></a>
    <{/foreach}>
<{/if}>


<article class="carba">
    <{if $articles_two}>
        <{foreach from=$articles_two key=kk item=art}>
            <a href="<{$art.url}>" title="<{$art.title}>"><{QLib_Utils_String::cutString($art.title,20,0)}></a>
        <{/foreach}>
    <{/if}>
</article>

<div class="shto adme">
    <script type="text/javascript">
        /*资讯热搜wap端内容页更多上方*/
        var cpro_id = "u2452096";
    </script>
    <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
</div>
<div class="thre"></div>
<h2 class="tit">母婴资讯</h2>
<ul class="upda sedoc">
    <{if $articles_three}>
        <{foreach from=$articles_three key=kk item=art}>
        <li>
            <h3><a href="<{$art.url}>" title="<{$art.title}>"><{$art.title}></a></h3>
            <p><{$art.description|strip:" "}></p><div></div>
        </li>
        <{/foreach}>
    <{/if}>
</ul>
<a href="http://m.9939.com/baby" class="fimor">点击查看更多<span>></span></a>
<!--ends-->
<div class="thre"></div>
<h2 class="tit">育儿问答</h2>
<ul class="upda attent gdise">
    <{if $yuer_ask_1}>
        <{foreach from=$yuer_ask_1 key = ask item=ask_list}>
            <li>
                <h3><span>Q</span><a href="http://wapask.9939.com/id/<{$ask_list.id}>.html"><{$ask_list.title}></a></h3>
                <{foreach from=$ask_list.answer key=ask1 item = ask_list_2}>
                    <p><span>A</span><{QLib_Utils_String::cutString($ask_list_2.content, 80,0)}></p>
                <{/foreach}>
                <div></div>
            </li>
        <{/foreach}>
    <{/if}>
    <{if $yuer_ask_2}>
        <{foreach from = $yuer_ask_2 key = ask2 item= ask_list3}>
            <li><h3><span>Q</span><a href="http://wapask.9939.com/id/<{$ask_list.id}>.html"><{QLib_Utils_String::cutString($ask_list3.content, 80,0)}></a></h3><div></div></li>
        <{/foreach}>
    <{/if}>
</ul>
<a href="http://wapask.9939.com/classid/236.html" class="fimor">点击查看更多<span>></span></a>


<div class="thre"></div>
<h2 class="tit">常见疾病</h2>
<article class="physi">
	<div class="cuinf clearfix"><a class="cusx">妇科</a><a>产科</a><a>儿科</a></div>
	<div class="slicon  clearfix">
            <{foreach from=$disease.disease_fuke key=f item = fuke}>
            <a href="http://m.jb.9939.com/<{$fuke.pinyin_initial}>"><{$fuke.name}></a>
            <{/foreach}>
            
        </div>
    <div class="slicon disn  clearfix">
        <{foreach from=$disease.disease_chanke key=f item = fuke}>
            <a href="http://m.jb.9939.com/<{$fuke.pinyin_initial}>"><{$fuke.name}></a>
        <{/foreach}>
    </div>
    <div class="slicon disn clearfix">
        <{foreach from=$disease.disease_erke key=f item = fuke}>
            <a href="http://m.jb.9939.com/<{$fuke.pinyin_initial}>"><{$fuke.name}></a>
        <{/foreach}>
    </div>
</article>
<!--广告位-->
<div class="adv">
    <script type="text/javascript">
        var cpro_id="u2442390";
        (window["cproStyleApi"] = window["cproStyleApi"] || {})[cpro_id]={at:"3",hn:"0",wn:"0",imgRatio:"1.7",scale:"20.12",pat:"6",tn:"template_inlay_all_mobile_lu_native",rss1:"#FFFFFF",adp:"1",ptt:"0",titFF:"%E5%BE%AE%E8%BD%AF%E9%9B%85%E9%BB%91",titFS:"14",rss2:"#000000",titSU:"0",ptbg:"70",ptp:"0"}
        </script>
        <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
</div>
<div class="thre"></div>
<h2 class="tit"><a href="/baby/zhuanti/zhoukan">更多<span>></span></a>育儿百科</h2>

<ul class="allinf clearfix">
    <li>
        <h3>备孕<br/>指南</h3>
        <a href="http://m.9939.com/baby/article/3136491.shtml">备孕用品</a>
        <a href="http://m.9939.com/baby/article/3136493.shtml">夫妻生活</a>
        <a href="http://m.9939.com/baby/article/3136496.shtml">宝宝取名</a>
        <a href="http://m.9939.com/baby/article/3136483.shtml">验孕纸</a>
        <a href="http://m.9939.com/baby/article/3136484.shtml">排卵期</a>
        <a href="http://m.9939.com/baby/article/3136490.shtml">月经不调</a>
    </li>
    <li>
        <h3>孕期<br/>保健</h3>
        <a href="http://m.9939.com/baby/article/3136597.shtml">孕期补钙</a>
        <a href="http://m.9939.com/baby/article/3136600.shtml">维生素片</a>
        <a href="http://m.9939.com/baby/article/3136603.shtml">防辐射</a>
        <a href="http://m.9939.com/baby/article/3136606.shtml">妊娠纹</a>
        <a href="http://m.9939.com/baby/article/3136609.shtml">孕吐</a>
        <a href="http://m.9939.com/baby/article/3136622.shtml">孕妇护肤</a>
    </li>
    <li>
        <h3>生育<br/>政策</h3>
        <a href="http://m.9939.com/baby/article/3136509.shtml">单独二胎</a>
        <a href="http://m.9939.com/baby/article/3136512.shtml">新婚姻法</a>
        <a href="http://m.9939.com/baby/article/3136516.shtml">赴美生子</a>
        <a href="http://m.9939.com/baby/article/3136518.shtml">赴港生子</a>
        <a href="http://m.9939.com/baby/article/3136520.shtml">生二胎</a>
        <a href="http://m.9939.com/baby/article/3136523.shtml">出生证</a>
    </li>
    <li>
        <h3>孕期<br/>营养</h3>
        <a href="http://m.9939.com/baby/article/3136623.shtml">成人奶粉</a>
        <a href="http://m.9939.com/baby/article/3136625.shtml">早餐</a>
        <a href="http://m.9939.com/baby/article/3136628.shtml">孕妇食品</a>
        <a href="http://m.9939.com/baby/article/3136629.shtml">孕期吃酸</a>
        <a href="http://m.9939.com/baby/article/3136632.shtml">碘</a>
        <a href="http://m.9939.com/baby/article/3136634.shtml">木耳</a>
    </li>
    <li>
        <h3>孕期<br/>检查</h3>
        <a href="http://m.9939.com/baby/article/3136526.shtml">精液检测</a>
        <a href="http://m.9939.com/baby/article/3136528.shtml">婚检</a>
        <a href="http://m.9939.com/baby/article/3136530.shtml">性病检查</a>
        <a href="http://m.9939.com/baby/article/3136532.shtml">妇科检查</a>
        <a href="http://m.9939.com/baby/article/3136533.shtml">孕前用药</a>
        <a href="http://m.9939.com/baby/article/3136534.shtml">排卵检测</a>
    </li>
    <li>
        <h3>孕期<br/>疾病</h3>
        <a href="http://m.9939.com/baby/article/3136638.shtml">乙肝遗传</a>
        <a href="http://m.9939.com/baby/article/3136640.shtml">小腿浮肿</a>
        <a href="http://m.9939.com/baby/article/3136644.shtml">妊高症</a>
        <a href="http://m.9939.com/baby/article/3157136.shtml">呕吐出血</a>
        <a href="http://m.9939.com/baby/article/3157137.shtml">孕期便秘</a>
        <a href="http://m.9939.com/baby/article/3157138.shtml">羊水少</a>
    </li>
</ul>

<{include file="footer/baby_footer.html"}>
</body>
</html>
