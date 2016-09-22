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
        <!--新增苹果手机safa317ri弹出层--> 
        <link rel="apple-touch-icon" href="<{$smarty.const.__DOMAINURL__}>/images/logo114.png" />
        <!--ends-->
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
                <a href="<{$smarty.const.__DOMAINURL__}>" class="lin_01"><h1 alt="久久健康"></h1></a>
                <span>久久<{$channels}></span>
                <a href="javascript:void(0)" class="lin_02"></a>
            </header>
        </div>

        <nav>
            <div>
            <{if $channel_arry}>
            <{foreach from=$channel_arry item=channel key=key}>
                <{if $channel.catid == 'wenzhangzhengwen/'}>
                    <{continue}>
                <{else}>
                    <a href="<{if $channel.child eq 0}>/<{$channel.catdir}>/<{$channel.catid}>list.shtml <{else}>/<{$channels_url}>/<{$channel.catid}><{/if}>"><{$channel.catname}></a>
                <{/if}>
            <{/foreach}>
            <{else}>
            <a>暂无信息</a>
            <{/if}>
            </div>
            <span></span>
        </nav>

        <{foreach from=$articles_11 item=val key=key}>
        <{if $key lt 6}>
        <{if $key == 0 || $key == 3}>
        <hgroup>
            <h2>
                <a href="<{$val.url}>"><{$val.title}></a>
            </h2>
            <p>
                <{elseif $key ==1 || $key ==4}>
                <a href="<{$val.url}>"><{$val.title}></a>
                <{else}>
                <span>|</span><a href="<{$val.url}>"><{$val.title}></a>
            </p>
        </hgroup>
        <{/if}>
        <{/if}>
        <{/foreach}>

        <div class="banner banne_01">
            <!-- 轮播图 -->
            <div id="slider" class="swipe" >
                <div class="swipe-wrap">
                    <{foreach from=$slider item=val key=key}>
                    <div class="banner_item" data-index="" >
                        <a href="<{$val.linkurl}>"><img src="<{$val.imageurl}>" alt="<{$key}>"></a>
                        <div class="opacity_d"></div>
                        <div class="banner_text"><{$val.adsname}></div>
                        <div class="sklo"><span class="ind_nb"><{$key+1}></span>/<span class="all_nb"><{$slider|@count}></span></div>
                    </div>  
                    <{/foreach}>
                </div>
            </div>
        </div>


        <article class="recom newlis harco">
            <{foreach from=$articles_11 item=val key=key}>
            <{if $key >= 6}>
            <a href="<{$val.url}>"><{$val.title}></a>
            <{/if}>
            <{/foreach}>
        </article>

        <div class="area"></div>

        <{if $channel_arry}>
        <{foreach from=$channel_arry item=channel key=key}>
        <{if !empty($channel['art'])}>
        <section>
            <h3 class="tit"><{$channel.catname}></h3>
            <div class="adv">
            </div>
            <article class="recom liscon harco">
                <{foreach from=$channel['art'] key=kk item=article}>
                <{if $kk lt 5}>
                <a href="<{$article.art_base_path}>/<{$article.articleid}>.shtml"><{$article.title}></a>
                <{/if}>
                <{/foreach}>
            </article>
            <a href="<{if $channel.child eq 0}>/<{$channel.catdir}>/<{$channel.catid}>list.shtml <{else}>/<{$channels_url}>/<{$channel.catid}><{/if}>" class="finmo">更多精彩内容 >></a>
            <div class="adv adv_02">
                <!-- 广告 -->
                <{if isset($ads_2) && !empty($ads_2)}>
                    <{$ads_2}>
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
                <{if isset($ads_3) && !empty($ads_3)}>
                     <{$ads_3}>
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
        <!-- 苹果手机 stars -->
        <{include file="footer/apple.html"}>
        <!-- 苹果手机 ends -->
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
    </body>
</html>
