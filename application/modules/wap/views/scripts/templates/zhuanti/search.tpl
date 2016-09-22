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
      <div class="breaw homd"><a href="<{$smarty.const.__DOMAINURL__}>">久久首页</a>&nbsp;>&nbsp;<a href="<{$smarty.const.__DOMAINURL__}>/zhuanti/">久久专题</a>&nbsp;>&nbsp;<a href="">内容</a></div>
      <!--专题内容 开始-->
      <section class="file">
            <h3 class="projec">久久专题</h3>
            <div class="lertit">关于<h1><{QLib_Utils_String::cutString($search_name, 9,0)}></h1>专题</div>
      </section>
      <article>
          <div>
              <script type="text/javascript">
                var cpro_id="u2545540";
                (window["cproStyleApi"] = window["cproStyleApi"] || {})[cpro_id]={at:"3",hn:"0",wn:"0",imgRatio:"1.7",scale:"20.6",pat:"6",tn:"template_inlay_all_mobile_lu_native",rss1:"#FFFFFF",adp:"1",ptt:"0",titFF:"%E5%BE%AE%E8%BD%AF%E9%9B%85%E9%BB%91",titFS:"14",rss2:"#000000",titSU:"0",ptbg:"70",ptp:"0"}
                </script>
              <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>

          </div>
          <ul class="newsde">
              <{if $articles_one}>
                <{foreach from=$articles_one  key=kk item=art}>
                        <{if $kk%3 == 0}>
                        <li><h3><a href="<{$art.url}>" title="<{$art.title}>"><{QLib_Utils_String::cutString($art.title, 12,0)}></a></h3><div>
                        <{elseif $kk%3 == 2}>
                            <a href="<{$art.url}>" title="<{$art.title}>"><{QLib_Utils_String::cutString($art.title, 8,0)}></a></div></li>
                        <{else}>
                            <a href="<{$art.url}>" title="<{$art.title}>"><{QLib_Utils_String::cutString($art.title, 8,0)}></a>
                        <{/if}>
                <{/foreach}>
              <{/if}>
              
            </ul>
              <{if $articles_pic}>
                <{foreach from=$articles_pic  key=kk item=art}>
              <div class="mspio"><div class="olps"><a href="<{$art.url}>"  title="<{$art.title}>"><img  src="<{$smarty.const.__DOMAINURL__}>/images/zxpic.jpg"  alt="<{$art.title}>" title="<{$art.title}>"/></a></div><span><a href="<{$art.url}>" ><{QLib_Utils_String::cutString($art.title, 15,0)}></a></span></div>
               <{/foreach}>
              <{/if}>
      </article>
      <article class="feature">
         <ul class="recomd">
             <{if $articles_two}>
                <{foreach from=$articles_two key=kk item=art}>
                    <{if $kk <= 1}>
                        <li><b>推荐</b><a href="<{$art.url}>" title="<{$art.title}>"><{QLib_Utils_String::cutString($art.title, 14,0)}></a></li>
                     <{elseif $kk == 3}>
                        <li><b class="boms">HOT</b><a href="<{$art.url}>" title="<{$art.title}>"><{QLib_Utils_String::cutString($art.title, 14,0)}></a></li>
                     <{else}>
                        <li><a href="<{$art.url}>" title="<{$art.title}>"><{QLib_Utils_String::cutString($art.title, 14,0)}></a></li>
                    <{/if}>
                <{/foreach}>
             <{/if}>
         </ul>
         <div class="admos">
             <script type="text/javascript">
             /*资讯热搜wap端内容页更多上方*/
             var cpro_id = "u2452096";
             </script>
             <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
         </div>
         <{if count($articles_three) > 0}>
            <p class="desmore"></p>
         <{/if}>
         <ul class="specnews borde">
             <{if $articles_three}>
                <{foreach from=$articles_three key=kk item=art}>
                        <li><h2><a href="<{$art.url}>"  title="<{$art.title}>"><{$art.title}></a></h2><p>[摘要]<{$art.description}></p></li>
                <{/foreach}>
             <{/if}>
          </ul>
          <{if $total > 18}>
            <div class="viewmore"><a href="<{$searchurl}><{$search}>/1/">查看更多</a></div>   
          <{/if}>
       </article>  
     <!--专题 结束-->
      <article>
        <h1 class="amtit">相关热词</h1>
        <ul class="reahots">
            <{if $relateWords}>
                <{foreach from=$relateWords key=kk item=keyword}>
                <li><a href="<{$searchurl}><{$keyword.pinyin}>/"  title="<{$keyword.keywords}>"><{QLib_Utils_String::cutString($keyword.keywords,7,0)}></a></li>
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
