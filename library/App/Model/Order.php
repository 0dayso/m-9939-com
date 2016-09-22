<?php

class App_Model_Order extends QModels_Disease_TableWrite
{
    protected $_name = "9939_order";
    protected $_primary = 'id';
    
    /**
     * 添加订单
     * @param type $orderData
     * @return type
     */
    public function insertOrder($orderData)
    {
        $insertOrderId = 0;
        if (!empty($orderData)) {
            $insertOrderId = $this->insert($orderData);
        }
        return $insertOrderId;
    }
    
    /**
     * 获取单条订单记录信息
     * @param type $where
     * @return type
     */
    public function getOrder($where)
    {
        $result = $this->fetchRow($where);
        return $result;
    }
    
    /**
     * 更新订单记录
     * @param type $data
     * @param type $where
     * @return type
     */
    public function updateOrder($data, $where)
    {
//        print_r($data);exit;
        $result = $this->update($data, $where);
        return $result;
    }
    
    
}