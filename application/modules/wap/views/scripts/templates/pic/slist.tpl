<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
    <title><{$curChannel.setting.meta_title}></title>
    <meta name="keywords" content="<{$curChannel.setting.meta_keywords}>" />
    <meta name="description" content="<{$curChannel.setting.meta_description}>" />
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
        <a class="h-pisea" href="<{$curChannel.channel_url}>">图库</a>
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
                    <{if isset($rotationPics) && !empty($rotationPics)}>
                        <{foreach $rotationPics as $key => $rotationPic }>
                            <div class="banner_item" data-index="<{$key}>" >
                                <a href="<{$rotationPic.linkurl}>">
                                    <img src="<{$rotationPic.imageurl}>" alt="<{$rotationPic.adsname}>">
                                </a>
                                <div class="opacity_d"></div>
                                <div class="banner_text"><{$rotationPic.adsname}></div>
                                <div class="sklo">
                                    <span class="ind_nb"><{$key + 1}></span>/
                                    <span class="all_nb"><{count($rotationPics)}></span>
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

       <{if isset($articleDatas.articles) && !empty($articleDatas.articles)}>
           <{foreach $articleDatas.articles as $key => $article}>
               <a href="<{$article.url}>" class="third-news clearfix">
                   <div class="widrso"><img width="140" height="115" src="<{$article.thumb}>" alt="<{$article.title}>" title="<{$article.title}>"></div>
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
                       <{if $key == (count($articleDatas.articles) - 1)}>
                           <{include file="ads/pic_slist_03.tpl"}>
                       <{else}>
                           <{include file="ads/pic_slist_01.tpl"}>
                       <{/if}>
                   </div>
               <{/if}>
           <{/foreach}>
       <{/if}>
    </div>
   <div style=" width:84%; margin:0 auto;">
       <div class="paget clearfix">
           <{$articleDatas.pageHTML}>
       </div>
   </div>
    <!-- 图集部分 End -->

    <section class="floor-item-d">
       <h4>热图推荐</h4>
       <div class="main_visual">
           <{include file="ads/pic_slist_hot_pic.tpl"}>
        </div>
    </section>

    <div class="suneu dtuet">
        <{include file="ads/pic_slist_04.tpl"}>
    </div>

    <a href="javascript:scroll(0,0)" class="retu"></a>

    <!--底部部分 Start-->
    <{include file="footer/pic_footer.html"}>
    <!--底部部分 End-->

    <script src="/scripts/pic_slist.js"></script>

    </body>
    </html>