<?php

function duck_duck_goose($players, $goose) {
    $i = ($goose - 1) % count($players);
    return $players[$i]['name'];
}

print_r(duck_duck_goose([['name' => 'Laura'], ['name' => 'Gabriel'], ['name' => 'Gabriel 2']], 5));