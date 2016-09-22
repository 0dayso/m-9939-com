<?php

class QLib_Payment_Client {

    /**
     * 
     * @param type $orderinfo
     * @return type
     */
    public static function alipay($orderinfo) {
        require_once("Alipay/alipay.config.php");
        //商户订单号，商户网站订单系统中唯一订单号，必填
        $out_trade_no = $orderinfo['WIDout_trade_no'];
        //订单名称，必填
        $subject = $orderinfo['WIDsubject'];
        //付款金额，必填
        $total_fee = $orderinfo['WIDtotal_fee'];
        //收银台页面上，商品展示的超链接，必填
        $show_url = $orderinfo['WIDshow_url'];
        //商品描述，可空
        $body = $orderinfo['WIDbody'];
//        echo $alipay_config['notify_url'];
//        exit;
        //构造要请求的参数数组，无需改动
        $parameter = array(
            "service" => $alipay_config['service'],
            "partner" => $alipay_config['partner'],
            "seller_id" => $alipay_config['seller_id'],
            "payment_type" => $alipay_config['payment_type'],
            "notify_url" => $alipay_config['notify_url'],
            "return_url" => $alipay_config['return_url'],
            "_input_charset" => trim(strtolower($alipay_config['input_charset'])),
            "out_trade_no" => $out_trade_no,
            "subject" => $subject,
            "total_fee" => $total_fee,
            "show_url" => $show_url,
            //"app_pay"	=> "Y",//启用此参数能唤起钱包APP支付宝
            "body" => $body,
                //其他业务参数根据在线开发文档，添加参数.文档地址:https://doc.open.alipay.com/doc2/detail.htm?spm=a219a.7629140.0.0.2Z6TSk&treeId=60&articleId=103693&docType=1
                //如"参数名"	=> "参数值"   注：上一个参数末尾需要“,”逗号。
        );

//建立请求
        $alipaySubmit = new QLib_Payment_Alipay_Submit($alipay_config);
        $html_text = $alipaySubmit->buildRequestForm($parameter, "post", "正在使用支付宝支付...");
        return $html_text;
    }
    
    
    static function createAlipayNotify()
    {
        require_once("Alipay/alipay.config.php");
        $alipayNotify = new QLib_Payment_Alipay_Notify($alipay_config);
        return $alipayNotify;
    }
}
