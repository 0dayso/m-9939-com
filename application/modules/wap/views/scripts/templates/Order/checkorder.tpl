<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>订单核对</title>
        <meta name="viewport" id="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="applicable-device" content="mobile">
        <meta name="format-detection" content="telephone=no">
        <link type="text/css" href="/order/1/css/style.css" rel="stylesheet"/>
    </head>
    <body>
        <header><a href=""></a>订单核对</header>
        <form name="alipayment" action="/order/alipay.shtml" method="post">
            <input type="hidden" id="order[tradeid]" name="order[tradeid]" value="<{$result.tradeid}>" />
            <input type="hidden" id="order[id]" name="order[id]" value="<{$result.id}>" />
            <ul class="maksu">
                <li><label>商品名称：</label><div><{$result.productname}></div></li>
                <li><label>姓<span></span>名：</label><div><{$result.username}></div></li>
                <li><label>手机号码：</label><div><{$result.phone}></div></li>
                <li><label>所在地区：</label><div><{$result.city}><{$result.area}></div></li>
                <li><label>详细地址：</label><div><{$result.address}></div></li>
                <li><label>需<em></em>支<em></em>付：</label><div><b>￥<{number_format($result.price, 2)}></b></div></li>
            </ul>
        </form>
        <a href="javascript:void(0);" onclick="submit()" class="gopur">去&nbsp;付&nbsp;款</a>
    <script>
        function submit(){
            document.forms['alipayment'].submit();
        }
    </script>
    <{include file="Order/tongji.tpl"}>
    </body>
</html>
