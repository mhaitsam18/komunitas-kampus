<?php
defined('BASEPATH') or exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;

$db['default'] = array(
    'dsn'    => '',
    // 'hostname' => 'haloryan.com',
    'hostname' => 'localhost',
    // 'username' => 'u6049187_11347_arina',
    'username' => 'root',
    // 'password' => 'arina',
    'password' => '',
    // 'database' => 'u6049187_11347_arina',
    'database' => 'bismillah',
    'dbdriver' => 'mysqli',
    'dbprefix' => '',
    'pconnect' => FALSE,
    'db_debug' => (ENVIRONMENT !== 'production'),
    'cache_on' => FALSE,
    'cachedir' => '',
    'char_set' => 'utf8',
    'dbcollat' => 'utf8_general_ci',
    'swap_pre' => '',
    'encrypt' => FALSE,
    'compress' => FALSE,
    'stricton' => FALSE,
    'failover' => array(),
    'save_queries' => TRUE
);
