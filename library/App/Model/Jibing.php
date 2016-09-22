<?php

class App_Model_Jibing extends QModels_Disease_Table
{
    /**
     * 获取疾病列表
     * @param type $departArr 
     * @param type $order 排序
     * @param type $offset 分页
     * @param type $size
     * @return array 所有数据列表
     */
    public function getDiseaseByDepartment($departArr=array(), $order='dsm.id', $offset=0, $size=12){
        $class_level = $departArr['level']==1 ? 'class_level1' : 'class_level2';
        $level1 = $departArr['level']==1 ? $departArr['class_level1'] : $departArr['class_level2'];
        
        $sql = " SELECT dsm.id, dsm.name, dsm.pinyin, dsm.pinyin_initial ";
        $sql .= " FROM `9939_depart_rel_merge` drm, `9939_disease_symptom_merge` dsm";
        $sql .= " WHERE drm.unique_key = dsm.unique_key AND drm.source_flag = 1 AND drm.{$class_level} = {$level1} ORDER BY {$order} LIMIT {$offset}, {$size}";
        return $this->_db->fetchAll($sql);
    }
}