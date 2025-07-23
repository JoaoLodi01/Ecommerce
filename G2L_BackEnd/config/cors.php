<?php

return [

    'paths' => ['api/*', 'sanctum/csrf-cookie'], 

    'allowed_methods' => ['*'],

    'allowed_origins' => ['http://192.168.1.105:9000', '*'],

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => true,
    
];
