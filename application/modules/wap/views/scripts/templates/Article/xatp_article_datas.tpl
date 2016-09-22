<div class="floor-item">
    <{if isset($articleDatas.articles) && !empty($articleDatas.articles)}>
        <{foreach $articleDatas.articles as $key => $article}>
            <a href="<{$article.url}>" class="third-news clearfix">
                <div class="widrso"><{$article.thumb}></div>
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
                        <{if isset($ads_2) && !empty($ads_2)}>
                            <{$ads_2}>
                        <{/if}>
                    <{else}>
                        <{if isset($ads_1) && !empty($ads_1)}>
                            <{$ads_1}>
                        <{/if}>
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
            url : "/article/articledatas",
            data : "articleid="+articleid+"&page=" + page,
            dataType: "html",
            success: function(res){
                scroll(0,0);
                $("#articleDatas").html(res);
            }
        });
    }
</script>
