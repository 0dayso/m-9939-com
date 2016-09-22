<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title><{$diseaseBasicInfoArr.title}>_疾病列表_久久问医</title>

<meta name="baidu-site-verification" content="wRAn557dE3" />
<meta name="keywords" content="<{$diseaseBasicInfoArr.title}>疾病,久久问医" />
<meta name="description" content="久久问医为您提供<{$diseaseBasicInfoArr.title}>疾病方面的症状、预防、保健、治疗、诊断、用药等方面的问题及在线医生解答." />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta http-equiv="Cache-Control" content="no-cache">
<meta content="telephone=no" name="format-detection">

<link rel="stylesheet" type="text/css" href="/css/body.css">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/index.css">
<link rel="stylesheet" type="text/css" href="<{$smarty.const.__DOMAINURL__}>/css/other.css?123456">

<script src="/scripts/jquery-1.11.2.min.js"></script>
<script src="/scripts/page.js"></script>

</head>


<body>
<article class="main-hd personal-hd">
	 <a href="http://m.9939.com/" class="j_logo"><img src="/images/jjlo.png"></a>
	<h2 class="main-hd-bt"><{$diseaseBasicInfoArr.title}></h2>
	
	<!-- 右侧快捷按钮 Start -->
	<div class="hd-right">
		<div class="personal">
			<a href="javascript:;" class="personal-btn"><img src="/images/f_sym.png"></a>
		</div>
     <!--ends-->   
	</div>
</article>
<{include file="navigation/fast_navigation_ask.html"}>
<!-- 右侧快捷按钮 End -->	
	
	<div class="blahe" style = "height: 0.12em;" ></div>
	
	<nav>
		<a href="http://m.9939.com" title = "首页">首页</a>>
		<a href="http://wapask.9939.com" title = "问医">问医</a>>
		<a href="http://wapask.9939.com/department/list.html" title = "疾病科室">疾病科室</a>>
		<a href="javascript:"><{$diseaseBasicInfoArr.title}></a>
	</nav>
	
	<article class="searc">
		<input type="search" id = "searchWords" placeholder="请描述疾病或症状..."><a href="" id = "searchBtn">搜索</a><a
			href="/ask/goAskDoctor">提问</a>
	</article>
	
	<article>
		<{include file="ads/ads_detailDisease_01.html"}>
	</article>
	
	<div class="thre"></div>
	<section class="doct">
		<h2 class="blood"><{$diseaseBasicInfoArr.title}></h2>
		
		<article class="acqua">
			<a href=""><img src="<{$diseaseBasicInfoArr.thumb}>" alt="<{$diseaseBasicInfoArr.title}>" title = "<{$diseaseBasicInfoArr.title}>"></a>
			
			<input type = "hidden" id = "diseaseNameID" value = "<{$diseaseBasicInfoArr.title}>" />
			<input type = "hidden" id = "diseaseID" value = "<{$diseaseID}>" />
			
			<p class="bre_01">
				<{$diseaseBasicInfoArr.simpleDesc}> <a>[展开]</a>
			</p>
			<p class="bre_02" style = "display:none;">
				<{$diseaseBasicInfoArr.description}> 
				<a>[收起]</a>
			</p>
		</article>
		
		<article class="resyp">
			<span>相关症状：</span>
			<{foreach from = $symptomArr item = symptomVal key = key}>
				<a href="javascript:"><{$symptomVal.title}></a>
			<{/foreach}>
		</article>
		
		<article class="fimed">
			<span>适用药品：</span>
			<ul class="ims">
				<{if count($drugArr) > 0 }>
					<{foreach from = $drugArr item = drugVal key = key}>
						<li>
							<a href="javascript:" title = "<{$drugVal.ypName}>">
								<img src="<{$drugVal.ypPic}>" alt="<{$drugVal.ypName}>" title = "<{$drugVal.ypName}>"></a>
							<a href="javascript:" title = "<{$drugVal.ypName}>"><{$drugVal.ypShortName}></a>
						</li>
					<{/foreach}>
				<{/if}>
				<{if  count($drugArr) == 0 }>
				<li>暂无</li>
				<{/if}>
			</ul>
		</article>
	</section>
	
	<article class="arnav">
		为您找到<span><{$diseaseBasicInfoArr.title}></span>相关问题<{$askCount}>个
	</article>
	
	<div id = "fatherHTMLID">
	</div>
	
	<!--底部部分 Start-->
	<{include file="footer/ask_doctor_footer.html"}>
	<!--底部部分 End-->
	
	<!-- 统计功能 Start -->
	<{include file="ads/wap_ask_stat.html"}>
	<!-- 统计功能 End -->
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			//设置 搜索 部分的 a 的 href 值
			$("#searchBtn").on('click', function(){
				searchWords = $("#searchWords").val();
				
				$(this).attr("href", "/search/" + encodeURI(searchWords) + "/1");
			});
			
			//异步分页操作
			$.ajax({
				  url: "/search/detaildiseasepage?diseaseID="+ $("#diseaseID").val() + "&diseaseName="+ encodeURI($("#diseaseNameID").val()) ,
				  cache: false, 
				  success: function(html){
				  		//将得到的信息，添加到 n3Tab33ContentDep 下面
				  		$("#fatherHTMLID").html(html);
				  }
			});
		
			
		});
	</script>
	
	<script src="/scripts/sea.js"></script>
	<script type="text/javascript">
		seajs.use("play.js");
	</script>	
	
</body>
</html>
