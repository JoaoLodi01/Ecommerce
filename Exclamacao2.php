<?php

function remove(string $s, int $n) {
    $formated = str_split($s);
    array_filter($formated, function ($k){
        echo $k === '!';

    });
}

echo remove('Hi!!!', 1);