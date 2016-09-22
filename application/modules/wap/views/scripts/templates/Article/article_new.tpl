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
                <a href="/<{$catdir.parentdir_url}>/" class="lin_01 lin_04"></a><span>久久<{$catdir.parentdir_name}></span>
                <a href="javascript:void(0)"  class="lin_02 popup"></a>
            </header>
        </div>
        <article class="shocu artin">
            <a href="<{$smarty.const.__DOMAINURL__}>">首页</a>&gt;<a href="/<{$catdir.parentdir_url}>/"><{$catdir.parentdir_name}></a>&gt;<a href="/<{$catdir.parentdir_url}>/<{$catdir.catid}>"><{$catdir.catdir_name}></a>&gt;<a href="">正文</a>
        </article>

        <article class="artbo">
            <h1><{$result.title}></h1>
            <div class="clich">
                <div class="tranf">
                    <a>A<sup>+</sup></a>
                </div>
                <span><{$result.inputtime}></span>
                <span><{$result.copyfrom}></span>
            </div>

                <!-- 广告 -->
                <div class="adv">
                    <{if isset($ads_1) && !empty($ads_1)}>
                     <{$ads_1}>
                    <{/if}>
                </div>
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
        <!-- 两性文章 广告 start  -->
        <{if isset($ads_lx) && !empty($ads_lx)}>
            <{$ads_lx}>
        <{/if}>
        <!-- 两性文章 广告  end   -->
        <!--分享 start-->
        <div class="shaco"><b>分享</b>
            <ul class="cola">
                <li onclick="share('wechatfriends');"><div></div><p>微信好友</p></li>
                <li onclick="share('wechatcircle');"><div></div><p>微信朋友圈</p></li>
                <li onclick="share('sina');"><div></div><p>新浪微博</p></li>
                <li onclick="share('oicq');"><div></div><p>腾讯QQ</p></li>
            </ul>
            <div display='none'>
                <!-- 微信好友 -->
                <a id="wechatfriends" href="http://qr.liantu.com/api.php?text=<{$smarty.const.__DOMAINURL__}><{$article_url}>" data-url='<{$smarty.const.__DOMAINURL__}><{$article_url}>' data-text="<{$result.title}>" ></a>
                <!-- 朋友圈 -->
                <a id="wechatcircle" href="http://qr.liantu.com/api.php?text=<{$smarty.const.__DOMAINURL__}><{$article_url}>" data-url='<{$smarty.const.__DOMAINURL__}><{$article_url}>' data-text="<{$result.title}>" ></a>
                <!-- 新浪 -->
                <a id="sina" href="http://service.weibo.com/share/share.php?title=<{$result.title}>&url=<{$smarty.const.__DOMAINURL__}><{$article_url}>&pic="
                   data-url='<{$article_url}>' data-text="<{$result.title}>" ></a>
                <!-- 空间 -->
                <a id="oicq" href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<{$smarty.const.__DOMAINURL__}><{$article_url}>"
               data-url='<{$smarty.const.__DOMAINURL__}><{$article_url}>' data-text="<{$result.title}>" ></a>
                   <script type="text/javascript">
                        function share($clickid){
                            var obj = document.getElementById($clickid).click();
                        }
                   </script>
            </div>
        </div>
        <!--分享 end-->

        <article class="capti">
            <{if !empty($article_last)}>
            <a href="<{$article_last.url}>"><span>上一篇：</span><{$article_last.title}></a>
            <{/if}>
            <{if !empty($article_next)}>
            <a href="<{$article_next.url}>"><span>下一篇：</span><{$article_next.title}></a>
            <{/if}>
        </article>
        <!--插入广告位-->
        <{if isset($ads_2) && !empty($ads_2)}>
            <div class="adv ad_co">
                <{$ads_2}>

            </div>
        <{/if}>
        <!--插入广告位-->
        <{if isset($ads_4542) && !empty($ads_4542)}>
            <div class="adv ad_co">
                    <{$ads_4542}>
            </div>
        <{/if}>
        <div class="area"></div>
        <article class="hoimg">
            <h3>精彩推荐</h3>
            <!-- 相关文章 -->
            <article class="recom unili conart">
                <{if $article}>
                <{foreach from=$article item=arts}>
                <a href="<{$arts.art_base_path}>/<{$arts.articleid}>.shtml">
                    <p><{$arts.title|strip:" "}></p>
                    <p><{$arts.description|strip:" "}></p>
                </a>
                <{/foreach}>
                <{/if}>
                <a>
                    <{if isset($ads_3) && !empty($ads_3)}>
                        <{$ads_3}>
                    <{/if}>
                </a>
            </article>
        </article>

        <div class="area"></div>
        <article class="hoimg"><h3>相关推荐</h3></article>
        <div class="adv ad_co">
            <!--插入广告位-->
            <script type="text/javascript">
                (function(){
                    document.write(unescape('%3Cdiv id="bdcsFrameTitleBox"%3E%3C/div%3E'));
                    var bdcs = document.createElement("script");
                    bdcs.type = "text/javascript";
                    bdcs.async = true;
                    bdcs.src = "http://znsv.baidu.com/customer_search/api/rs?sid=2200337477999120096" + "&plate_url=" + encodeURIComponent(window.location.href) + "&t=" + Math.ceil(new Date()/3600000) + "&type=3";
                    var s = document.getElementsByTagName("script")[0];
                    s.parentNode.insertBefore(bdcs, s);})();
            </script>
        </div>

        <{if isset($ads_4) && !empty($ads_4)}>
            <{$ads_4}>
        <{/if}>
        <div class="area"></div>
        <article class="hoimg">
            <{if !empty($askAndAnswerArr)}>
                <h3>相关问答</h3>	
                <article class="recom unili nres dropf">
                    <{foreach from=$askAndAnswerArr item=val key=key}>
                    <a href="http://wapask.9939.com/id/<{$val.ask.id}>.html">
                        <p><b><span>Q</span>：</b><{$val.ask.title|strip:" "}></p>
                        <p><b><span>A</span>：</b><{if isset($val.answer.content) && mb_strlen($val.answer.content) > 10}><{$val.answer.content|strip:" "}><{else}><{$val.answer.suggest|strip:" "}><{/if}></p>
                    </a>
                    <{/foreach}>


                </article>
            <{/if}>
            <a href="http://wapask.9939.com/ask/goAskDoctor" class="faque">快速提问</a>
        </article>

                <{if isset($ads_4541) && !empty($ads_4541)}>
                    <{$ads_4541}>
                <{/if}>
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
                    <script type="text/javascript">
                        /*久久健康网移动端频道首页底部广告*/
                        var cpro_id = "u2581809";
                    </script>
                    <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
                    <div id="BAIDU_SSP__wrapper_u2581809_0" style="box-sizing: content-box; text-align: center; display: block; font-size: 0px; width: 100%; height: 94px;">
                        <div style="box-sizing: content-box;width:375px;height:94px;position:relative;margin:0 auto;">
                            <iframe id="iframeu2581809_0" src="http://pos.baidu.com/scbm?sz=375x94&amp;rdid=2581809&amp;dc=2&amp;exps=113010&amp;di=u2581809&amp;dri=0&amp;dis=0&amp;dai=14&amp;ps=5766x0&amp;dcb=BAIDU_SSP_define&amp;dtm=HTML_POST&amp;dvi=0.0&amp;dci=-1&amp;dpt=none&amp;tsr=0&amp;tpr=1471591600907&amp;ti=%E8%82%B2%E5%84%BF%E7%9F%A5%E8%AF%86%E5%A4%A7%E5%85%A8_%E6%AF%8D%E5%A9%B4%E7%9F%A5%E8%AF%86_%E4%BA%B2%E5%AD%90%E8%82%B2%E5%84%BF%E7%BD%91_%E4%B9%85%E4%B9%85%E5%81%A5%E5%BA%B7%E6%AF%8D%E5%A9%B4%E9%A2%91%E9%81%93baby.9939.com&amp;ari=2&amp;dbv=0&amp;drs=1&amp;pcs=375x627&amp;pss=375x5766&amp;cfv=0&amp;cpl=0&amp;chi=4&amp;cce=true&amp;cec=UTF-8&amp;tlm=1471591601&amp;rw=375&amp;ltu=http%3A%2F%2Fm.9939.com%2Fbaby%2F&amp;ltr=http%3A%2F%2Fm.9939.com%2F&amp;ecd=1&amp;psr=375x627&amp;par=375x627&amp;pis=-1x-1&amp;ccd=24&amp;cja=false&amp;cmi=0&amp;col=zh-CN&amp;cdo=-1&amp;tcn=1471591601&amp;qn=811813305360d6c5&amp;tt=1471591600884.303.5481.5482" width="375" height="94" align="center,center" vspace="0" hspace="0" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" style="border:0; vertical-align:bottom;margin:0;" allowtransparency="true"></iframe>
                        </div>
                    </div>

                </div>
            </article>

            <!--second area-->
            <article class="hoimg">
                <h3>健康助手</h3>	
                <div class="meth">
                    <a href="http://wapask.9939.com/ask/goAskDoctor"><p></p><p>问医生</p></a><a href="http://m.jb.9939.com/"><p></p><p>查疾病</p></a><a href=""><p></p><p>找医院</p></a><a href="/drug/"><p></p><p>找药品</p></a>
                </div>

                <div class="fali">
                    <{if isset($ads_zhushou) && !empty($ads_zhushou)}>
                        <{foreach from=$ads_zhushou item=val key=key}><a href="<{$val.linkurl}>"><{$val.adsname}></a><{/foreach}>
                    <{/if}>
                    
                </div>

                <!-- 搜索 start -->
               
                
                <form action="http://sousuo.9939.com/cse/search" method="get" class="frmal">
                    <input type="search" name="q" placeholder="搜索您感兴趣的内容">
                    <input type="hidden" value="2200337477999120096" name="s">
                    <input type="submit" value="">
                </form>
                    <!--<script type="text/javascript">
                        (function(){
                            document.write(unescape('%3Cdiv id="bdcs"%3E%3C/div%3E'));
                            var bdcs = document.createElement('script');
                            bdcs.type = 'text/javascript';
                            bdcs.async = true;
                            bdcs.src = 'http://znsv.baidu.com/customer_search/api/js?sid=2200337477999120096' + '&plate_url=' + encodeURIComponent(window.location.href) + '&t=' + Math.ceil(new Date()/3600000);
                            var s = document.getElementsByTagName('script')[0];
                            s.parentNode.insertBefore(bdcs, s);})();
                    </script>-->
                <!-- 搜索 end -->
            </article>
            <div class="area"></div>
            <{if isset($ads_foot) && !empty($ads_foot)}>
                <{$ads_foot}>
            <{/if}>
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
    </body>
</html>
