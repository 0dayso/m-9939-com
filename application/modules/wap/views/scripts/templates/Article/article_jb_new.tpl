<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title><{$result.title}></title>
        <meta name="viewport" id="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="applicable-device" content="mobile">
        <meta name="format-detection" content="telephone=no">
        <link rel="canonical" href="<{$pc_article_url}>">
        <link rel="apple-touch-icon" sizes="72x72" href="/images/apple-touch-icon.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/images/apple-touch-icon-retina.png">
        <link rel="stylesheet" type="text/css" href="/css/style.css">
        <link rel="stylesheet" type="text/css" href="/css/other.css?201608221">
        <script type="text/javascript" src="/scripts/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="/scripts/detail.js"></script>
        <script type="text/javascript" src="/scripts/jquery.event.drag-1.5.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery.touchSlider.js"></script>
        <script type="text/javascript" src="/scripts/slide.js"></script>
        <script type="text/javascript" src="/scripts/top_nav.js"></script>
    </head>
    <body>
        <!--左上角弹出层-->
        <{include file="navigation/fast_navigation.html"}>
        <div class="heout">
            <header>
                <a href="" class="lin_01 lin_04"></a><span>久久<{$catdir.parentdir_name}></span>
                <a href="javascript:void(0)"  class="lin_02 popup"></a>
            </header>
        </div>
        <article class="shocu artin">
            <a href="<{$smarty.const.__DOMAINURL__}>">首页</a>&gt;<a href="/<{$catdir.parentdir_url}>/"><{$catdir.parentdir_name}></a>&gt;<a href="">正文</a>
        </article>

        <article class="artbo">
            <h1><{$result.title}></h1>
            <div class="clich">
                <div class="tranf">
                    <a class="curre">A<sup>-</sup></a><a>A<sup>+</sup></a>
                </div>
                <span><{$result.inputtime}></span>
                <span><{$result.copyfrom}></span>
            </div>

            <!-- 广告 -->
            <!--6.2新增-->
            
            <!-- 广告 -->

            <div class="bocon">
                <div class="minbo">
                    <div class="wind">
                        <{if $result.description neq ""}><p style="text-indent:40px;"><{$result.description|strip:" "}></p><{/if}>
                        <{$result.content}>
                    </div>
                </div>
                <a class="loada"><b>加载全文</b><span class="lodo"></span></a>
            </div>
        </article>

        <!--分享 start-->
        <div class="bdsharebuttonbox">
            <a href="#" class="bds_more" id="sha_a" data-cmd="more"></a>
            <a href="#" class="bds_tsina" id="sh_01" data-cmd="tsina" title="分享到新浪微博"></a>
            <a href="#" id="sh_02" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
            <a href="#" id="sh_03" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
            <a id="sh_04" href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
            <a href="#" id="sh_05" class="bds_mshare" data-cmd="mshare" title="分享到一键分享"></a>
        </div>
        <script>
            window._bd_share_config = {
                "common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"32"}, "share":{}};
            with (document)
                0[(getElementsByTagName('head')[0] || body).appendChild(
                        createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];
        </script>
        <!--分享 end-->

        <article class="capti">
            <{if !empty($article_last)}>
            <a href="<{$article_last.url}>"><span>上一篇：</span><{$article_last.title}></a>
            <{/if}>
            <{if !empty($article_next)}>
            <a href="<{$article_next.url}>"><span>下一篇：</span><{$article_next.title}></a>
            <{/if}>
        </article>

        <div class="adv ad_co">
            <!--插入广告位-->
            <img src="/images/adv_01.jpg">
            <img src="/images/adv_01.jpg">
        </div>

        <div class="area"></div>
        <article class="hoimg">
            <h3>精彩推荐</h3>
            <!-- 相关文章 -->
            <article class="recom unili">
                <{if $article}>
                <{foreach from=$article item=arts}>
                <a href="<{$arts.art_base_path}>/<{$arts.articleid}>.shtml">
                    <p><{$arts.title|strip:" "|truncate:17:"...":true}></p>
                    <p><{$arts.description|strip:" "|truncate:20:"...":true}></p>
                </a>
                <{/foreach}>
                <{/if}>
            </article>
        </article>

        <div class="adv ad_co">
            <!-- 广告 -->
            <ul class="d-durse nesty clearfix">
                <li>        
                    <div class="louts"><a href=""><img src="/images/adpl.jpg"  alt="" title=""></a><span>华语红毯女明星都逆</span></div>
                    <div class="louts"><a href=""><img src="/images/adpl.jpg"  alt="" title=""></a><span>华语红毯女明星都逆生</span></div>     
                </li>
            </ul>
        </div>

        <div class="area"></div>
        <article class="hoimg"><h3>相关推荐</h3></article>
        <div class="adv ad_co">
            <!--插入广告位-->
            <img src="/images/adv_06.jpg">
        </div>


        <div class="area"></div>
        <article class="hoimg">
            <h3>相关问答</h3>	
            <article class="recom unili nres dropf">
               


            </article>
            <a href="http://wapask.9939.com/ask/goAskDoctor" class="faque">快速提问</a>
        </article>


        <div class="area"></div>
        <!--first area-->
        <section>
            <h3 class="coclu"><a class="custt">新闻</a><a>两性</a><a>偏方</a><a>减肥</a></h3>
            <{foreach from = $fourCateArt key=kk  item = catArt}>
            <{if $kk == 0}>
            <section class="news_01 ">
                <{else}>
                <section class="news_01 disn">
                    <{/if}>
                    <article class="recom liscon harco">
                        <{foreach from=$catArt.article item = art}>
                            <a href="<{$art.url}>"><{$art.title}></a>
                        <{/foreach}>
                    </article>
                    <a href="<{$catArt.url}>" class="finmo">进入<{$catArt.catname}>频道 >></a>
                </section>
                <{/foreach}>
                <div class="area"></div>
            </section>


            <!--second area-->
            <article class="hoimg">
                <h3>健康助手</h3>	
                <div class="meth">
                    <a href="http://wapask.9939.com/ask/goAskDoctor"><p></p><p>问医生</p></a><a href="/jb/"><p></p><p>查疾病</p></a><a href=""><p></p><p>找医院</p></a><a href="/drug/"><p></p><p>找药品</p></a>
                </div>

                <div class="fali">
                    <a href="">男人雄起</a><a href="">保健男人</a><a href="">男人雄起</a><a href="">保健男人</a><a href="">男人雄起</a><a href="">保健男人</a><a href="">男人雄起</a><a href="">保健男人</a>
                </div>

                <!-- 搜索 start -->
                <form action="http://sousuo.9939.com/cse/search" method="get" class="frmal">
                    <input type="search" name="q" placeholder="搜索您感兴趣的内容">
                    <input type="hidden" value="2200337477999120096" name="s">
                    <input type="submit" value="">
                </form>
                <!-- 搜索 end -->
            </article>
            <div class="area"></div>
            <!-- 聚合阅读 stars -->
            <{include file="footer/reading_footer.html"}>
            <!-- 聚合阅读 ends -->

            <!-- footer stars -->
            <{include file="footer/footer.html"}>
            <!-- footer ends -->
    </body>
</html>
