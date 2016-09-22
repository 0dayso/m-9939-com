<div class="flicking_con">
    <{if isset($hotPics) && !empty($hotPics)}>
    <{foreach $hotPics as $key => $hotPic}>
    <a href="#"><{$key + 1}></a>
    <{/foreach}>
    <{/if}>
</div>
<div class="main_image">
    <ul class="d-durse clearfix">
        <{if isset($hotPics) && !empty($hotPics)}>
        <{foreach $hotPics as $key => $hotPic}>
            <li style="display: block; position: absolute; top: 0px; left: <{if $key == 0}>0<{else}><{(count($hotPics) - $key) * -358}><{/if}>px; width: 358px;">
            <{if isset($hotPic) && !empty($hotPic)}>
            <{foreach $hotPic as $ikey => $innerHotPic}>
            <div class="louts">
                <a href="<{$innerHotPic.linkurl}>" title="<{$innerHotPic.adsname}>">
                    <img src="<{$innerHotPic.imageurl}>"  alt="<{$innerHotPic.adsname}>" title="<{$innerHotPic.adsname}>">
                    <span><{$innerHotPic.adsname}></span>
                </a>
            </div>
            <{/foreach}>
            <{/if}>
        </li>
        <{/foreach}>
        <{/if}>
    </ul>
</div>
