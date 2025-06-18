<?php

$request = $_SERVER['REQUEST_URI'];

switch ($request) {
    case '/':
        require __DIR__ . '/pages/home.php';
        break;
    
    case '/contato':
        require __DIR__ .  '/pages/contacts.php';
        break;  
    default:
        # code...
        break;
}