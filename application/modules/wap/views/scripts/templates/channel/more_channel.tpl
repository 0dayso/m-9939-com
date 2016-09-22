<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><{$setting.meta_title}></title>
<meta name="description" content="<{$setting.meta_description}>" />
<link rel="canonical" href="<{$pc_url}>">
<meta content="width=device-width,user-scalable=no" name="viewport">
<meta name="apple-mobile-web-app-capable" content="yes">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/body.css">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/other.css?201608221">
</head>
<body>
<article class="main">
<header class="main-hd personal-hd">
<a href="/" class="j_logo"><img src="/images/jjlo.png"></a>
<h2 class="main-hd-bt">久久健康网 · <{if $channel_catname}><a href="/<{$channels_url}>/"><{$channel_catname}></a><{else}><a href="/<{$channels_url}>/"><{$channels}></a><{/if}></h2>
    <div class="hd-right">
        <!--6.1 修改-->
        <div class="personal">
        	<a href="javascript:;" class="personal-btn"><img src="/images/f_sym.png"></a>
        </div>
        <!--ends-->   
    </div>
</header>
 <!--6.1 修改-->
 <!--右上角快速导航 开始-->
 <{include file="navigation/fast_navigation.html"}>
<!--右上角快速导航 结束sdfsd-->
<div class="m_shor"><{if $channel_catname}><a href="/<{$channels_url}>/"><{$channel_catname|truncate:2:""}></a> &gt; <a href="<{$parenturl}>"><{$upcatname}></a><{else}><a href="/<{$channels_url}>/"><{$channels|truncate:2:""}></a><{/if}></div>
    <section>
    	
     <div class="adpla" style="margin:0.2em 0;">
			<script type="text/javascript">
                    var cpro_id="u2464096";
                    (window["cproStyleApi"] = window["cproStyleApi"] || {})[cpro_id]={at:"3",hn:"0",wn:"0",imgRatio:"1.7",scale:"20.6",pat:"6",tn:"template_inlay_all_mobile_lu_native",rss1:"#FFFFFF",adp:"1",ptt:"0",titFF:"%E5%BE%AE%E8%BD%AF%E9%9B%85%E9%BB%91",titFS:"14",rss2:"#000000",titSU:"0",ptbg:"70",ptp:"0"}
                    </script>
         <script type="text/javascript" src="http://jsm.9939.com/cpro/ui/cm.js"></script>
	   </div>
    	
        <ul class="colum">
            <!--<li  style = "height: 6.0em;" >
                <span>
                    <script type="text/javascript">
                    var cpro_id="u2464096";
                    (window["cproStyleApi"] = window["cproStyleApi"] || {})[cpro_id]={at:"3",hn:"0",wn:"0",imgRatio:"1.7",scale:"20.6",pat:"6",tn:"template_inlay_all_mobile_lu_native",rss1:"#FFFFFF",adp:"1",ptt:"0",titFF:"%E5%BE%AE%E8%BD%AF%E9%9B%85%E9%BB%91",titFS:"14",rss2:"#000000",titSU:"0",ptbg:"70",ptp:"0"}
                    </script>
                    <script src="http://cpro.baidustatic.com/cpro/ui/cm.js" type="text/javascript"></script>
                </span>
            </li>-->
        <{if $channel_arry}>
            <{foreach from=$channel_arry item=channel}>
                <li><a href="<{if $channel.child eq 0}>/<{$channel.catdir}>/<{$channel.catid}>list.shtml <{else}>/<{$channels_url}>/<{$channel.catid}><{/if}>"><span></span><span><{$channel.catname}></span><span></span></a></li>
            <{/foreach}>
        <{/if}>
        </ul>
    </section>
    <!-- footer stars -->
	   <{include file="footer/footer.html"}>
	<!-- footer ends -->
</article>
<!--6.1 修改-->
<script type="text/javascript">setTimeout(show_tanchuang,10000);function toggleMenu(the,id){for(i=1;i<=2;i++){if(i==the){document.getElementById('tab'+i+id).className='hhh';document.getElementById('the'+i+id).className=''}else{document.getElementById('tab'+i+id).className='';document.getElementById('the'+i+id).className='hidden'}}}var sec=1000;var cou=20;function close_tanchuang(s){document.getElementById("tanchuang").className='hidden';if(s==1){setTimeout(show_tanchuang,sec*cou);cou=cou+18}}function show_tanchuang(){document.getElementById("tanchuang").className=''}</script>
<!--ends-->
<script type="text/javascript" src="/scripts/sea.js"></script>
<script type="text/javascript">
    seajs.use("play.js")
</script>
</body>
</html>
