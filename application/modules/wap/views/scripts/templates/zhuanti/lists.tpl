<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><{$metaTitle}></title>
<meta name="keywords" content="<{$metaKeywords}>" />
<meta name="description" content="<{$metaDescription}>" />
<link rel="canonical" href="<{$pc_zhuanti_search_url}>">
<meta content="width=device-width,user-scalable=no" name="viewport">
<meta name="apple-mobile-web-app-capable" content="yes">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/hot.css?20151218">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/other.css?201608221">
</head>
<body>
   <header><a href="http://m.9939.com/"></a><a href="javascript:">久久专题</a><a href="javascript:" class="personal-btn"></a></header>
       <!--弹出 开始-->
	    <{include file="navigation/fast_navigation.html"}>
       <!--弹出 结束-->
       <div class="breaw"><a href="<{$domainurl}>">久久首页</a>&nbsp;>&nbsp;<a href="<{$searchurl}>">久久专题</a>&nbsp;>&nbsp;<a href="">专题列表</a></div>
      <!--专题 开始-->
      <article class="feature">
          
            <ul class="specnews">
                <{if $articles}>
                    <{foreach from=$articles key=kk item=art}>
                            <{if $kk < 5}>
                                 <li><h2><a href="<{$art.url}>" title="<{$art.title}>"><{$art.title}></a></h2><p>[摘要]<{$art.description}></p></li>
                            <{/if}>
                    <{/foreach}>
                <{/if}>
             
            </ul>
          
                <div class="admos">
                    <script type="text/javascript">
                    /*资讯热搜wap端列表页内容中部*/
                    var cpro_id = "u2452081";
                    </script>
                    <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
                </div>
         <ul class="specnews">
             <{if $articles}>
                <{foreach from=$articles key=kk item=art}>
                    <{if $kk >= 5}>
                        <li><h2><a href="<{$art.url}>" title="<{$art.title}>"><{$art.title}></a></h2><p>[摘要]<{$art.description}></p></li>
                    <{/if}>
                <{/foreach}>
             <{/if}>
          </ul>
                <div class="paget"><a href="<{$prepage}>">上一页</a><span><{$curpage}>/<{$totalpage}></span><a href="<{$nextpage}>"><{if $curpage==$totalpage}>末尾页<{else}>下一页<{/if}></a></div>   
       </article>  
     <!--专题 结束-->
      <article>
        <h1 class="amtit">相关热词</h1>
        <ul class="reahots">
            <{if $relateWords}>
                <{foreach from=$relateWords key=kk item=keyword}>
                <li><a href="<{$searchurl}><{$keyword.pinyin}>/" title="<{$keyword.keywords}>"><{QLib_Utils_String::cutString($keyword.keywords,7,0)}></a></li>
                <{/foreach}>
            <{/if}>
        </ul>
       </article>
        <div class="advim mTop">
            <script type="text/javascript">
            var cpro_id="u2442390";
            (window["cproStyleApi"] = window["cproStyleApi"] || {})[cpro_id]={at:"3",hn:"0",wn:"0",imgRatio:"1.7",scale:"20.12",pat:"6",tn:"template_inlay_all_mobile_lu_native",rss1:"#FFFFFF",adp:"1",ptt:"0",titFF:"%E5%BE%AE%E8%BD%AF%E9%9B%85%E9%BB%91",titFS:"14",rss2:"#000000",titSU:"0",ptbg:"70",ptp:"0"}
            </script>
            <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
        </div>
            <!--footer 开始-->
            <{include file="footer/zhuanti_footer.html"}>
            <!--footer 结束-->
        <script type="text/javascript" src="<{$smarty.const.__DOMAINURL__}>/scripts/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="<{$smarty.const.__DOMAINURL__}>/scripts/top_nav.js"></script>
       
	<!-- 百度弹出广告 Start -->
	<{include file="ads/ads_askAnswerDetail_js.html"}>
	<!-- 百度弹出广告 End -->	       
       
</body>
</html>
