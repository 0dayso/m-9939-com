<?php

/**
 * 功能：PHP 相关信息
 * 
 * @author gaoqing
 *         2015年6月26日
 *        
 */

$data = file_get_contents("localstorage.json");

$json = json_decode($data, true);

$result = json_encode($json);

//动态执行回调函数
$callback=$_GET['callback'];
echo $callback."($result)";

?>

