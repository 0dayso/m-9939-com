<div class="floor-item">
    <{if isset($articleDatas.articles) && !empty($articleDatas.articles)}>
        <{foreach $articleDatas.articles as $key => $article}>
            <a href="<{$article.url}>" class="third-news clearfix">
                <div class="widrso"><img src="<{$article.thumb}>" alt="<{$article.title}>" title="<{$article.title}>"></div>
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
                        <{include file="ads/pic_article_03.tpl"}>
                    <{else}>
                        <{include file="ads/pic_article_01.tpl"}>
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

<script>
    function paging(articleid, page){
        $.ajax({
            type : "GET",
            url : "/pic/articledatas",
            data : "articleid="+articleid+"&page=" + page,
            dataType: "html",
            success: function(res){
                scroll(0,0);
                $("#articleDatas").html(res);
            }
        });
    }
</script>
