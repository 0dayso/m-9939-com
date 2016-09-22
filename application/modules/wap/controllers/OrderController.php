<?php

class OrderController extends App_Controller_Action {

    protected $orderObj;
    protected $domain;
    protected $keypre = 'ouqwrelouwer08_9939_order';//表单
    
    
    public function init() {
//        ini_set('display_errors',1);
//        error_reporting(E_ALL); 
        parent::init();

        $this->orderObj = new App_Model_Order();
        $this->disableCache();
    }

    /**
     * 商品详情页
     */
    public function detailAction() {
        $uri = md5($_SERVER['REQUEST_URI']);
        $productid = $this->getParam("productid");
        $template_path = 'Order/' . $productid . '/detail.tpl';
        $product_data = $this->getProductDetail($productid);
                
        //生成表单验证key
        $validateKey = new Zend_Session_Namespace('validateKey');
        $data = $product_data['single'] == 1 ? array('productid' => $productid) : array();
        $encodeStr = serialize($data);
        $key = 'secretkey'.$productid;
        $validateKey->$key = $this->encrypt($encodeStr, 'ENCODE', $this->keypre);
        $secretkey = $validateKey->$key;
        
        $token_session = new Zend_Session_Namespace('token');
        $user_token = $token_session->token = md5(microtime(true));
        
        $cacheName = md5('order'.$productid);
        $cacheDir = "pages/orderrandlist";
        $orders = QLib_Cache_Client::getCache($cacheDir, $cacheName);
        if (!$orders) {
            $orderlist = $this->randOrderInfo();
            if($product_data['single'] == 1){//如果是单品
                $orders = $orderlist;
            }else{//如果是多产品
                $productMap = $this->productMap();
                foreach($productMap as $k=>$v){
                    if(isset($v['bindpid']) && $v['bindpid'] == $productid){
                        $pids[] = $k;
                    }
                }
                
                foreach($orderlist as $k=>$v){
                    $rand_pid = rand(min($pids), max($pids));
                    $rand_prodetail = $this->getProductDetail($rand_pid);
                    $v['shortproductname'] = $rand_prodetail['shortproductname'];
                    $v['price'] = $rand_prodetail['price'];
                    $orders[$k] = $v;
                }
            }
            
            $time = 24;
            QLib_Cache_Client::setCache($cacheDir, $cacheName, $orders, $time);
        }
        $procuctdetail = $this->getProductDetail($productid);
        
        $this->view->assign('productid', $productid);
        $this->view->assign('procuctdetail', $procuctdetail);
        $this->view->assign('token', $user_token);
        $this->view->assign('secretkey', $secretkey);
        $this->view->assign('orderlist', $orders);
        
        echo $this->view->render($template_path, $uri);
    }
    
    
    /**
     * 页面多商品验证表单
     * @param type $data
     */
    private function muiltproValidataForm() {
        $validata = array();
        $user_token = $this->getParam('token');
        $token_session = new Zend_Session_Namespace('token');
        $server_token = $token_session->token;
        if($user_token == $server_token){
            //清除token
            $token_session->__unset('token');
                    
            $secretkey = $this->getParam('secretkey');
            $act = $this->getParam('act');
            $productid = $this->getParam('productid');

                
            if (isset($act) && $act == 'add') {

                $string_helper = QLib_Utils_String::String();


                $username = $this->getParam('username');
                if ($username == '') {
                    self::alert('姓名不能为空');
                    return false;
                }

                $phone = $this->getParam('phone');
                $phone = $string_helper->stripTags($phone);
                $phone = preg_replace("/\s/", '', $phone);
                if (empty($phone)) {
                    self::alert('手机号码不能为空');
                    return false;
                }
                $flag = $this->checkMobileNum($phone);
                if (!$flag) {
                    self::alert('手机号码格式不正确');
                    return false;
                }

                $citycode = $this->getParam('city');
                if (!$citycode) {
                    self::alert('请选择所在省份');
                    return false;
                }
                $areacode = $this->getParam('area');
                if (!$areacode) {
                    self::alert('请选择所在县/市');
                    return false;
                }

                $address = $this->getParam('address');
                $address = $string_helper->stripTags($address);
                $address = preg_replace("/\s/", '', $address);
                if (empty($address)) {
                    self::alert('地址不能为空');
                    return false;
                }

                $message = $this->getParam('message');
                $message = $string_helper->stripTags($message);

                $validata = array(
                    'productid' => intval($productid),
                    'username' => $username,
                    'phone' => $phone,
                    'citycode' => $citycode,
                    'areacode' => $areacode,
                    'address' => $address,
                    'message' => $message,
                );
                return $validata;
            } else {
                return false;
            }
        }else{
            self::alert('请勿重复提交表单');
            return false;
        }
    }
    
    
    /**
     * 单品验证表单
     * @param type $data
     */
    private function singleValidataForm() {
        $validata = array();
        $user_token = $this->getParam('token');
        $token_session = new Zend_Session_Namespace('token');
        $server_token = $token_session->token;
        if($user_token == $server_token){
            //清除token
            $token_session->__unset('token');
                    
            $secretkey = $this->getParam('secretkey');
            $act = $this->getParam('act');
            $productid = $this->getParam('productid');

            //1、通过直接解密密钥比对原始数据是否一致
//            $secret_data = unserialize($this->encrypt($secretkey, 'DECODE', $this->keypre));
//            $secret_productid = $secret_data['productid'];
//            if($secret_productid !== $productid){
//                self::alert('请勿篡改表单数据。');
//                return false;
//            }

            //2、通过session进一步比对
            $validateKey = new Zend_Session_Namespace('validateKey');
            $key = 'secretkey'.$productid;
            $session_secretkey = $validateKey->$key;

            if(isset($secretkey) && $secretkey == $session_secretkey){
                //清除secretkey
                $token_session->__unset($key);
                
                if (isset($act) && $act == 'add') {

                    $string_helper = QLib_Utils_String::String();


                    $username = $this->getParam('username');
                    if ($username == '') {
                        self::alert('姓名不能为空');
                        return false;
                    }

                    $phone = $this->getParam('phone');
                    $phone = $string_helper->stripTags($phone);
                    $phone = preg_replace("/\s/", '', $phone);
                    if (empty($phone)) {
                        self::alert('手机号码不能为空');
                        return false;
                    }
                    $flag = $this->checkMobileNum($phone);
                    if (!$flag) {
                        self::alert('手机号码格式不正确');
                        return false;
                    }

                    $citycode = $this->getParam('city');
                    if (!$citycode) {
                        self::alert('请选择所在省份');
                        return false;
                    }
                    $areacode = $this->getParam('area');
                    if (!$areacode) {
                        self::alert('请选择所在县/市');
                        return false;
                    }

                    $address = $this->getParam('address');
                    $address = $string_helper->stripTags($address);
                    $address = preg_replace("/\s/", '', $address);
                    if (empty($address)) {
                        self::alert('地址不能为空');
                        return false;
                    }

                    $message = $this->getParam('message');
                    $message = $string_helper->stripTags($message);

                    $validata = array(
                        'productid' => intval($productid),
                        'username' => $username,
                        'phone' => $phone,
                        'citycode' => $citycode,
                        'areacode' => $areacode,
                        'address' => $address,
                        'message' => $message,
                    );
                    return $validata;
                } else {
                    return false;
                }
            }else{
                self::alert('表单数据有误，请返回重填。');
                return false;
            }
        }elseif($user_token == ''){
            self::alert('请勿非法提交数据');
            return false;
        }else{
            self::alert('请勿重复提交表单');
            return false;
        }
    }

