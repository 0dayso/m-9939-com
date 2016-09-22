<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
    <title><{$curChannel.setting.meta_title}></title>
    <meta name="keywords" content="<{$curChannel.setting.meta_keywords}>" />
    <meta name="description" content="<{$curChannel.setting.meta_description}>" />
    <link rel="canonical" href="<{$pc_url}>">
    <meta name="viewport" id="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="applicable-device"content="mobile">
    <meta name="format-detection" content="telephone=no">

    <link rel="apple-touch-icon" sizes="72x72" href="/images/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/images/apple-touch-icon-retina.png">
    <link  href="/css/photo.css" rel="stylesheet">

    <script type="text/javascript" src="/scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/scripts/zepto.min.js"></script>
    <script type="text/javascript" src="/scripts/swipe.min.js"></script>
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
    <header class="mlier herdt-1">
        <a href="http://m.9939.com/"></a>
        <a href="javascript:">久久图库</a>
        <a href="javascript:" class="personal-btn lin_02"></a>
    </header>

	<!-- 导航 -->
    <div class="nav">
     <ul class="morut">
     		<li><a href="/pic/lxtp/" title="两性图谱">两性图谱</a></li>
            <li><a href="/pic/nrsj/" title="男人视觉">男人视觉</a></li>
            <li><a href="/pic/mrtc/" title="美容图潮">美容图潮</a></li>
            <li><a href="/pic/yytm/" title="孕育探秘">孕育探秘</a></li>
    </ul>
    <span id="toggle">
        <a class="togglemore" href="javascript:void(0)"></a>
        <a class="togglesingle" href="javascript:void(0)"></a>
    </span>
      <ul class="navmore" style="display:none;">
            <li><a href="/pic/ssnx/" title="时尚女性">时尚女性</a></li>
            <li><a href="/pic/yxzl/" title="医学纵览">医学纵览</a></li>
            <li><a href="/pic/btsj/" title="病态视角">病态视角</a></li>
            <li><a href="/pic/zytl/" title="中药图林">中药图林</a></li>
            <li><a href="/pic/stbw/" title="身体部位">身体部位</a></li>
            <li><a href="/pic/bjtk/" title="保健图库">保健图库</a></li>
            <li><a href="/pic/tssj/" title="图说视界">图说视界</a></li>
       </ul>
    </div>

	<!--焦点图-->
       <div class="banner">
           <div id="slider" class="swipe" >
               <div class="swipe-wrap">
                   <{if isset($rotationPics) && !empty($rotationPics)}>
                       <{foreach $rotationPics as $key => $rotationPic }>
                           <div class="banner_item" data-index="<{$key}>" >
                               <a href="<{$rotationPic.linkurl}>" title="<{$rotationPic.adsname}>" >
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

        <!-- 精彩热图 Start -->
         <div class="floor-item">
           <h4>精彩热图</h4>
             <{if isset($hotPics) && !empty($hotPics)}>
                <{foreach $hotPics as $key => $hotPic}>
                    <{if $key == 0}>
                        <a  href="<{$hotPic.url}>" class="dmied" title="<{$hotPic.title}>">
                            <div style = "width:100%;height:176px;background:url(<{$hotPic.thumb}>) center;background-size:cover;background-repeat:no-repeat;"></div>
                           <{* <img src="<{$hotPic.thumb}>" alt="<{$hotPic.title}>" title="<{$hotPic.title}>" width="321" height="176">*}>
                            <div class="dir-tit sire clearfix">
                                <h5><{$hotPic.title}></h5>
                                <span class="dir-num">
                                    <i class="picsr"><img src="/images/pic3.png" alt="" title=""></i>
                                    <i class="siernum"><{$hotPic.thumb_count}></i>
                                </span>
                            </div>
                        </a>

                        <{else}>
                        <div class="posur-idr">
                            <div class="phoret clearfix">
                                <div class="siud-one mdtr fl">
                                    <a href="<{$hotPic.url}>">
                                        <img width="139" height="114" src="<{if isset($hotPic.attachment[0])}><{$hotPic.attachment[0].url}><{/if}>" alt="<{$hotPic.title}>" title="<{$hotPic.title}>">
                                    </a>
                                    <a href="<{$hotPic.url}>">
                                        <img width="139" height="114" src="<{if isset($hotPic.attachment[1])}><{$hotPic.attachment[1].url}><{/if}>" alt="<{$hotPic.title}>" title="<{$hotPic.title}>">
                                    </a>
                                </div>
                                <div  class="siud-two fl">
                                    <a href="<{$hotPic.url}>">
                                        <img  width="164" height="233" src="<{if isset($hotPic.attachment[2])}><{$hotPic.attachment[2].url}><{/if}>" alt="<{$hotPic.title}>" title="<{$hotPic.title}>">
                                    </a>
                                </div>
                            </div>
                            <a href="<{$hotPic.url}>" title="<{$hotPic.title}>">
                                <div class="dir-tit clearfix">
                                    <h5><{$hotPic.title}></h5>
                                    <span class="dir-num">
                                        <i class="picsr"><img src="/images/pic3.png" alt="" title=""></i>
                                        <i class="siernum"><{$hotPic.thumb_count}></i>
                                    </span>
                                </div>
                            </a>
                        </div>
                    <{/if}>
                <{/foreach}>
             <{/if}>
            <div class="suneu"><{include file="ads/pic_index_01.tpl"}></div>
         </div>
        <!-- 精彩热图 End -->

       <!-- 子集文章集 Start -->
        <{if isset($subChannelArts) && !empty($subChannelArts)}>
            <{foreach $subChannelArts as $subChannelArt}>
                <{if $subChannelArt.catname != '健康图谱广告位'}>
                    <{if isset($subChannelArt.articles) && !empty($subChannelArt.articles)}>
                        <div class="backd"></div>
                        <div class="floor-item">
                            <h4><{$subChannelArt.catname}></h4>
                                <a  href="<{$subChannelArt.articles[0].url}>" class="dmied">
                                    <div style = "width:100%;height:176px;background:url(<{$subChannelArt.articles[0].thumb}>) center;background-size:cover;background-repeat:no-repeat;"></div>
                                    <{*<img width="321" height="176" src="<{$subChannelArt.articles[0].thumb}>" alt="<{$subChannelArt.articles[0].title}>">*}>
                                    <div class="dir-tit sire clearfix">
                                        <h5><{$subChannelArt.articles[0].title}></h5>
                                    <span class="dir-num">
                                        <i class="picsr"><img src="/images/pic3.png" alt="" title=""></i>
                                        <i class="siernum"><{$subChannelArt.articles[0].thumb_count}></i>
                                    </span>
                                    </div>
                                </a>
                                <{foreach $subChannelArt.articles as $akey => $article}>
                                    <{if $akey != 0}>
                                        <a href="<{$article.url}>" class="third-news clearfix">
                                            <div class="widrso"><img width="140" height="115" src="<{$article.thumb}>" alt="<{$article.title}>" title="<{$article.title}>"></div>
                                            <p class="qrimr"><{$article.title}></p>
                                            <p class="qrimr2">
                                                <i class="ritime"><{$article.date}></i>
                                        <span class="dir-fr">
                                            <i class="picsr"><img src="/images/pic3.png" alt="" title=""></i>
                                            <i class="siernum"><{$article.thumb_count}></i>
                                        </span>
                                            </p>
                                        </a>
                                    <{/if}>
                                <{/foreach}>
                            <p class="ld-morder"><a href="<{$subChannelArt.moreurl}>">更多精彩内容>></a></p>
                            <div class="suneu"><{include file="ads/pic_index_02.tpl"}></div>
                        </div>
                    <{/if}>
                <{/if}>
            <{/foreach}>
        <{/if}>
       <!-- 子集文章集 End -->

     <div class="suneu"><{include file="ads/pic_index_03.tpl"}></div>

    <a href="javascript:scroll(0,0)" class="retu"></a>

    <!--底部部分 Start-->
    <{include file="footer/pic_footer.html"}>
    <!--底部部分 End-->

    <script src="/scripts/pic_index.js"></script>

    </body>
    </html>
	