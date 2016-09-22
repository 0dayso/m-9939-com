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
            <header><a href="<{$smarty.const.__DOMAINURL__}>" class="lin_01"><h1 alt="<{$channels}>"></h1></a><span><{$channels}></span><a href="javascript:void(0)" class="lin_02"></a><a href="<{$channel_catdir}>" class="lin_03"><{$channels_name|truncate:2:""}></a></header>
        </div>
        <article class="shocu">
            <a href="<{$smarty.const.__DOMAINURL__}>">首页</a>>
            <a href="<{$channel_catdir}>"><{$channels_name|truncate:2:""}></a>>
            <a href="<{$catdir}>/<{$catid}>/list.shtml"><{$channels}></a>
        </article>
        <!-- 轮播图 -->
        <{if $page lte 1}>
        <div class="banner">
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
        <{/if}>
        <!-- 轮播图 -->
        <!--first area-->
        <section>
            <{if $page lte 1}>
            <h3 class="tit"><{$channels}></h3>
            <{/if}>
            <article class="recom unili renews conart">
                
                
                <{if $article_arry}>
                    <{foreach from=$article_arry key=kk item=arts}>
                    <{if $page lte 1}>
                        <{if $kk == 0 || $kk == 1}>
                            <a href="<{$art_base_path}>/<{$arts.articleid}>.shtml"><p class="repu"><{$arts.title|strip:" "}></p><p><{$arts.description|strip:" "}></p></a>
                        <{elseif $kk == 3}>
                            <a href="<{$art_base_path}>/<{$arts.articleid}>.shtml"><p class="hota"><{$arts.title|strip:" "}></p><p><{$arts.description|strip:" "}></p></a>
                        <{else}>
                            <a href="<{$art_base_path}>/<{$arts.articleid}>.shtml"><p><{$arts.title|strip:" "}></p><p><{$arts.description|strip:" "}></p></a>
                        <{/if}>
                     <{else}>
                            <{if $kk == 0}>
                                <a><{$ads_4}></a>
                            <{/if}>
                            <a href="<{$art_base_path}>/<{$arts.articleid}>.shtml"><p><{$arts.title|strip:" "}></p><p><{$arts.description|strip:" "}></p></a>
                     <{/if}>
                     <{if $kk == 4}>
                        <a><{$ads_1}></a>
                     <{elseif $kk ==9}>
                        <a><{$ads_2}></a>
                     <{elseif $kk ==14}>
                         <a><{$ads_3}></a>
                     <{elseif $kk ==19}>
                        <a><{$ads_4}></a>
                     <{/if}>
                        
                    <{/foreach}>
                <{/if}>
           
            </article>
        </section>
        <article class="page">
            <{$page_html}>
        </article>

        <div class="area"></div>
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
                <{if isset($ads_5) && !empty($ads_5)}>
                    <{$ads_5}>
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
                callback: function(index, elm) {},
                        transitionEnd: function(index, elem) {}
            });
        </script>


    </body>
</html>