    private function checkMobileNum($mobile) {
        if (!is_numeric($mobile)) {
            return false;
        }
        return preg_match('#^13[\d]{9}$|^14[5,7]{1}\d{8}$|^15[^4]{1}\d{8}$|^17[0,6,7,8]{1}\d{8}$|^18[\d]{9}$#', $mobile) ? true : false;
    }

    /**
     * 用户订单处理
     */
    public function addAction() {
        
//        echo '系统有误,请稍后再试!';exit;
        $validateType = $this->getParam('validateType', 1);
        if($validateType == 1){
            $formdata = $this->singleValidataForm();
        }elseif($validateType == 2){
            $formdata = $this->muiltproValidataForm();
        }
        
        
        if (!$formdata) {
            self::alert('表单信息错误，请返回重新填写。');
            return false;
        }
//        print_r($formdata);exit;
        //商品id
        $productid = $formdata['productid'];
        $procuctdetail = $this->getProductDetail($productid);
        if (empty($procuctdetail)) {
            self::alert('商品不存在,请确认后再试!');
            return false;
        }
        //订单号
        $orderidpre = ''; //2
        $orderiddate = date('YmdHis'); //15
        $orderidrand = $this->createRandom(5); //3
        $tradeid = $orderidpre . $orderiddate . $orderidrand; //20位
        //商品名称
        $productname = $procuctdetail['productname'];

        //商品价格
        $price = $procuctdetail['price'];

        //用户信息
        $citycode = $formdata['citycode'];
        $areacode = $formdata['areacode'];
        $username = $formdata['username'];
        $phone = $formdata['phone'];
        $city = $this->getCityName($citycode);
        $area = $this->getAreaName($areacode);
        $address = $formdata['address'];
        $message = $formdata['message'];

        //订单信息
        $orderdata = array(
            'tradeid' => $tradeid,
            'productid' => $productid,
            'productname' => $productname,
            'price' => $price,
            'username' => $username,
            'phone' => $phone,
            'city' => $city,
            'area' => $area,
            'address' => $address,
            'message' => $message,
            'createtime' => time(),
            'updatetime' => time(),
        );
//        print_r($orderdata);exit;
        $insertorderid = $this->orderObj->insertOrder($orderdata);
        
        //进入订单核对页，同时传入当前的订单id号
        if($insertorderid > 0){
            $this->_forward(
                    'checkorder', 'order', 'wap', array('id' => $insertorderid)
            );
        }else{
            self::alert('订单处理异常,请稍后再试');
            return false;
        }
    }

