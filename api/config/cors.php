<?php

return [
    'paths' => ['api/*', 'sanctum/csrf-cookie'], // Rotas que devem permitir CORS

    'allowed_methods' => ['*'], // Permitir qualquer método HTTP (GET, POST, PUT, DELETE, etc.)

    'allowed_origins' => ['http://localhost:5173'], // Permitir qualquer origem. Substitua '*' por origens específicas se necessário.

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'], // Permitir qualquer cabeçalho

    'exposed_headers' => [],

    'max_age' => 0, // Tempo em segundos que o navegador pode armazenar a resposta CORS

    'supports_credentials' => false, // Altere para true se estiver utilizando cookies ou credenciais
];