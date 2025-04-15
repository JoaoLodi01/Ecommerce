<?php
  
function reverseSeq (int $n): array {
    $result = [];
    while ($n > 0) {
        $n--;
        array_push($result, $n + 1);
    }
    return $result; 
};

print_r(reverseSeq(5));