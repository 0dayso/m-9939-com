<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>处理订单</title>
        <meta name="viewport" id="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="applicable-device" content="mobile">
        <meta name="format-detection" content="telephone=no">
        <link type="text/css" href="/order/1/css/style.css" rel="stylesheet"/>
    </head>
    <body>
        <header><a href=""></a>处理订单</header>
        <form name="checkorder" action="/order/checkorder.shtml" method="post">
            <input type="hidden" id="id" name="id" value="<{$insertorderid}>" />
            <ul class="maksu">
                <li>正在处理订单，请稍等...</li>
            </ul>
        </form>
        <script>
            function submit(){
                document.forms['checkorder'].submit();
            }
            setTimeout('submit()', 3000);
        </script>
    <{include file="Order/tongji.tpl"}>
    </body>
</html>
