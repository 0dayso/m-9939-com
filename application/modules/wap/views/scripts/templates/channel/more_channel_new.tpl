<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title><{$setting.meta_title}></title>
        <meta name="description" content="<{$setting.meta_description}>" />
        <link rel="canonical" href="<{$pc_url}>">
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
        <script type="text/javascript" src="/scripts/zepto.min.js"></script>
        <script type="text/javascript" src="/scripts/swipe.min.js"></script>
        <script src="/scripts/gundong.js"></script>
        <script src="/scripts/page.js"></script>
        <script type="text/javascript" src="/scripts/jquery.touchSlider.js"></script>
        <script type="text/javascript" src="/scripts/slide.js"></script>
        <script type="text/javascript" src="/scripts/top_nav.js"></script>
    </head>
<body>
    <!--左上角弹出层-->
    <{include file="navigation/fast_navigation.html"}>
    <div class="heout">
        <header>
            <{if $channels}>
            <a href="<{$smarty.const.__DOMAINURL__}>" class="lin_01"><h1 alt="<{$channels}>"></h1></a><span><{$channels}></span>
            <{else}>
            <a href="<{$smarty.const.__DOMAINURL__}>" class="lin_01"><h1 alt="<{$channel_catname}>"></h1></a><span><{$channel_catname}></span>
            <{/if}>
            <a href="javascript:void(0)" class="lin_02"></a>
            <a href="/<{$channels_url}>/" class="lin_03"><{$channel_catname|truncate:2:"":true}></a>
        </header>
    </div>
        
<nav class="linav" style="height:auto;">
    <{if $channel_arry}>
    <{foreach from=$channel_arry item=channel}><a href="<{if $channel.child eq 0}>/<{$channel.catdir}>/<{$channel.catid}>list.shtml <{else}>/<{$channels_url}>/<{$channel.catid}><{/if}>"><{$channel.catname}></a><{/foreach}>
    <{/if}>
</nav>
        
        <div class="banner">
            <!-- 轮播图 -->
            <div id="slider" class="swipe" >
                <div class="swipe-wrap">
                     <{foreach from=$slider item=val key=key}>
                     <div class="banner_item" data-index="<{$key}>" >
                        <a href="<{$val.linkurl}>"><img src="<{$val.imageurl}>" alt="<{$adsname}>"></a>
                        <div class="opacity_d"></div>
                        <div class="banner_text"><{$val.adsname}></div>
                        <div class="sklo"><span class="ind_nb"><{$key+1}></span>/<span class="all_nb"><{$slider|@count}></span></div>
                    </div>  
                    <{/foreach}>

                </div>
            </div>
        </div>
        
    <{if $section}>
        <{foreach from=$section key=kk item=val}>
        <{if !empty($val['art'])}>
            <section>
                    <h3 class="tit"><{$val.cat.catname}></h3>
                    <article class="recom liscon harco">
                        <{foreach from=$val['art'] item=v}>
                        <a href="<{$v.url}>"><{$v.title}></a>
                        <{/foreach}>
                    </article>
                    <a href="<{if $val.cat.child eq 0}>/<{$val.cat.catdir}>/<{$val.cat.catid}>list.shtml <{else}>/<{$channels_url}>/<{$val.cat.catid}><{/if}>" class="finmo">更多精彩内容 >></a>
                    <div class="adv adv_02">
                        <!--插入广告位-->
                        <{if isset($ads_1) && !empty($ads_1)}>
                            <{$ads_1}>
                        <{/if}> 
                    </div>
                    <div class="area"></div>
                </section>
         <{/if}>           
        <{/foreach}>
    <{/if}>


<article class="hoimg">
	
	<h3>热图推荐</h3>	
   <section class="floor-item-d">
               
               <div class="main_visual">
	             <div class="flicking_con">
                        <{if isset($ads_hotpic) && !empty($ads_hotpic)}>
                            <{foreach $ads_hotpic as $key => $hotPic}>
                               <{if $key is even}>
                                    <a href="#"><{($key/2) + 1}></a>
                               <{/if}>
                            <{/foreach}>
                        <{/if}>
                     </div>
	             <div class="main_image">
                         <ul class="d-durse clearfix">
                             <{if isset($ads_hotpic)}>
                                <{foreach from=$ads_hotpic item=val key=key}>
                                   <{if $key is even}>
                                       <li>
                                    <{/if}>

                                    <div class="louts"><a href="<{$val.linkurl}>"><img src="<{$val.imageurl}>"  alt="<{$val.adsname}>" title="<{$val.adsname}>"></a><span><{$val.adsname}></span></div>

                                    <{if $key is odd}>
                                       </li>
                                   <{/if}>
                                <{/foreach}>
                             <{/if}>
                         </ul>
	       </div>
             
            </div>
         </section>    
    
        <div class="adv_05">
            <{if isset($ads_2) && !empty($ads_2)}>
                <{$ads_2}>
            <{/if}> 
        </div>
   
</article>
<div class="area"></div>
<!-- 聚合阅读 stars -->
<{include file="footer/reading_footer.html"}>
<!-- 聚合阅读 ends -->

<!-- footer stars -->
<{include file="footer/footer.html"}>
<!-- footer ends -->
<!-- ads-common stars -->
<{if isset($ads_common) && !empty($ads_common)}>
    <{$ads_common}>
<{/if}>
<!-- ads-common ends -->
<!-- ads-quan stars -->
    <{if isset($ads_quan) && !empty($ads_quan)}>
        <{$ads_quan}>
    <{/if}>
<!-- ads-quan ends -->
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
<script type="text/javascript">
   
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
</script>
</body>
</html>
