<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>图片_图片大全_好看的图片_有意思的图片 - 图库 - 久久健康网WAP</title>
    <meta name="keywords" content="图片,图片大全,图库" />
    <meta name="description" content="久久健康网图库包含：搞笑趣图、美女图片、明星图片、社会万象、军事图片等，这里都是有意思、有看点的图片。" />
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/css/style3.css">
    <script src="/scripts/js/jquery-1.11.2.min.js"></script>
    <script src="/scripts/js/detail.js"></script>
</head>

<body>
<header>
    <a href="">
        <h1></h1>
    </a>
    <div class="nav">
        <a href="http://mqiqu.9939.com/qiqu/yangyanmeitu/">美女</a>
        <a href="http://mqiqu.9939.com/qiqu/shehuibaitai/">社会</a>
        <a href="http://mqiqu.9939.com/qiqu/baguaquwen/">搞笑</a>
        <a href="http://mqiqu.9939.com/qiqu/liangxingqiqu/">两性</a>
        <a href="http://mqiqu.9939.com/qiqu/qiwenyishi/">奇闻</a>
        <a href="http://mqiqu.9939.com/qiqu/neihantu/">内涵</a>
    </div>
    <a class="clna"></a>
</header>

<!--导航栏展开-->
<{include file="navigation/fast_navigation.html"}>
<!--ends-->

<nav>
    <a href="">首页</a>
    <span>></span>
    <a>热图推荐</a>
</nav>
<Article class="adv">
    <{$text_ads}>
</Article>

<section class="detai">
    <{foreach from=$pic_ads item=val key=key}>
        <a href="<{$val.linkurl}>">
            <img src="<{$val.imageurl}>" alt="<{$val.adsname}>" title="<{$val.adsname}>">
            <p><{$val.adsname}></p>
        </a>
    <{/foreach}>
</section>

<{include file="footer/hot_rec_footer.html"}>
<!--返回顶部-->

<a class="retop" href="javascript:scroll(0,0)"></a>
</body>
</html>