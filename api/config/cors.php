<?php

return [

    'paths' => ['api/*', 'sanctum/csrf-cookie'],

    'allowed_methods' => ['*'],

    'allowed_origins' => ['http://localhost:9000', 'http://192.168.1.105:9000'],

    'allowed_origins_patterns' => ['*'],

    'allowed_headers' => ['*'],

    'supports_credentials' => true,

];