    /**
     * 订单核对页
     */
    public function checkorderAction() {
        $insertorderid = $this->getParam('id');
        //订单信息
        $where = 'id='.$insertorderid;
        $result = $this->orderObj->getOrder($where);
        
        if(!empty($result)){
            $productid = $result['productid'];
            $template_path = 'Order/checkorder.tpl';
            $this->view->assign('result', $result);
        }else{
            $this->view->assign('insertorderid', $insertorderid);
            $template_path = 'Order/dealorder.tpl';
        }
        $uri = md5($_SERVER['REQUEST_URI']);
        echo $this->view->render($template_path, $uri);
    }

    /**
     * 订单付款成功页
     */
    public function alipayAction() {
        $params = $this->getParam("order");
        $order_id = $params['id'];
        $order_tradeid = $params['tradeid'];
        //订单信息
        $where = 'id='.$order_id;
        $order = $this->orderObj->getOrder($where);
        if ($order['tradeid'] == $order_tradeid) {
            $orderinfo = array(
                'WIDout_trade_no' => $order['tradeid'],
                'WIDsubject' => $order['productname'],
                'WIDshow_url' => sprintf('%s/%s.shtml', 'http://m.9939.com/order', $order['productid']),
                'WIDbody' => $order['productname'],
                'WIDtotal_fee' => number_format($order['price'], 2)
            );
            $html = QLib_Payment_Client::alipay($orderinfo);
            echo $html;
            exit;
        } else {
            echo '订单信息有误!';
            exit;
        }
    }

