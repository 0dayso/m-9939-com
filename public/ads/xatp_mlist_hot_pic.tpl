<div class="flicking_con">
    <{if isset($ads_hotpic) && !empty($ads_hotpic)}>
    <{foreach $ads_hotpic as $key => $hotPic}>
       <{if $key is even}>
            <a href="#"><{($key/2) + 1}></a>
       <{/if}>
    <{/foreach}>
    <{/if}>
</div>
<div class="main_image">
    <ul class="d-durse clearfix">
        <{if isset($ads_hotpic)}>
            <{foreach from=$ads_hotpic item=val key=key}>
               <{if $key is even}>
                   <li>
                <{/if}>

                <div class="louts"><a href="<{$val.linkurl}>"><img src="<{$val.imageurl}>"  alt="<{$val.adsname}>" title="<{$val.adsname}>"></a><span><{$val.adsname}></span></div>

                <{if $key is odd}>
                   </li>
               <{/if}>
            <{/foreach}>
         <{/if}>
    </ul>
</div>
