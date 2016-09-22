<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


return array(
    'show_article' =>
    new Zend_Controller_Router_Route_Regex('(\w+)/article/(\d+)\.shtml$', array(
        'controller' => 'Article',
        'action' => 'dispatch'
            ), array(
        1 => 'channel',
        2 => 'id'
            ), '%s/' . 'article' . '/%d.shtml'
    )
    ,
    'disease_dis_index_regex' =>
    new Zend_Controller_Router_Route_Regex('jb', array(
        'controller' => 'Disease',
        'action' => 'index'
            )
    )
    ,
    'disease_dis_regex' =>
    new Zend_Controller_Router_Route_Regex('jb/(\d+)\.shtml', array(
        'controller' => 'Disease',
        'action' => 'dis'
            ), array(
        1 => 'id'
            ), 'Disease/%d.shtml'
    )
    ,
    'disease_dis_letter_regx' =>
    new Zend_Controller_Router_Route('jb/letter/', array(
        'controller' => 'Disease',
        'action' => 'letter'
            )
    )
    ,
    'search_index' =>
    new Zend_Controller_Router_Route_Regex('zhuanti/', array(
        'module' => 'wap',
        'controller' => 'zhuanti',
        'action' => 'index'
            )
    )
    ,
    'search_keywords_wd_regex' =>
    new Zend_Controller_Router_Route_Regex('zhuanti/(\w{2,})', array(
        'module' => 'wap',
        'controller' => 'zhuanti',
        'action' => 'search'
            ), array(
        1 => 'wd'
            ), 'zhuanti/%s'
    )
    ,
    'search_keywords_wd_page_regex' =>
    new Zend_Controller_Router_Route_Regex('zhuanti/(\w{2,})/(\d+)', array(
        'module' => 'wap',
        'controller' => 'zhuanti',
        'action' => 'lists'
            ), array(
        1 => 'wd',
        2 => 'page'
            ), 'zhuanti/%s/%d'
    )
    ,
    'baby_special' =>
    new Zend_Controller_Router_Route_Regex('baby/zhuanti', array(
        'module' => 'wap',
        'controller' => 'baby',
        'action' => 'index'
            )
    )
    ,
    'baby_special_yuerbaike' =>
    new Zend_Controller_Router_Route_Regex('baby/zhuanti/zhoukan', array(
        'module' => 'wap',
        'controller' => 'baby',
        'action' => 'baike'
            )
    )
    ,
    'baby_special_detail' =>
    new Zend_Controller_Router_Route_Regex('baby/zhuanti/(?!zhoukan)(\w+)', array(
        'module' => 'wap',
        'controller' => 'baby',
        'action' => 'search'
            ), array(
        1 => 'wd'
            ), 'baby/zhuanti/%s'
    )
    ,
    'pic_index' =>
    new Zend_Controller_Router_Route('pic/', array(
        'controller' => 'pic',
        'action' => 'index'
            ))
    ,
    'pic_mlist' =>
    new Zend_Controller_Router_Route_Regex('pic/([\w\/]+)', array(
        'module' => 'wap',
        'controller' => 'pic',
        'action' => 'mlist'
            ), array(
        1 => 'flag',
            ))
    ,
    'pic_slist' =>
    new Zend_Controller_Router_Route_Regex('pic/([\w\/]+)/list.shtml', array(
        'module' => 'wap',
        'controller' => 'pic',
        'action' => 'slist'
            ), array(
        1 => 'flag',
            ))
    ,
    'pic_article' =>
    new Zend_Controller_Router_Route_Regex('pic/article/(\d+).shtml', array(
        'module' => 'wap',
        'controller' => 'pic',
        'action' => 'article'
            ), array(
        1 => 'articleid',
            ))
    ,
    'pic_article_datas' =>
    new Zend_Controller_Router_Route('pic/articledatas', array(
        'controller' => 'pic',
        'action' => 'articledatas'
            ))
    ,
    'xatp_article_datas' =>
    new Zend_Controller_Router_Route('article/articledatas', array(
        'controller' => 'article',
        'action' => 'articledatas'
            ))
    ,
    'create_article_struct' =>
    new Zend_Controller_Router_Route_Regex('create-article-struct', array(
        'controller' => 'structdata',
        'action' => 'index'
            )
    )
    ,
    'order_detail' =>
    new Zend_Controller_Router_Route_Regex('order/(\d+)\.shtml', array(
        'controller' => 'order',
        'action' => 'detail'
            ), array(
        1 => 'productid',
            ), 'order/%d.shtml'
    )
    ,
    'order_add' =>
    new Zend_Controller_Router_Route_Regex('order/add.shtml', array(
        'controller' => 'order',
        'action' => 'add'
            )
    )
    ,
    'order_checkorder' =>
    new Zend_Controller_Router_Route_Regex('order/checkorder.shtml', array(
        'controller' => 'order',
        'action' => 'checkorder'
            )
    )
    ,
    'order_success' =>
    new Zend_Controller_Router_Route_Regex('order/success.shtml', array(
        'controller' => 'order',
        'action' => 'success'
            )
    )
    ,
    'order_alipay' =>
    new Zend_Controller_Router_Route_Regex('order/alipay.shtml', array(
        'controller' => 'order',
        'action' => 'alipay'
            )
    )
    ,
    'order_alipay_notify' =>
    new Zend_Controller_Router_Route_Regex('order/alipayNotify.shtml', array(
        'controller' => 'order',
        'action' => 'alipay-notify'
            )
    )
    ,
    'order_alipay_return' =>
    new Zend_Controller_Router_Route_Regex('order/alipayReturn.shtml', array(
        'controller' => 'order',
        'action' => 'alipay-return'
            )
    )
    ,
    'beauty_part' =>
    new Zend_Controller_Router_Route('retutuijiandaochu', array(
        'controller' => 'channel',
        'action' => 'beauty'
            )
    )
);