    /**
     * 订单付款成功页
     */
    public function successAction() 
    {
        $tradeid = $this->getParam('tradeid');
        $where = 'tradeid=' . $tradeid;
        $order = $this->orderObj->getOrder($where);
        $productid = $order['productid'];
        $template_path = 'Order/' . $productid . '/success.tpl';
        $uri = md5($_SERVER['REQUEST_URI']);
        
        $homeUrl = sprintf("%s/%s.shtml", "http://m.9939.com/order", $productid);
        
        $this->view->assign('homeUrl', $homeUrl);
        echo $this->view->render($template_path, $uri);
    }

    /**
     * 服务器异步通知页面
     */
    public function alipayNotifyAction() {
        $alipayNotify = QLib_Payment_Client::createAlipayNotify();
        //计算得出通知验证结果
        $verify_result = $alipayNotify->verifyNotify();

        if ($verify_result) {//验证成功
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //请在这里加上商户的业务逻辑程序代
            //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
            //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表
            //商户订单号
            $out_trade_no = $this->getParam('out_trade_no');

            //支付宝交易号

            $trade_no = $this->getParam('trade_no');

            //交易状态
            $trade_status = $this->getParam('trade_status');
            


            if ($trade_status == 'TRADE_FINISHED') {
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
                //如果有做过处理，不执行商户的业务程序
                //注意：
                //退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
                //调试用，写文本函数记录程序运行情况是否正常
                //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
            } else if ($trade_status == 'TRADE_SUCCESS') {
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
                //如果有做过处理，不执行商户的业务程序
                //注意：
                //付款完成后，支付宝系统发送该交易状态通知
                //调试用，写文本函数记录程序运行情况是否正常
                //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
            }

            //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
            $result = $this->finishOrder($out_trade_no, $trade_no);
            if(isset($result)){
                echo "success";  //请不要修改或删除
            }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        } else {
            //验证失败
            echo "fail";

            //调试用，写文本函数记录程序运行情况是否正常
            //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
        }
    }

    /**
     * 页面跳转同步通知页面
     */
    public function alipayReturnAction() {
        $alipayNotify = QLib_Payment_Client::createAlipayNotify();
        //计算得出通知验证结果
        $verify_result = $alipayNotify->verifyReturn();
//        $verify_result = true;
        if ($verify_result) {//验证成功
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //请在这里加上商户的业务逻辑程序代码
            //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
            //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表
            //商户订单号
            $out_trade_no = $this->getParam('out_trade_no');

            //支付宝交易号
            $trade_no = $this->getParam('trade_no');

            //交易状态
            $trade_status = $this->getParam('trade_status');


            if ($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS') {
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序
            } else {
                echo "trade_status=" . $trade_status;
            }
            
            $result = $this->finishOrder($out_trade_no, $trade_no);
            if(isset($result)){
                $params = array('tradeid' => $out_trade_no);
                $this->_forward('success', 'order', 'wap', $params);
            }
            
//            echo "验证成功<br />";

            //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        } else {
            //验证失败
            //如要调试，请看alipay_notify.php页面的verifyReturn函数
            echo "验证失败";
        }
    }
    
    /**
     * 支付完成的订单
     * @param type $tradeid
     * @param type $alipay_trade_no
     * @return boolean
     */
    private function finishOrder($tradeid, $alipay_trade_no)
    {
        $where = 'tradeid=' . $tradeid;
        $order = $this->orderObj->getOrder($where);
        if(isset($order)){
            $orderdata = array('paystatus'=>1, 'paytradeno'=>$alipay_trade_no, 'updatetime'=>time());
            $where = 'tradeid=' . $tradeid;
            $result = $this->orderObj->updateOrder($orderdata, $where);
            
            //开始发送通知短信
            $order_tradeid = $order['tradeid'];
            $order_phone = $order['phone'];
            $order_url = sprintf("%s/%s.shtml", "http://m.9939.com/order", $order['productid']);
            $order_tel = '13522751702';
            
            $to_phone_num = $order_phone;
//            $message = "尊敬的用户您好，您已购买成功！订单号：{$order_tradeid}.如有疑问请咨询，{$order_url}";
            $message = "您已购买成功！订单号：{$order_tradeid}.如有疑问请询{$order_tel}";
            $sendResult = $this->sendSMS($to_phone_num, $message);
            
            return $result;
        }else{
            return false;
        }
    }
    
