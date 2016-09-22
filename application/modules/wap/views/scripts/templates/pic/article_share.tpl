<div class="sio">
    <div class="cdoer">
        <div class="sndek lious clearfix">
            <a href="http://qr.liantu.com/api.php?text=<{$articleurl}>"
               data-url='<{$articleurl}>' data-text="<{$article[0].title}>" >
                <span class="radus"><i class="weixn"></i></span>
                <span>微信朋友圈</span>
            </a>
            <a href="http://service.weibo.com/share/share.php?title=<{if isset($article[0]) && !empty($article[0])}><{$article[0].title}><{/if}>&url=<{$articleurl}>&pic="
               data-url='<{$articleurl}>' data-text="<{$article[0].title}>" >
                <span class="radus"><i  class="xlwb"></i></span>
                <span>新浪微博</span>
            </a>
            <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<{$articleurl}>"
               data-url='<{$articleurl}>' data-text="<{$article[0].title}>" >
                <span  class="radus"><i class="lqqkj"></i></span>
                <span>QQ空间</span>
            </a>
        </div>
    </div>
    <p class="cairet">取消</p>
</div>