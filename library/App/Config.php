<?php

require_once 'Zend/Db.php';
require_once 'Zend/Db/Table.php';

$params = array (
    'host'     => '192.168.28.50',
    'username' => 'root',
    'password' => '123456',
    'dbname'   => '9939_com_dzjb',
	'charset'  => 'utf8'
);

$db = Zend_Db::factory('PDO_MYSQL', $params);
Zend_Db_Table::setDefaultAdapter($db);

$params_zx = array (
    'host'     => '192.168.28.50',
    'username' => 'root',
    'password' => '123456',
    'dbname'   => '9939_com_v2',
	'charset'  => 'utf8'
);
$dbzx = Zend_Db::factory('PDO_MYSQL', $params_zx);
$GLOBALS['dbzx']=$dbzx;

$params_wd = array (
    'host'     => '192.168.28.50',
    'username' => 'root',
    'password' => '123456',
    'dbname'   => '9939_com_v2sns',
	'charset'  => 'utf8'
);
$dbwd = Zend_Db::factory('PDO_MYSQL', $params_wd);
$GLOBALS['dbwd']=$dbwd;