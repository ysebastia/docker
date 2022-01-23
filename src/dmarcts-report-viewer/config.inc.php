<?php

ini_set('display_errors', 'Off');
error_reporting(E_ALL & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE);

/* Ensure we got the environment */
$vars = array(
    'DMARCTS_DBHOST',
    'DMARCTS_DBNAME',
    'DMARCTS_DBUSER',
    'DMARCTS_DBPASS',
    'DMARCTS_DBPORT',
    'DMARCTS_CSS',
    'DMARCTS_LOOKUP',
    'DMARCTS_SORT',
);

foreach ($vars as $var) {
    $env = getenv($var);
    if (!isset($_ENV[$var]) && $env !== false) {
        $_ENV[$var] = $env;
    }
}

/* Database */
if (isset($_ENV['DMARCTS_DBHOST'])) {
    $dbhost = trim($_ENV['DMARCTS_DBHOST']);
} else {
    $dbhost="localhost";
}
if (isset($_ENV['DMARCTS_DBNAME'])) {
    $dbname = trim($_ENV['DMARCTS_DBNAME']);
} else {
    $dbname = "dmarc";
}
if (isset($_ENV['DMARCTS_DBUSER'])) {
    $dbuser = trim($_ENV['DMARCTS_DBUSER']);
} else {
    $dbuser = "dmarc";
}
if (isset($_ENV['DMARCTS_DBPASS'])) {
    $dbpass = trim($_ENV['DMARCTS_DBPASS']);
}
if (isset($_ENV['DMARCTS_DBPORT'])) {
    $dbport = trim($_ENV['DMARCTS_DBPORT']);
} else {
    $dbport = "3306";
}

/* CSS */
if (isset($_ENV['DMARCTS_CSS'])) {
    $cssfile = trim($_ENV['DMARCTS_CSS']);
} else {
    $cssfile = "default.css";
}

/* Lookup */
if (isset($_ENV['DMARCTS_LOOKUP'])) {
    $default_lookup = trim($_ENV['DMARCTS_LOOKUP']);
} else {
    $default_lookup = 1; // 1=on 0=off (on is old behaviour )
}

/* Sort */
if (isset($_ENV['DMARCTS_SORT'])) {
    $default_sort = trim($_ENV['DMARCTS_SORT']);
} else {
    $default_sort = 1;  # 1=ASCdening 0=DESCending (ASCending is default behaviour )
}
