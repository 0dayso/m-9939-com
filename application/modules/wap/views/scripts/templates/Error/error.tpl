<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>错误页面</title>
        <meta name="viewport" id="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="applicable-device" content="mobile">
        <meta name="format-detection" content="telephone=no">
        <link rel="apple-touch-icon" sizes="72x72" href="/images/apple-touch-icon.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/images/apple-touch-icon-retina.png">
        <link rel="stylesheet" type="text/css" href="/css/style.css">
        <link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/other.css?201608221">
        <script type="text/javascript" src="/scripts/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="/scripts/detail.js"></script>
        <script type="text/javascript" src="/scripts/top_nav.js"></script>
    </head>
    <body>
        <!--左上角弹出层-->
        <{include file="navigation/fast_navigation.html"}>
        <div class="heout"><header><a href="<{$smarty.const.__DOMAINURL__}>" class="lin_01"><h1 alt=""></h1></a><span></span><a href="javascript:void(0)" class="lin_02"></a></header></div>

        <div class="error"><img src="/images/erro.jpg" alt=""></div>
        <form class="ftla" action="<{$smarty.const.__DOMAINURL__}>"><input type="search"  placeholder="请输入关键字"><input type="submit" value="返回首页" ></form>

        <div class="imsho">
            <a href=""><img src="/images/beat.jpg" alt=""><p>不同年龄找最适合眼霜</p></a>
            <a href=""><img src="/images/beat.jpg" alt=""><p>不同年龄找最适合眼霜</p></a>
            <a href=""><img src="/images/beat.jpg" alt=""><p>不同年龄找最适合眼霜</p></a>
            <a href=""><img src="/images/beat.jpg" alt=""><p>不同年龄找最适合眼霜</p></a>
        </div>

        <div class="area"></div>
        <article class="hoimg cabot">
            <h3>最新资讯</h3>	
            <{if $art_zx}>
            <article class="recom liscon newca harco">
                <{foreach from=$art_zx item=val key=key}>
                <a href="<{$val.url}>"><{$val.title|truncate:18:'...':true}></a>
                <{/foreach}>
            </article> 
            <{/if}>
        </article>

        <div class="area"></div>
        <article class="hoimg cabot">
            <h3>疾病健康</h3>	
            <article class="recom liscon newca harco">
                <{foreach from=$art_dis item=val key=key}>
                <a href="<{$val.url}>"><{$val.title|truncate:18:'...':true}></a>
                <{/foreach}>
            </article> 
        </article>

        <div class="area"></div>
        <article class="hoimg cabot">
            <h3>精彩问答</h3>	
            <article class="recom liscon newca harco">
                <{foreach from=$art_ask item=val key=key}>
                <a href="<{$val.url}>"><{$val.title|truncate:18:'...':true}></a>
                <{/foreach}>     
            </article> 
        </article>


        <div class="area"></div>
        <!-- footer stars -->
        <{include file="footer/footer.html"}>
        <!-- footer ends -->

    </body>
</html>
