<?php
/**
 * 咨询结构化数据
 * 2016-08-05
 * */
class StructdataController extends App_Controller_Action {
    
    public function indexAction() {
        $struct_obj = new App_Model_CreateArticleStruct();
        $struct_obj->createXml();
    }
    
    
}