<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    <script src="/scripts/page.js"></script>
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

<body class="clor-1">
	<!-- 页头 -->
    <header class="mlier herdt-2">
        <a href="http://m.9939.com/"></a>
        <a class="h-pisea" href="/lx/">两性</a>
        <a href="javascript:"><{$curChannel.catname}></a>
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
    <{if $page == 1}>
        <div class="banner">
            <div id="slider" class="swipe" >
                <div class="swipe-wrap">
                    <{if isset($slider) && !empty($slider)}>
                        <{foreach $slider as $key => $rotationPic }>
                            <div class="banner_item" data-index="<{$key}>" >
                                <a href="<{$rotationPic.linkurl}>">
                                    <img src="<{$rotationPic.imageurl}>" alt="<{$rotationPic.adsname}>">
                                </a>
                                <div class="opacity_d"></div>
                                <div class="banner_text"><{$rotationPic.adsname}></div>
                                <div class="sklo">
                                    <span class="ind_nb"><{$key + 1}></span>/
                                    <span class="all_nb"><{count($slider)}></span>
                                </div>
                            </div>
                        <{/foreach}>
                    <{/if}>
                </div>
            </div>
        </div>
    <{/if}>

    <!-- 图集部分 Start -->
   <div class="floor-item">
       <{if $page == 1}>
           <h4><{$curChannel.catname}></h4>
       <{/if}>

       <{if isset($article_arry) && !empty($article_arry)}>
           <{foreach $article_arry as $key => $article}>
               <a href="<{$article.url}>" class="third-news clearfix">
                   <div class="widrso"><{$article.thumb}></div>
                   <p class="qrimr"><{$article.title}></p>
                   <p class="qrimr2">
                       <i class="ritime"><{$article.date}></i>
                       <span class="dir-fr">
                           <i class="picsr">
                               <img src="/images/pic3.png">
                           </i>
                           <i class="siernum"><{$article.thumb_count}></i>
                       </span>
                   </p>
               </a>

               <{if $key % 4 == 3 }>
                   <div class="suneu dtuet">
                       <{if $key == (count($article_arry) - 1)}>
                           <{$ads_4}>
                       <{else}>
                           <{$ads_1}>
                       <{/if}>
                   </div>
               <{/if}>
           <{/foreach}>
       <{/if}>
    </div>
   <div style=" width:84%; margin:0 auto;">
       <div class="paget clearfix">
           <{$page_html}>
       </div>
   </div>
    <!-- 图集部分 End -->

    <section class="floor-item-d">
       <h4>热图推荐</h4>
       <div class="main_visual">
           <{include file="ads/xatp_slist_hot_pic.tpl"}>
        </div>
    </section>

    <div class="suneu dtuet">
        <{if isset($ads_5) && !empty($ads_5)}>
            <{$ads_5}>
        <{/if}>
    </div>

    <a href="javascript:scroll(0,0)" class="retu"></a>

    <!--底部部分 Start-->
    <{include file="footer/pic_footer.html"}>
    <!--底部部分 End-->
    <!-- ads-quan stars -->
    <{if isset($ads_quan) && !empty($ads_quan)}>
        <{$ads_quan}>
    <{/if}>
    <!-- ads-quan ends -->
    <script src="/scripts/pic_slist.js"></script>
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