<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title><{$article[0].title}>_久久图谱_久久健康网</title>
    <meta name="keywords" content="<{$article[0].keywords}>" />
    <meta name="description" content="<{$article[0].description}>" />
    <link rel="canonical" href="<{$pc_url}>">
    <meta name="viewport" id="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="applicable-device"content="mobile">
    <meta name="format-detection" content="telephone=no">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-retina.png">

    <link  href="/css/photo.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="/scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/scripts/zepto.min.js"></script>
    <script type="text/javascript" src="/scripts/swipe.min.js"></script>
    <script src="/scripts/gundong.js"></script>
    <script src="/scripts/page.js"></script>
    <script type="text/javascript" src="/scripts/jquery.touchSlider.js"></script>
    <script type="text/javascript" src="/scripts/slide.js"></script>

    <!-- 反屏蔽广告代码 -->
    <script>
        (window._ssp_global = window._ssp_global || {}).userConfig = {
            domain: "mjs.9939.com"
        }
    </script>
</head>

<body class="clor-2">
<!-- 页头 -->
<article class="feux0"></article>

<!--分享部分 Start-->
<{include file="pic/article_share.tpl"}>
<!--分享部分 End-->

<header class="noery herdt-3 reagin">
    <a href="javascript:history.back();" class="returm"></a><a href="javascript:;" class="lstrc"></a>
</header>

<article id="slider2" class="swipe">
    <ul class="revri clearfix">
        <{if isset($attachments) && !empty($attachments)}>
            <{foreach $attachments as $key => $attachment}>
                <li class="iask_day" data-index="<{$key + 1}>">
                    <div class="l-heroud">
                        <img src="<{$attachment.url}>" alt="<{$attachment.filename}>" tltle="<{$attachment.filename}>">
                    </div>
                    <section class="str-tit clearfix">
                        <div class="surnum">
                            <i class="bodro"><{$key + 1}></i>/<i class="allnum"><{$attachment.count}></i>
                        </div>
                        <h3 class="albumTitle js-albumTitle">
                            <{if isset($article[0]) && !empty($article[0])}>
                                <{$article[0].description}>
                            <{/if}>
                        </h3>
                        <p class="des briefIntro js-briefIntro"></p>
                    </section>
                </li>
            <{/foreach}>
        <{/if}>
        <li class="iask_day" data-index="5">
            <article class="slout">
                <ul class="comruh clearfix">
                    <{if isset($latestArticles) && !empty($latestArticles)}>
                        <{foreach $latestArticles as $latestArticle}>
                            <li>
                                <a href="<{$latestArticle.url}>" title="<{$latestArticle.title}>">
                                    <div class="">
                                        <img width="166.5" height="109" src="<{$latestArticle.thumb}>" alt="<{$latestArticle.title}>"  title="<{$latestArticle.title}>"/>
                                    </div>
                                    <span><{$latestArticle.title}></span>
                                </a>
                            </li>
                        <{/foreach}>
                    <{/if}>
                </ul>
            </article>

            <{include file="ads/pic_article_05.tpl"}>

            <article  class="l-snir clearfix">
                <{if isset($preArticle) && !empty($preArticle)}>
                    <a href="<{$preArticle.wap_url}>" title="<{$preArticle.title}>">
                        <p class="l-sam">上一篇</p><i>：</i><p class="wrteo"><{$preArticle.title}></p>
                    </a>
                <{/if}>
                <{if isset($nextArticle) && !empty($nextArticle)}>
                    <a href="<{$nextArticle.wap_url}>" title="<{$nextArticle.title}>">
                        <p class="l-sam">下一篇</p><i>：</i><p class="wrteo"><{$nextArticle.title}></p>
                    </a>
                <{/if}>
            </article>
        </li>
    </ul>
    <div id="curren_bar" class="curren_bar"><span class=" "></span><span class="current"></span></div>
</article>

<!-- 分享 -->
<!--2.2-->
<div class="doout"><div class="doarr"></div></div>
<div class="lispa reori dino">

    <article class="rehea dino"><a href="/pic/">图库</a></article>
    <div class="doar"><div><span>返回原图</span></div></div>

    <div class="adbak">
        <input type="hidden" id="articleIDVal" value="<{$articleid}>" />
        <div id="articleDatas"></div>

        <div class="apeand"></div>
        <div class="suneu dtuet"><{include file="ads/pic_article_04.tpl"}></div>

        <!--底部部分 Start-->
        <{include file="footer/pic_article_footer.html"}>
        <!--底部部分 End-->

    </div>
</div>

<section class="floor-item-d resy">
    <h4>热图推荐</h4>
    <div class="main_visual">
        <{include file="ads/pic_article_hot_pic.tpl"}>
    </div>
</section>

<{include file="ads/pic_img_plus.tpl"}>

<script src="/scripts/pic_article.js"></script>

</body>
</html>



