<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><{$metaTitle}></title>
        <meta name="keywords" content="<{$metaKeywords}>" />
        <meta name="description" content="<{$metaDescription}>" />
        <link rel="canonical" href="<{$pc_zhuanti_url}>">
        <meta content="width=device-width,user-scalable=no" name="viewport" />
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/hot.css" />
        <link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/other.css?201608221">
    </head>
    <body>
        <div class="heout"><header><a href="<{$smarty.const.__DOMAINURL__}>" class="lin_01"></a><span>久久专题</span><a href="javascript:void(0)" class="lin_02"></a></header></div>
        <!--弹出 开始-->
        <{include file="navigation/fast_navigation.html"}>
        <!--弹出 结束-->
        <article class="shocu"><a href="<{$smarty.const.__DOMAINURL__}>">久久首页</a>><a href="<{$smarty.const.__DOMAINURL__}>/zhuanti/">久久专题</a></article>

        <!--字母开始-->
        <article class="letbox">
            <div class="lett-tab-con">
                <{if $rand_words}>
                    <{foreach from=$rand_words key=zimu item=words}>
                        <div switc-ass="<{$zimu}>" class="lett-tab-<{$zimu}> hotwords <{if $zimu!="A"}>curro<{/if}>">
                                <{if $words}>
                                    <{foreach from=$words key=k item=word}>
                                         <a href="<{$searchurl}><{$word.pinyin}>/" title="<{$word.keywords}>"><{QLib_Utils_String::cutString($word.keywords, 15,0)}></a>
                                    <{/foreach}>
                                <{else}>
                                    <a>暂无信息</a>
                                <{/if}>
                        </div>
                    <{/foreach}>
                <{/if}>
            </div>
            <div class="letter-switch">
                <{if $letter_list}>
                    <{foreach from=$letter_list key=zimu item=letter}>
                        <a switc="<{$zimu}>" href="" class="currm  <{if $zimu=='A'}>move<{/if}>"><{$zimu}></a>
                    <{/foreach}>
                <{/if}>
            </div>
        </article>
        <!--字母结束-->
        <!--footer 开始-->
        <{include file="footer/zhuanti_footer.html"}>
        <!--footer 结束-->
        <script type="text/javascript" src="<{$smarty.const.__DOMAINURL__}>/scripts/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="<{$smarty.const.__DOMAINURL__}>/scripts/top_nav.js"></script>
        <script>
            $(".currm").click(function (){
                var o=$(this).attr("switc"),t=".lett-tab-"+o;
                $(".move").removeClass("move"),$(this).addClass("move");
                var c=$(".lett-tab-con").find(t);
                $(".lett-tab-con div").addClass("curro"),c&&c.removeClass("curro")
            }).click(function (){
                return!1
            }); 
        </script>
    
	<!-- 百度弹出广告 Start -->
	<{include file="ads/ads_askAnswerDetail_js.html"}>
	<!-- 百度弹出广告 End -->	        
        
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
