<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title><{$result.title}>_久久两性_久久健康网</title>
    <meta name="keywords" content="<{$result.keywords}>" />
    <meta name="description" content="<{$result.description}>" />
    <link rel="canonical" href="<{$pc_article_url}>">
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
<{include file="Article/xatp_article_share.tpl"}>
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
                        <{$attachment}>
                    </div>
                    <section class="str-tit clearfix">
                        <div class="surnum">
                            <i class="bodro"><{$key + 1}></i>/<i class="allnum"><{count($attachments)}></i>
                        </div>
                        <h3 class="albumTitle js-albumTitle">
                            <{if isset($result) && !empty($result)}>
                                <{$result.description}>
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
                    <{if isset($article) && !empty($article)}>
                        <{foreach $article as $latestArticle}>
                            <li>
                                <a href="<{$latestArticle.url}>" title="<{$latestArticle.title}>">
                                    <div class="">
                                        <{$latestArticle.thumb}>
                                    </div>
                                    <span><{$latestArticle.title}></span>
                                </a>
                            </li>
                        <{/foreach}>
                    <{/if}>
                </ul>
            </article>

            <{if isset($ads_4) && !empty($ads_4)}>
                <{$ads_4}>
            <{/if}>

            <article  class="l-snir clearfix">
                <{if isset($article_last) && !empty($article_last)}>
                    <a href="<{$article_last.url}>" title="<{$article_last.title}>">
                        <p class="l-sam">上一篇</p><i>：</i><p class="wrteo"><{$article_last.title}></p>
                    </a>
                <{/if}>
                <{if isset($article_next) && !empty($article_next)}>
                    <a href="<{$article_next.url}>" title="<{$article_next.title}>">
                        <p class="l-sam">下一篇</p><i>：</i><p class="wrteo"><{$article_next.title}></p>
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

    <article class="rehea dino"><a href="/lx/">两性</a></article>
    <div class="doar"><div><span>返回原图</span></div></div>

    <div class="adbak">
        <input type="hidden" id="articleIDVal" value="<{$result['articleid']}>" />
        <div id="articleDatas"></div>

        <div class="apeand"></div>
        <div class="suneu dtuet">
            <{if isset($ads_3) && !empty($ads_3)}>
                <{$ads_3}>
            <{/if}>
        </div>

        <!--底部部分 Start-->
        <{include file="footer/pic_article_footer.html"}>
        <!--底部部分 End-->

    </div>
</div>

<section class="floor-item-d resy">
    <h4>热图推荐</h4>
    <div class="main_visual">
        <{include file="ads/xatp_article_hot_pic.tpl"}>
    </div>
</section>

<{include file="ads/pic_img_plus.tpl"}>

<script src="/scripts/xatp_article.js"></script>
<!-- uc ads -->
<{nocache}>
<{if isset($ads_uc) && !empty($ads_uc)}>
<{$ads_uc}>
<{/if}>
<{/nocache}>
<!-- uc ads -->
<!-- ads 4567 -->
<{nocache}>
<{if isset($ads_4567) && !empty($ads_4567)}>
<{$ads_4567}>
<{/if}>
<{/nocache}>
<!-- ads 4567 -->
</body>
</html>



