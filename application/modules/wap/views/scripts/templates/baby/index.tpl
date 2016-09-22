<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><{$metaTitle}></title>
<meta name="keywords" content="<{$metaKeywords}>" />
<meta name="description" content="<{$metaDescription}>" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<link rel="canonical" href="http://baby.9939.com/zhuanti/">
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
<article class="head"><a href="/"></a><span>母婴专题</span><a class="clna"></a></article>
<!--导航栏展开-->
<{include file="navigation/baby_navigation.html"}>
<!--ends-->
<article class="breas"><a href="/">首页</a><span>></span><a href="/baby/">母婴</a><span>></span><a href="/baby/zhuanti/">母婴专题</a></article>

<article class="tora clearfix">
    <{if $rand_words}>
        <{foreach from=$rand_words key=zimu item=words}>
        <div class="cure <{if $zimu!="A"}> disn <{/if}>">
            <{if $words}>
                <{foreach from= $words key=k item = words_detail}>
                    <a href="<{$searchurl}><{$words_detail.pinyin}>/" title="<{$words_detail.keywords}>"><{QLib_Utils_String::cutString($words_detail.keywords, 15,0)}></a>
                <{/foreach}>
            <{else}>
                <a>暂无信息</a>
            <{/if}>
        </div>
        <{/foreach}>
    <{/if}>

<div class="lette">
    <{if $letter_list}>
        <{foreach from = $letter_list key=k item = letter1}>
            <a class=" <{if $k=='A'}>cur<{/if}>"><{$k}></a>
        <{/foreach}>
    <{/if}>
</div>

</article>
<{include file="footer/baby_footer.html"}>
</body>
</html>
