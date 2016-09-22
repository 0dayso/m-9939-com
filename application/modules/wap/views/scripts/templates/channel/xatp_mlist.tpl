<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
    <title><{$setting.meta_title}></title>
    <meta name="keywords" content="<{$setting.meta_keywords}>" />
    <meta name="description" content="<{$setting.meta_description}>" />
    <link rel="canonical" href="<{$pc_url}>">
    <meta name="applicable-device"content="mobile">
	<meta name="360-site-verification" content="a8851659e6a3f7c7cd850299285550ff">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no" id="viewport">

    <link  href="/css/photo.css" rel="stylesheet">

    <script type="text/javascript" src="/scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/scripts/zepto.min.js"></script>
    <script type="text/javascript" src="/scripts/swipe.min.js"></script>
    <script src="/scripts/gundong.js"></script>
    <script type="text/javascript" src="/scripts/jquery.touchSlider.js"></script>
    <script type="text/javascript" src="/scripts/slide.js"></script>
    <script type="text/javascript" src="/scripts/topnav.js"></script>

    <!-- 反屏蔽广告代码 -->
    <script>
        (window._ssp_global = window._ssp_global || {}).userConfig = {
            domain: "mjs.9939.com"
        }
    </script>
</head>
<body>
	<!-- 页头 -->
    <header class="mlier herdt-2">
        <a href="http://m.9939.com/"></a><span></span>
        <a class="h-pisea" href="/lx/">两性</a>
        <a href="javascript:"><{$channels}></a>
        <a href="javascript:" class="personal-btn lin_02"></a>
    </header>

	<!-- 导航 -->
    <nav class="brdear">
        <a href="http://m.9939.com/">首页</a> &gt;

        <!-- 父级信息导航部分 Start -->
        <{if isset($curChannel.parent) && !empty($curChannel.parent) }>
            <{foreach $curChannel.parent as $parent }>
                <a href="<{$parent.url}>" title="<{$parent.catname}>"><{$parent.catname}></a> >
            <{/foreach}>
        <{/if}>
        <!-- 父级信息导航部分 End -->
        <a href="<{$curChannel.url}>" class="swtab" title="<{$curChannel.catname}>"><{$curChannel.catname}></a>
    </nav>

	<!--焦点图-->
	<div class="banner">
	     	<div id="slider" class="swipe" >
              <div class="swipe-wrap">
              	    <{if isset($slider) && !empty($slider) }>
                        <{foreach $slider as $key => $rotationPic }>
                            <div class="banner_item" data-index="<{$key}>" >
                                <a href="<{$rotationPic.linkurl}>">
                                    <img src="<{$rotationPic.imageurl}>" alt="<{$rotationPic.adsname}>">
                                </a>
                                <div class="opacity_d"></div>
                                <div class="banner_text"><{$rotationPic.adsname}></div>
                                <div class="sklo">
                                    <span class="ind_nb"><{$key + 1}></span>/<span class="all_nb"><{count($slider)}></span>
                                </div>
                            </div>
                        <{/foreach}>
              	    <{/if}>
              </div>
        </div>
    </div>

    <!-- 子栏目文章集 Start -->
    <{if isset($section) && !empty($section)}>
        <{foreach $section as $outerKey => $subChannelArt}>
            <{if isset($subChannelArt.art) && !empty($subChannelArt.art)}>
                <{if $outerKey != 0}>
                    <div class="backd"></div>
                <{/if}>

                <div class="floor-item">
                    <h4><{$subChannelArt.cat.catname}></h4>
                    <{foreach $subChannelArt.art as $key => $article}>
                        <a href="<{$article.url}>" class="third-news clearfix">
                            <div class="widrso">
                                <{$article.thumb}>
                            </div>
                            <p class="qrimr"><{$article.title}></p>
                            <p class="qrimr2">
                                <i class="ritime"><{$article.date}></i>
                        <span class="dir-fr">
                            <i class="picsr"><img src="/images/pic3.png"></i>
                            <i class="siernum"><{$article.thumb_count}></i>
                        </span>
                            </p>
                        </a>
                    <{/foreach}>
                    <p class="ld-morder"><a href="<{$subChannelArt.moreurl}>">更多精彩内容>></a></p>

                    <div class="suneu">
                        <{if isset($ads_1) && !empty($ads_1)}>
                            <{$ads_1}>
                        <{/if}>
                    </div>
                </div>
            <{/if}>
        <{/foreach}>
    <{/if}>
    <!-- 子栏目文章集 End -->

    <!-- 热图推荐 Start -->
    <section class="floor-item-d">
       <h4>热图推荐</h4>
        <div class="main_visual">
            <{include file="ads/xatp_mlist_hot_pic.tpl"}>
        </div>
        <div class="suneu dtuet">
            <{if isset($ads_2) && !empty($ads_2)}>
                <{$ads_2}>
            <{/if}>
        </div>
    </section>
    <!-- 热图推荐 End -->

    <a href="javascript:scroll(0,0)" class="retu"></a>

    <!--底部部分 Start-->
    <{include file="footer/pic_footer.html"}>
    <!--底部部分 End-->
    <!-- ads-quan stars -->
    <{if isset($ads_quan) && !empty($ads_quan)}>
        <{$ads_quan}>
    <{/if}>
    <!-- ads-quan ends -->
    <script src="/scripts/pic_mlist.js"></script>
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
	