<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><{$setting.meta_title}></title>
<meta name="description" content="<{$setting.meta_description}>" />
<link rel="canonical" href="<{$pc_url}>">
<meta content="width=device-width,user-scalable=no" name="viewport">
<meta name="apple-mobile-web-app-capable" content="yes">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/body.css">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/other.css?201608221">
</head>
<body>
<article class="main">
<header class="main-hd personal-hd">
    <a href="/" class="j_logo"><img src="/images/jjlo.png"></a>
    <h2 class="main-hd-bt">久久健康网 · <a href="/<{$channels_url}>/"><{$channels}></a></h2>
    <div class="hd-right">
    <!--6.1 修改-->
        <div class="personal">
            <a href="javascript:;" class="personal-btn"><img src="/images/f_sym.png"></a>
        </div>
       <!--ends-->   
    </div>
</header>
<!--6.1 修改-->
<!--右上角快速导航 开始-->
<{include file="navigation/fast_navigation.html"}>
<!--右上角快速导航 结束-->
<nav class="navc">
<{if $channel_arry}>
    <{foreach from=$channel_arry item=channel key=key}>
        <{if $key lt 7}>
            <a href="<{if $channel.child eq 0}>/<{$channel.catdir}>/<{$channel.catid}>list.shtml <{else}>/<{$channels_url}>/<{$channel.catid}><{/if}>"><{$channel.catname}></a>
            <{if <{count($channel_arry)}> gt 7}>
                <{if $key eq 6}>
                    <a href="<{$channel.parentdir}>/nav.shtml">更多&nbsp;></a>
                <{/if}>
            <{else}>
                <{if $key eq <{count($channel_arry)}>-1}>
                    <a href="<{$channel.parentdir}>/nav.shtml">更多&nbsp;></a>
                <{/if}>
            <{/if}>
        <{/if}>
    <{/foreach}>
<{else}>
    <a>暂无信息</a>
<{/if}>
</nav>
<!-- 百度联盟 开始-->
<script type="text/javascript">
    /*WAP PD 导航下部20:5 创建于 2015-05-25*/
var cpro_id = "u2120613";
</script>
    <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
<!-- 百度联盟 结束-->
<{if $channel_arry}>
    <{foreach from=$channel_arry item=channel key=key}>
        <section class="sec<{if $key eq <{count($channel_arry)}>-1}> seco<{/if}>"><a href="<{if $channel.child eq 0}>/<{$channel.catdir}>/<{$channel.catid}>list.shtml <{else}>/<{$channels_url}>/<{$channel.catid}><{/if}>"><{$channel.catname}></a>
        <ul class="cop">
        <{foreach from=$channel.art item=article}>
            <li><span></span><a href="<{$article.art_base_path}>/<{$article.articleid}>.shtml"><{$article.title}></a></li>
        <{/foreach}>
        </ul><a href="<{if $channel.child eq 0}>/<{$channel.catdir}>/<{$channel.catid}>list.shtml <{else}>/<{$channels_url}>/<{$channel.catid}><{/if}>" class="loup">查看更多</a></section> 
        <{if $key is odd and $key neq <{count($channel_arry)}>-1 and $key lt 6}>
           <section style="margin-top:40px;margin-bottom:-40px;">
                <script type="text/javascript">
                /*wap 频道页广告 20:3 创建于 2015-06-04*/
                var cpro_id = "u2137699";
                </script>
               <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
            </section>
        <{/if}>
        <{if $key neq <{count($channel_arry)}>-1}>
            <a class="gocl" name="pre_02"></a>
        <{/if}>
    <{/foreach}>
<{/if}>
<div class="retop"><a href="javascript:scroll(0,0)"></a></div>

    <!-- footer stars -->
	   <{include file="footer/footer.html"}>
	<!-- footer ends -->
</article>
<script type="text/javascript" src="/scripts/sea.js"></script>
<script type="text/javascript">
	seajs.use("play.js")	
</script>
</body>
</html>