    /**
     * 订单成功之后发送通知短信
     * @param type $to
     * @param type $message
     * @param type $sendtime
     * @return type
     */
    private function sendSMS($to, $message, $sendtime=0)
    {
        $sendResult = QLib_Message_SMS_Client::send($to, $message, $sendtime);
        return $sendResult;
    }

    /**
     * 对指定字符串进行加/解密
     * @param type $string 加密字符串
     * @param type $operation ENCODE：加密 DECODE：解密
     * @param type $key 加密密钥
     * @param type $expiry 密钥有效期
     * @return string
     */
    private function encrypt($string, $operation = 'DECODE', $key = '', $expiry = 0) {
        // 动态密匙长度，相同的明文会生成不同密文就是依靠动态密匙   
        $ckey_length = 4;
        $key = md5($key);
        $keya = md5(substr($key, 0, 16));
        $keyb = md5(substr($key, 16, 16));
        $keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length) :
                        substr(md5(microtime()), -$ckey_length)) : '';
        $cryptkey = $keya . md5($keya . $keyc);
        $key_length = strlen($cryptkey);
        $string = $operation == 'DECODE' ? base64_decode(substr($string, $ckey_length)) :
                sprintf('%010d', $expiry ? $expiry + time() : 0) . substr(md5($string . $keyb), 0, 16) . $string;
        $string_length = strlen($string);
        $result = '';
        $box = range(0, 255);
        $rndkey = array();
        for ($i = 0; $i <= 255; $i++) {
            $rndkey[$i] = ord($cryptkey[$i % $key_length]);
        }
        for ($j = $i = 0; $i < 256; $i++) {
            $j = ($j + $box[$i] + $rndkey[$i]) % 256;
            $tmp = $box[$i];
            $box[$i] = $box[$j];
            $box[$j] = $tmp;
        }
        for ($a = $j = $i = 0; $i < $string_length; $i++) {
            $a = ($a + 1) % 256;
            $j = ($j + $box[$a]) % 256;
            $tmp = $box[$a];
            $box[$a] = $box[$j];
            $box[$j] = $tmp;
            $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
        }
        if ($operation == 'DECODE') {
            if ((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) &&
                    substr($result, 10, 16) == substr(md5(substr($result, 26) . $keyb), 0, 16)) {
                return substr($result, 26);
            } else {
                return '';
            }
        } else {
            return $keyc . str_replace('=', '', base64_encode($result));
        }
    }

    /**
     * 生成指定位数的随机字符串
     * @param type $length
     * @return string
     */
    private function createRandom($length) {
        $chars = "0123456789";
        $random = '';
        for ($i = 0; $i < $length; $i++) {
            $random .= $chars[mt_rand(0, strlen($chars) - 1)];
        }
        return $random;
    }

    private function productMap()
    {
        return array(
            1 => array(
                'shortproductname' => '雷霆四代A380活塞飞机杯',
                'productname' => '雷霆四代A380活塞飞机杯男用全自动抽插伸缩自慰杯免提充电炮机',
                'price' => '359.00',
                'single' => 1,
            ),
            2 => array(
                'shortproductname' => 'BKK智能飞机杯倍克贝克',
                'productname' => 'BKK智能飞机杯倍克贝克人机互动口交杯虚拟现实3D场景男用自慰器',
                'price' => '559.00',
                'single' => 1,
            ),
            3 => array(
                'shortproductname' => '男用延迟喷雾剂1瓶',
                'productname' => '男用延迟喷雾剂1瓶',
                'price' => '169.00',
                'single' => 2,
                'bindpid' => 3,
            ),
            4 => array(
                'shortproductname' => '男用增大阴茎长度按摩膏1瓶',
                'productname' => '男用增大阴茎长度按摩膏1瓶',
                'price' => '169.00',
                'single' => 2,
                'bindpid' => 3,
            ),
            5 => array(
                'shortproductname' => '男用阴茎坚挺助勃凝胶1瓶',
                'productname' => '男用阴茎坚挺助勃凝胶1瓶',
                'price' => '169.00',
                'single' => 2,
                'bindpid' => 3,
            ),
            6 => array(
                'shortproductname' => '延迟喷雾剂1瓶+增大阴茎长度按摩膏1瓶',
                'productname' => '延迟喷雾剂1瓶+增大阴茎长度按摩膏1瓶',
                'price' => '310.00',
                'single' => 2,
                'bindpid' => 3,
            ),
            7 => array(
                'shortproductname' => '延迟喷雾剂1瓶+阴茎坚挺助勃凝胶1瓶',
                'productname' => '延迟喷雾剂1瓶+阴茎坚挺助勃凝胶1瓶',
                'price' => '310.00',
                'single' => 2,
                'bindpid' => 3,
            ),
            8 => array(
                'shortproductname' => '增大阴茎长度按摩膏1瓶+阴茎坚挺助勃凝胶1瓶',
                'productname' => '增大阴茎长度按摩膏1瓶+阴茎坚挺助勃凝胶1瓶',
                'price' => '310.00',
                'single' => 2,
                'bindpid' => 3,
            ),
            9 => array(
                'shortproductname' => '延迟喷雾剂1瓶+增大阴茎长度按摩膏1瓶+阴茎坚挺助勃凝胶1瓶',
                'productname' => '延迟喷雾剂1瓶+增大阴茎长度按摩膏1瓶+阴茎坚挺助勃凝胶1瓶',
                'price' => '450.00',
                'single' => 2,
                'bindpid' => 3,
            ),
        );
    }
    
    /**
     * 获取产品
     * @param type $productid
     */
    private function getProductDetail($productid) {
        $productMap = $this->productMap();
        return isset($productMap[$productid]) ? $productMap[$productid] : '';
    }

    /**
     * 根据城市地区代码获取城市地区名称
     * @param type $cityCode
     */
    private function getCityname($cityCode) {
        $areaMap = array(
            '01' => '北京市',
            '02' => '深圳市',
            '03' => '上海市',
            '04' => '重庆市',
            '05' => '天津市',
            '06' => '广东省',
            '07' => '河北省',
            '08' => '山西省',
            '09' => '内蒙古省',
            '10' => '辽宁省',
            '11' => '吉林省',
            '12' => '黑龙江省',
            '13' => '江苏省',
            '14' => '浙江省',
            '15' => '安徽省',
            '16' => '福建省',
            '17' => '江西省',
            '18' => '山东省',
            '19' => '河南省',
            '20' => '湖北省',
            '21' => '湖南省',
            '22' => '广西省',
            '23' => '海南省',
            '24' => '四川省',
            '25' => '贵州省',
            '26' => '云南省',
            '27' => '西藏自治区',
            '28' => '陕西省',
            '29' => '甘肃省',
            '30' => '青海省',
            '31' => '宁夏省',
            '32' => '新疆自治区',
            '33' => '香港',
            '34' => '澳门',
            '35' => '台湾',
        );
        return $areaMap[$cityCode];
    }

    private function getAreaName($areaCode) {
        $areaNumArr = str_split($areaCode, 2);
        $cityNum = strlen(intval($areaNumArr[0])) < 2 ? '0' . intval($areaNumArr[0]) : intval($areaNumArr[0]);
        $areaNum = intval($areaNumArr[1]) - 1;

        $areaMap = array(
            '01' => array('东城区', '西城区', '崇文区', '宣武区', '朝阳区', '海淀区', '丰台区', '石景山'),
            '02' => array('罗湖', '福田', '南山', '盐田', '宝安', '龙岗'),
            '03' => array('宝山', '金山', '南市', '长宁', '静安', '青浦', '崇明', '卢湾', '松江', '奉贤', '浦东', '杨浦', '虹口', '普陀', '闸北', '黄浦', '闵行', '徐汇', '嘉定', '南汇'),
            '04' => array('渝中', '江北', '沙坪坝', '南岸', '九龙坡', '大渡口'),
            '05' => array('和平', '河北', '河西', '河东', '南开', '红桥', '塘沽', '汉沽', '大港', '东丽', '西青', '津南', '北辰', '武清', '滨海'),
            '06' => array('广州', '珠海', '中山', '佛山', '东莞', '清远', '肇庆', '阳江', '湛江', '韶关', '惠州', '河源', '汕尾', '汕头', '梅州'),
            '07' => array('石家庄', '唐山', '秦皇岛', '邯郸', '邢台', '张家口', '承德', '廊坊', '沧州', '保定', '衡水'),
            '08' => array('太原', '大同', '阳泉', '朔州', '长治', '临汾', '晋城'),
            '09' => array('呼和浩特', '包头', '乌海', '临河', '东胜', '集宁', '锡林浩特', '通辽', '赤峰', '海拉尔', '乌兰浩特'),
            '10' => array('沈阳', '大连', '鞍山', '锦州', '丹东', '盘锦', '铁岭', '抚顺', '营口', '辽阳', '阜新', '本溪', '朝阳', '葫芦岛'),
            '11' => array('长春', '吉林', '四平', '辽源', '通化', '白山', '松原', '白城', '延边'),
            '12' => array('哈尔滨', '齐齐哈尔', '牡丹江', '佳木斯', '大庆', '伊春', '黑河', '鸡西', '鹤岗', '双鸭山', '七台河', '绥化', '大兴安岭'),
            '13' => array('南京', '苏州', '无锡', '常州', '镇江', '连云港', '扬州', '徐州', '南通', '盐城', '淮阴', '泰州', '宿迁'),
            '14' => array('杭州', '湖州', '丽水', '温州', '绍兴', '舟山', '嘉兴', '金华', '台州', '衢州', '宁波'),
            '15' => array('合肥', '芜湖', '蚌埠', '滁州', '安庆', '六安', '黄山', '宣城', '淮南', '宿州', '马鞍山', '铜陵', '淮北', '阜阳', '池州', '巢湖', '亳州'),
            '16' => array('福州', '厦门', '泉州', '漳州', '龙岩', '南平', '宁德', '莆田', '三明'),
            '17' => array('南昌', '景德镇', '九江', '萍乡', '新余', '鹰潭', '赣州', '宜春', '吉安', '上饶', '抚州'),
            '18' => array('济南', '青岛', '淄博', '德州', '烟台', '潍坊', '济宁', '泰安', '临沂', '菏泽', '威海', '枣庄', '日照', '莱芜', '聊城', '滨州', '东营'),
            '19' => array('郑州', '开封', '洛阳', '平顶山', '安阳', '鹤壁', '新乡', '焦作', '濮阳', '许昌', '漯河', '三门峡', '南阳', '商丘', '周口', '驻马店', '信阳', '济源'),
            '20' => array('武汉', '黄石', '十堰', '荆州', '宜昌', '襄樊', '鄂州', '荆门', '孝感', '黄冈', '咸宁', '恩施', '随州', '仙桃', '天门', '潜江', '神农架'),
            '21' => array('长沙', '株州', '湘潭', '衡阳', '邵阳', '岳阳', '常德', '郴州', '益阳', '永州', '怀化', '娄底', '湘西'),
            '22' => array('南宁', '柳州', '桂林', '梧州', '北海', '防城港', '钦州', '贵港', '玉林', '贺州', '百色', '河池'),
            '23' => array('海口', '三亚', '通什', '琼海', '琼山', '文昌', '万宁', '东方', '儋州'),
            '24' => array('成都', '自贡', '攀枝花', '泸州', '德阳', '绵阳', '广元', '遂宁', '内江', '乐山', '南充', '宜宾', '广安', '达川', '巴中', '雅安', '眉山', '阿坝', '甘孜', '凉山'),
            '25' => array('贵阳', '六盘水', '遵义', '铜仁', '毕节', '安顺', '黔西南', '黔东南', '黔南'),
            '26' => array('昆明', '东川', '曲靖', '玉溪', '昭通', '思茅', '临沧', '保山', '丽江', '文山', '红河', '西双版纳', '楚雄', '大理', '德宏', '怒江', '迪庆'),
            '27' => array('拉萨', '那曲', '昌都', '山南', '日喀则', '阿里', '林芝'),
            '28' => array('西安', '铜川', '宝鸡', '咸阳', '渭南', '延安', '汉中', '榆林', '商洛', '安康'),
            '29' => array('兰州', '金昌', '白银', '天水', '嘉峪关', '定西', '平凉', '庆阳', '陇南', '武威', '张掖', '酒泉', '甘南', '临夏'),
            '30' => array('西宁', '海东', ' 海北', '黄南', '海南', '果洛', '玉树', '海西'),
            '31' => array('银川', '石嘴山', '银南', '固原'),
            '32' => array('乌鲁木齐', '克拉玛依', '石河子', '吐鲁番', '哈密', '和田', '阿克苏', '喀什', '克孜勒苏', '巴音郭楞', '昌吉', '博尔塔拉', '伊犁'),
            '33' => array(),
            '34' => array(),
            '35' => array(),
        );
//        print_r($cityNum);
////        print_r($areaNum);
//        exit;
        return $areaMap[$cityNum][$areaNum];
    }

    /**
     * js提示弹窗
     * @param type $msg
     * @param type $url
     */
    static function alert($msg, $url = '') {
        echo '<script>';
        echo 'alert("' . $msg . '");';
        if ($url !== '') {
            echo 'window.location.href="' . $url . '";';
        } else {
            echo 'history.back(-1);';
        }

        echo '</script>';
        exit;
    }
    
    private function randOrderInfo(){
        $areaMap = array(
            '北京市',
            '深圳市',
            '上海市',
            '重庆市',
            '天津市',
            '广东省',
            '河北省',
            '山西省',
            '内蒙古省',
            '辽宁省',
            '吉林省',
            '黑龙江省',
            '江苏省',
            '浙江省',
            '安徽省',
            '福建省',
            '江西省',
            '山东省',
            '河南省',
            '湖北省',
            '湖南省',
            '广西省',
            '海南省',
            '四川省',
            '贵州省',
            '云南省',
            '西藏自治区',
            '陕西省',
            '甘肃省',
            '青海省',
            '宁夏省',
            '新疆自治区',
//            '香港',
//            '澳门',
//            '台湾'
        );
        $fst_name = array('王','李','赵','武','高','陈','石','闫','郭','吴','马','杨','欧阳','朱');
        $fst_mobile = array('134','135','136','137','138','139','150','151','152','157','158','159','182','183','184','187','188','178','147','130','131','132','155','156','185','186','176','145','133','153','180','181','189 ','177');
        $rd_mobile = range(1001,9999);
        
        shuffle($areaMap);
        shuffle($fst_name);
        shuffle($fst_mobile);
        shuffle($rd_mobile);
        
        $returninfo = array();
        $tmp_phones  = array();
        for($i=0;$i<11;$i++){
            $v = array();
            $v['date'] = date('Y-m-d', strtotime('-1 day')) ;
            $v['address'] =sprintf("%s的%s**",$areaMap[$i],$fst_name[$i]);
            $phone = sprintf('%s****%s',$fst_mobile[$i],$rd_mobile[$i]);
            if(!in_array($phone,$tmp_phones)){
                $tmp_phones[] = $phone;
                $v['phone'] = $phone;
            }
            $returninfo[] = $v;
        }
        return $returninfo;
    }
}
