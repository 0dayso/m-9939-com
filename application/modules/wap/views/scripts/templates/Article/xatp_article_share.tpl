<div class="sio">
    <div class="cdoer">
        <div class="sndek lious clearfix">
            <a href="http://qr.liantu.com/api.php?text=<{$article_url}>"
               data-url='<{$article_url}>' data-text="<{$result.title}>" >
                <span class="radus"><i class="weixn"></i></span>
                <span>微信朋友圈</span>
            </a>
            <a href="http://service.weibo.com/share/share.php?title=<{if isset($result) && !empty($result)}><{$result.title}><{/if}>&url=<{$article_url}>&pic="
               data-url='<{$article_url}>' data-text="<{$result.title}>" >
                <span class="radus"><i  class="xlwb"></i></span>
                <span>新浪微博</span>
            </a>
            <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<{$article_url}>"
               data-url='<{$article_url}>' data-text="<{$result.title}>" >
                <span  class="radus"><i class="lqqkj"></i></span>
                <span>QQ空间</span>
            </a>
        </div>
    </div>
    <p class="cairet">取消</p>
</div>