<?php

app('router')->setCompiledRoutes(
    array (
  'compiled' => 
  array (
    0 => false,
    1 => 
    array (
      '/sanctum/csrf-cookie' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'sanctum.csrf-cookie',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/auth/auth' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::IfIMJpn37GTzHIb8',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/auth/logout' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::jeSZXtEaUi1Lh71q',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/auth/me' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::h0ejwzSSbtEzT4Wb',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/products/all' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::oqamrJ6U5hX5X9Aa',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/products/search' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::NP2735jpytX49d2e',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/products/create' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::2sgZA65MAMPandSh',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/consumers/all' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::5NgRtZm8C6kFZIeQ',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/consumers/create' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::PhLbFtzafaffAXUW',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/cash-register/all' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::MIMr8725gRcqO8uA',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/cash-register/all/receive' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::SfX2FmbNxSlErpbK',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/cash-register/create' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::vKqWswfzxOqBepql',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/pdv/save-sale' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::WvhLoI2bN79UKvro',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/pdv/all' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::tqE0eRi4CF0Dlj5S',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/pdv/get-saved-sales' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::dKbUs9oiMb8AjmNr',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/payments/all' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::0vk71xNV4xdNhhYP',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/ecommerce/payments/create' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::012YV31VTc9oKG1L',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/all' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::vfPryeIpYs9sLEYG',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/find' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::QkFIOZ4FejRBuM6z',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/create' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::co068WWzc9olJDPd',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/room' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::ni7XuXxuK2Ds0zf5',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/stay/rooms' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::Spa6RDrx7x2Nl1l8',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/stay/room' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::G4m3ivnrKeL099A5',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/stay/check-in' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::DGttDlNnPqvqF5IZ',
          ),
          1 => NULL,
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/stay/reservation' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::Og9hUGuA4V6Zgpzb',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/hotel/stay/check-reservation' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::aryuR0hj8jBho9dZ',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/config/config-hotel/set-config' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::XN4hTTwghiw93sxR',
          ),
          1 => NULL,
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/config/config-hotel/get-config' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::T4BV3twc5UOY40WK',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/customers/all' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::hYpAyHqJxr2dYYiV',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/customers/selectClient' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::7kFNrySzcvkWJz3C',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/customers/create' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::LJSnQVgjOTcyS9tc',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/users/all' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::j9IddiUYcmZ63WEc',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/users/selectSeller' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::CGRdvwbTXf21OOv5',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/users/create' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::an1IEvS9MPAhTJep',
          ),
          1 => NULL,
          2 => 
          array (
            'POST' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/v1/get-ip' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::bc5gXxjwGcAD0lQs',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/api/php-info' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'php.info',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      '/up' => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::bn4xHZlttS36MrhI',
          ),
          1 => NULL,
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
    ),
    2 => 
    array (
      0 => '{^(?|/api/v1/(?|ecommerce/(?|p(?|roducts/([^/]++)(?|(*:54)|/deactivate(*:72))|dv/(?|finalize\\-sale/([^/]++)(*:109)|get\\-saved\\-sale/([^/]++)(*:142))|ayments/([^/]++)(?|(*:170)|/deactivate(*:189)))|c(?|onsumers/([^/]++)(?|(*:223)|/deactivate(*:242))|ash\\-register/([^/]++)(?|(*:276)|/deactivate(*:295))))|customers/([^/]++)(?|(*:327)|/deactivate(*:346))|users/([^/]++)(?|(*:372)|/deactivate(*:391)))|/storage/(.*)(*:414))/?$}sDu',
    ),
    3 => 
    array (
      54 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::j69D5qXTGeWg0yJU',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
        1 => 
        array (
          0 => 
          array (
            '_route' => 'generated::RpXEeKnuHsNixCMq',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
      ),
      72 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::JxorH8I0fNOTZ94u',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      109 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::VoTd5ib46P0qZmB3',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
      ),
      142 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::seYpqWSDew7y9FNU',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
      ),
      170 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::ef3HbK0YX4ctAi9r',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
        1 => 
        array (
          0 => 
          array (
            '_route' => 'generated::vc4ZmCMBgRJukoWZ',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
      ),
      189 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::r7gPVvZ1sjczzYIE',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      223 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::zbULThdqhuVJzmSE',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
        1 => 
        array (
          0 => 
          array (
            '_route' => 'generated::xtlNV88HuiNtczMI',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
      ),
      242 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::YAJrxMVbyVMk0jOz',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'DELETE' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      276 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::pc5YLCO8LWAbaWgO',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
        1 => 
        array (
          0 => 
          array (
            '_route' => 'generated::k7z7UzkThuS5yL9e',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
      ),
      295 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::l1rETlX5vBv9zNfS',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'DELETE' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      327 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::cge6gvC1Lsm7E826',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
        1 => 
        array (
          0 => 
          array (
            '_route' => 'generated::5gdNpjvF2KFAMMnA',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
      ),
      346 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::PyWpSa7MLbWqStqW',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'DELETE' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      372 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::zGVJFTjFEMuvq2EM',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
        1 => 
        array (
          0 => 
          array (
            '_route' => 'generated::KX0NFylyHSpqamvB',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'PUT' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
      ),
      391 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'generated::uCTtrNgM7y2wZejn',
          ),
          1 => 
          array (
            0 => 'id',
          ),
          2 => 
          array (
            'DELETE' => 0,
          ),
          3 => NULL,
          4 => false,
          5 => false,
          6 => NULL,
        ),
      ),
      414 => 
      array (
        0 => 
        array (
          0 => 
          array (
            '_route' => 'storage.local',
          ),
          1 => 
          array (
            0 => 'path',
          ),
          2 => 
          array (
            'GET' => 0,
            'HEAD' => 1,
          ),
          3 => NULL,
          4 => false,
          5 => true,
          6 => NULL,
        ),
        1 => 
        array (
          0 => NULL,
          1 => NULL,
          2 => NULL,
          3 => NULL,
          4 => false,
          5 => false,
          6 => 0,
        ),
      ),
    ),
    4 => NULL,
  ),
  'attributes' => 
  array (
    'sanctum.csrf-cookie' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'sanctum/csrf-cookie',
      'action' => 
      array (
        'uses' => 'Laravel\\Sanctum\\Http\\Controllers\\CsrfCookieController@show',
        'controller' => 'Laravel\\Sanctum\\Http\\Controllers\\CsrfCookieController@show',
        'namespace' => NULL,
        'prefix' => 'sanctum',
        'where' => 
        array (
        ),
        'middleware' => 
        array (
          0 => 'web',
        ),
        'as' => 'sanctum.csrf-cookie',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::IfIMJpn37GTzHIb8' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/auth/auth',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
        ),
        'uses' => 'App\\Http\\Controllers\\Auth\\AuthController@auth',
        'controller' => 'App\\Http\\Controllers\\Auth\\AuthController@auth',
        'namespace' => NULL,
        'prefix' => 'api/v1/auth',
        'where' => 
        array (
        ),
        'as' => 'generated::IfIMJpn37GTzHIb8',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::jeSZXtEaUi1Lh71q' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/auth/logout',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
        ),
        'uses' => 'App\\Http\\Controllers\\Auth\\AuthController@logout',
        'controller' => 'App\\Http\\Controllers\\Auth\\AuthController@logout',
        'namespace' => NULL,
        'prefix' => 'api/v1/auth',
        'where' => 
        array (
        ),
        'as' => 'generated::jeSZXtEaUi1Lh71q',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::h0ejwzSSbtEzT4Wb' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/auth/me',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'O:55:"Laravel\\SerializableClosure\\UnsignedSerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:0:{}s:8:"function";s:309:"function (\\Illuminate\\Http\\Request $request) {
            return \\response()->json([
                \'success\' => $request->header(\'Authorization\') ? true: false,
                \'user\' => $request->user(),
                \'token_received\' => $request->header(\'Authorization\'),
    
            ]);
        }";s:5:"scope";s:37:"Illuminate\\Routing\\RouteFileRegistrar";s:4:"this";N;s:4:"self";s:32:"000000000000031a0000000000000000";}}',
        'namespace' => NULL,
        'prefix' => 'api/v1/auth',
        'where' => 
        array (
        ),
        'as' => 'generated::h0ejwzSSbtEzT4Wb',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::oqamrJ6U5hX5X9Aa' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/products/all',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@getAll',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@getAll',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/products',
        'where' => 
        array (
        ),
        'as' => 'generated::oqamrJ6U5hX5X9Aa',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::NP2735jpytX49d2e' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/ecommerce/products/search',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@search',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@search',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/products',
        'where' => 
        array (
        ),
        'as' => 'generated::NP2735jpytX49d2e',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::2sgZA65MAMPandSh' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/ecommerce/products/create',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@store',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@store',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/products',
        'where' => 
        array (
        ),
        'as' => 'generated::2sgZA65MAMPandSh',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::j69D5qXTGeWg0yJU' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/products/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@findByID',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@findByID',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/products',
        'where' => 
        array (
        ),
        'as' => 'generated::j69D5qXTGeWg0yJU',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::RpXEeKnuHsNixCMq' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/ecommerce/products/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@update',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@update',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/products',
        'where' => 
        array (
        ),
        'as' => 'generated::RpXEeKnuHsNixCMq',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::JxorH8I0fNOTZ94u' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/ecommerce/products/{id}/deactivate',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@delete',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\ProductsController@delete',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/products',
        'where' => 
        array (
        ),
        'as' => 'generated::JxorH8I0fNOTZ94u',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::5NgRtZm8C6kFZIeQ' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/consumers/all',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@getAll',
        'controller' => 'App\\Http\\Controllers\\CustomerController@getAll',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/consumers',
        'where' => 
        array (
        ),
        'as' => 'generated::5NgRtZm8C6kFZIeQ',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::PhLbFtzafaffAXUW' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/ecommerce/consumers/create',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@store',
        'controller' => 'App\\Http\\Controllers\\CustomerController@store',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/consumers',
        'where' => 
        array (
        ),
        'as' => 'generated::PhLbFtzafaffAXUW',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::zbULThdqhuVJzmSE' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/consumers/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@findByID',
        'controller' => 'App\\Http\\Controllers\\CustomerController@findByID',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/consumers',
        'where' => 
        array (
        ),
        'as' => 'generated::zbULThdqhuVJzmSE',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::xtlNV88HuiNtczMI' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/ecommerce/consumers/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@update',
        'controller' => 'App\\Http\\Controllers\\CustomerController@update',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/consumers',
        'where' => 
        array (
        ),
        'as' => 'generated::xtlNV88HuiNtczMI',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::YAJrxMVbyVMk0jOz' => 
    array (
      'methods' => 
      array (
        0 => 'DELETE',
      ),
      'uri' => 'api/v1/ecommerce/consumers/{id}/deactivate',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@delete',
        'controller' => 'App\\Http\\Controllers\\CustomerController@delete',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/consumers',
        'where' => 
        array (
        ),
        'as' => 'generated::YAJrxMVbyVMk0jOz',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::MIMr8725gRcqO8uA' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/cash-register/all',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@getAll',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@getAll',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/cash-register',
        'where' => 
        array (
        ),
        'as' => 'generated::MIMr8725gRcqO8uA',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::SfX2FmbNxSlErpbK' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/cash-register/all/receive',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@getAllReceive',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@getAllReceive',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/cash-register',
        'where' => 
        array (
        ),
        'as' => 'generated::SfX2FmbNxSlErpbK',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::vKqWswfzxOqBepql' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/ecommerce/cash-register/create',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@store',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@store',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/cash-register',
        'where' => 
        array (
        ),
        'as' => 'generated::vKqWswfzxOqBepql',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::pc5YLCO8LWAbaWgO' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/cash-register/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@findByID',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@findByID',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/cash-register',
        'where' => 
        array (
        ),
        'as' => 'generated::pc5YLCO8LWAbaWgO',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::k7z7UzkThuS5yL9e' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/ecommerce/cash-register/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@update',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@update',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/cash-register',
        'where' => 
        array (
        ),
        'as' => 'generated::k7z7UzkThuS5yL9e',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::l1rETlX5vBv9zNfS' => 
    array (
      'methods' => 
      array (
        0 => 'DELETE',
      ),
      'uri' => 'api/v1/ecommerce/cash-register/{id}/deactivate',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@delete',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\CashRegisterController@delete',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/cash-register',
        'where' => 
        array (
        ),
        'as' => 'generated::l1rETlX5vBv9zNfS',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::WvhLoI2bN79UKvro' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/ecommerce/pdv/save-sale',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@saveSale',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@saveSale',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/pdv',
        'where' => 
        array (
        ),
        'as' => 'generated::WvhLoI2bN79UKvro',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::VoTd5ib46P0qZmB3' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/ecommerce/pdv/finalize-sale/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@finalizeSale',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@finalizeSale',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/pdv',
        'where' => 
        array (
        ),
        'as' => 'generated::VoTd5ib46P0qZmB3',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::tqE0eRi4CF0Dlj5S' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/pdv/all',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@getAll',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@getAll',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/pdv',
        'where' => 
        array (
        ),
        'as' => 'generated::tqE0eRi4CF0Dlj5S',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::dKbUs9oiMb8AjmNr' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/pdv/get-saved-sales',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@findSavePDV',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@findSavePDV',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/pdv',
        'where' => 
        array (
        ),
        'as' => 'generated::dKbUs9oiMb8AjmNr',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::seYpqWSDew7y9FNU' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/pdv/get-saved-sale/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@findSavePDVByID',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PDVController@findSavePDVByID',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/pdv',
        'where' => 
        array (
        ),
        'as' => 'generated::seYpqWSDew7y9FNU',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::0vk71xNV4xdNhhYP' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/payments/all',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@getAll',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@getAll',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/payments',
        'where' => 
        array (
        ),
        'as' => 'generated::0vk71xNV4xdNhhYP',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::012YV31VTc9oKG1L' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/ecommerce/payments/create',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@store',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@store',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/payments',
        'where' => 
        array (
        ),
        'as' => 'generated::012YV31VTc9oKG1L',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::ef3HbK0YX4ctAi9r' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/ecommerce/payments/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@findByID',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@findByID',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/payments',
        'where' => 
        array (
        ),
        'as' => 'generated::ef3HbK0YX4ctAi9r',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::vc4ZmCMBgRJukoWZ' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/ecommerce/payments/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@update',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@update',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/payments',
        'where' => 
        array (
        ),
        'as' => 'generated::vc4ZmCMBgRJukoWZ',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::r7gPVvZ1sjczzYIE' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/ecommerce/payments/{id}/deactivate',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@delete',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\PaymentsController@delete',
        'namespace' => NULL,
        'prefix' => 'api/v1/ecommerce/payments',
        'where' => 
        array (
        ),
        'as' => 'generated::r7gPVvZ1sjczzYIE',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::vfPryeIpYs9sLEYG' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/hotel/all',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\HotelController@allHotel',
        'controller' => 'App\\Http\\Controllers\\HotelController\\HotelController@allHotel',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel',
        'where' => 
        array (
        ),
        'as' => 'generated::vfPryeIpYs9sLEYG',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::QkFIOZ4FejRBuM6z' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/hotel/find',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\HotelController@findHotel',
        'controller' => 'App\\Http\\Controllers\\HotelController\\HotelController@findHotel',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel',
        'where' => 
        array (
        ),
        'as' => 'generated::QkFIOZ4FejRBuM6z',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::co068WWzc9olJDPd' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/hotel/create',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\HotelController@create',
        'controller' => 'App\\Http\\Controllers\\HotelController\\HotelController@create',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel',
        'where' => 
        array (
        ),
        'as' => 'generated::co068WWzc9olJDPd',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::ni7XuXxuK2Ds0zf5' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/hotel/room',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\RoomController@find',
        'controller' => 'App\\Http\\Controllers\\HotelController\\RoomController@find',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel',
        'where' => 
        array (
        ),
        'as' => 'generated::ni7XuXxuK2Ds0zf5',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::Spa6RDrx7x2Nl1l8' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/hotel/stay/rooms',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\RoomController@allRooms',
        'controller' => 'App\\Http\\Controllers\\HotelController\\RoomController@allRooms',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel/stay',
        'where' => 
        array (
        ),
        'as' => 'generated::Spa6RDrx7x2Nl1l8',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::G4m3ivnrKeL099A5' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/hotel/stay/room',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\RoomController@create',
        'controller' => 'App\\Http\\Controllers\\HotelController\\RoomController@create',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel/stay',
        'where' => 
        array (
        ),
        'as' => 'generated::G4m3ivnrKeL099A5',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::DGttDlNnPqvqF5IZ' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/hotel/stay/check-in',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\RoomController@checkIn',
        'controller' => 'App\\Http\\Controllers\\HotelController\\RoomController@checkIn',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel/stay',
        'where' => 
        array (
        ),
        'as' => 'generated::DGttDlNnPqvqF5IZ',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::Og9hUGuA4V6Zgpzb' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/hotel/stay/reservation',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\RoomController@reservation',
        'controller' => 'App\\Http\\Controllers\\HotelController\\RoomController@reservation',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel/stay',
        'where' => 
        array (
        ),
        'as' => 'generated::Og9hUGuA4V6Zgpzb',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::aryuR0hj8jBho9dZ' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/hotel/stay/check-reservation',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\HotelController\\RoomController@checkReservation',
        'controller' => 'App\\Http\\Controllers\\HotelController\\RoomController@checkReservation',
        'namespace' => NULL,
        'prefix' => 'api/v1/hotel/stay',
        'where' => 
        array (
        ),
        'as' => 'generated::aryuR0hj8jBho9dZ',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::XN4hTTwghiw93sxR' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/config/config-hotel/set-config',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\ConfigController@update',
        'controller' => 'App\\Http\\Controllers\\ConfigController@update',
        'namespace' => NULL,
        'prefix' => 'api/v1/config/config-hotel',
        'where' => 
        array (
        ),
        'as' => 'generated::XN4hTTwghiw93sxR',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::T4BV3twc5UOY40WK' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/config/config-hotel/get-config',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\ConfigController@getConfigs',
        'controller' => 'App\\Http\\Controllers\\ConfigController@getConfigs',
        'namespace' => NULL,
        'prefix' => 'api/v1/config/config-hotel',
        'where' => 
        array (
        ),
        'as' => 'generated::T4BV3twc5UOY40WK',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::hYpAyHqJxr2dYYiV' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/customers/all',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@getAll',
        'controller' => 'App\\Http\\Controllers\\CustomerController@getAll',
        'namespace' => NULL,
        'prefix' => 'api/v1/customers',
        'where' => 
        array (
        ),
        'as' => 'generated::hYpAyHqJxr2dYYiV',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::7kFNrySzcvkWJz3C' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/customers/selectClient',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@selectClient',
        'controller' => 'App\\Http\\Controllers\\CustomerController@selectClient',
        'namespace' => NULL,
        'prefix' => 'api/v1/customers',
        'where' => 
        array (
        ),
        'as' => 'generated::7kFNrySzcvkWJz3C',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::LJSnQVgjOTcyS9tc' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/customers/create',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@store',
        'controller' => 'App\\Http\\Controllers\\CustomerController@store',
        'namespace' => NULL,
        'prefix' => 'api/v1/customers',
        'where' => 
        array (
        ),
        'as' => 'generated::LJSnQVgjOTcyS9tc',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::cge6gvC1Lsm7E826' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/customers/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@findByID',
        'controller' => 'App\\Http\\Controllers\\CustomerController@findByID',
        'namespace' => NULL,
        'prefix' => 'api/v1/customers',
        'where' => 
        array (
        ),
        'as' => 'generated::cge6gvC1Lsm7E826',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::5gdNpjvF2KFAMMnA' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/customers/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@update',
        'controller' => 'App\\Http\\Controllers\\CustomerController@update',
        'namespace' => NULL,
        'prefix' => 'api/v1/customers',
        'where' => 
        array (
        ),
        'as' => 'generated::5gdNpjvF2KFAMMnA',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::PyWpSa7MLbWqStqW' => 
    array (
      'methods' => 
      array (
        0 => 'DELETE',
      ),
      'uri' => 'api/v1/customers/{id}/deactivate',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\CustomerController@delete',
        'controller' => 'App\\Http\\Controllers\\CustomerController@delete',
        'namespace' => NULL,
        'prefix' => 'api/v1/customers',
        'where' => 
        array (
        ),
        'as' => 'generated::PyWpSa7MLbWqStqW',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::j9IddiUYcmZ63WEc' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/users/all',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\UserController@getAll',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\UserController@getAll',
        'namespace' => NULL,
        'prefix' => 'api/v1/users',
        'where' => 
        array (
        ),
        'as' => 'generated::j9IddiUYcmZ63WEc',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::CGRdvwbTXf21OOv5' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/users/selectSeller',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\UserController@selectSeller',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\UserController@selectSeller',
        'namespace' => NULL,
        'prefix' => 'api/v1/users',
        'where' => 
        array (
        ),
        'as' => 'generated::CGRdvwbTXf21OOv5',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::an1IEvS9MPAhTJep' => 
    array (
      'methods' => 
      array (
        0 => 'POST',
      ),
      'uri' => 'api/v1/users/create',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\UserController@create',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\UserController@create',
        'namespace' => NULL,
        'prefix' => 'api/v1/users',
        'where' => 
        array (
        ),
        'as' => 'generated::an1IEvS9MPAhTJep',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::zGVJFTjFEMuvq2EM' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/users/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\UserController@findByID',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\UserController@findByID',
        'namespace' => NULL,
        'prefix' => 'api/v1/users',
        'where' => 
        array (
        ),
        'as' => 'generated::zGVJFTjFEMuvq2EM',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::KX0NFylyHSpqamvB' => 
    array (
      'methods' => 
      array (
        0 => 'PUT',
      ),
      'uri' => 'api/v1/users/{id}',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\UserController@update',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\UserController@update',
        'namespace' => NULL,
        'prefix' => 'api/v1/users',
        'where' => 
        array (
        ),
        'as' => 'generated::KX0NFylyHSpqamvB',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::uCTtrNgM7y2wZejn' => 
    array (
      'methods' => 
      array (
        0 => 'DELETE',
      ),
      'uri' => 'api/v1/users/{id}/deactivate',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
          1 => 'auth:sanctum',
        ),
        'uses' => 'App\\Http\\Controllers\\EcommerceController\\UserController@delete',
        'controller' => 'App\\Http\\Controllers\\EcommerceController\\UserController@delete',
        'namespace' => NULL,
        'prefix' => 'api/v1/users',
        'where' => 
        array (
        ),
        'as' => 'generated::uCTtrNgM7y2wZejn',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::bc5gXxjwGcAD0lQs' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/v1/get-ip',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
        ),
        'uses' => 'App\\Http\\Controllers\\IPController@create',
        'controller' => 'App\\Http\\Controllers\\IPController@create',
        'namespace' => NULL,
        'prefix' => 'api/v1',
        'where' => 
        array (
        ),
        'as' => 'generated::bc5gXxjwGcAD0lQs',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'php.info' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'api/php-info',
      'action' => 
      array (
        'middleware' => 
        array (
          0 => 'api',
        ),
        'uses' => 'O:55:"Laravel\\SerializableClosure\\UnsignedSerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:0:{}s:8:"function";s:37:"function (){
    return \\phpinfo();
}";s:5:"scope";s:37:"Illuminate\\Routing\\RouteFileRegistrar";s:4:"this";N;s:4:"self";s:32:"00000000000003100000000000000000";}}',
        'namespace' => NULL,
        'prefix' => 'api',
        'where' => 
        array (
        ),
        'as' => 'php.info',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'generated::bn4xHZlttS36MrhI' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'up',
      'action' => 
      array (
        'uses' => 'O:55:"Laravel\\SerializableClosure\\UnsignedSerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:0:{}s:8:"function";s:852:"function () {
                    $exception = null;

                    try {
                        \\Illuminate\\Support\\Facades\\Event::dispatch(new \\Illuminate\\Foundation\\Events\\DiagnosingHealth);
                    } catch (\\Throwable $e) {
                        if (app()->hasDebugModeEnabled()) {
                            throw $e;
                        }

                        report($e);

                        $exception = $e->getMessage();
                    }

                    return response(\\Illuminate\\Support\\Facades\\View::file(\'C:\\\\Gabriel\\\\Projetos\\\\SGBR\\\\1_Hotel_Ecommerce\\\\api\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Foundation\\\\Configuration\'.\'/../resources/health-up.blade.php\', [
                        \'exception\' => $exception,
                    ]), status: $exception ? 500 : 200);
                }";s:5:"scope";s:54:"Illuminate\\Foundation\\Configuration\\ApplicationBuilder";s:4:"this";N;s:4:"self";s:32:"00000000000003140000000000000000";}}',
        'as' => 'generated::bn4xHZlttS36MrhI',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
    'storage.local' => 
    array (
      'methods' => 
      array (
        0 => 'GET',
        1 => 'HEAD',
      ),
      'uri' => 'storage/{path}',
      'action' => 
      array (
        'uses' => 'O:55:"Laravel\\SerializableClosure\\UnsignedSerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:3:{s:4:"disk";s:5:"local";s:6:"config";a:5:{s:6:"driver";s:5:"local";s:4:"root";s:66:"C:\\Gabriel\\Projetos\\SGBR\\1_Hotel_Ecommerce\\api\\storage\\app/private";s:5:"serve";b:1;s:5:"throw";b:0;s:6:"report";b:0;}s:12:"isProduction";b:0;}s:8:"function";s:323:"function (\\Illuminate\\Http\\Request $request, string $path) use ($disk, $config, $isProduction) {
                    return (new \\Illuminate\\Filesystem\\ServeFile(
                        $disk,
                        $config,
                        $isProduction
                    ))($request, $path);
                }";s:5:"scope";s:47:"Illuminate\\Filesystem\\FilesystemServiceProvider";s:4:"this";N;s:4:"self";s:32:"000000000000031d0000000000000000";}}',
        'as' => 'storage.local',
      ),
      'fallback' => false,
      'defaults' => 
      array (
      ),
      'wheres' => 
      array (
        'path' => '.*',
      ),
      'bindingFields' => 
      array (
      ),
      'lockSeconds' => NULL,
      'waitSeconds' => NULL,
      'withTrashed' => false,
    ),
  ),
)
);
