<?php
  
function findDifference(array $a, array $b): int {
  $total_a = 1;
  $total_b = 1;

  for ($i=0; $i < count($a); $i++) { 
    $total_a *= $a[$i];
  }

  for ($i=0; $i < count($b); $i++) { 
    $total_b *= $b[$i];
  }

  return $total_a > $total_b ? $total_a - $total_b : $total_b - $total_a;

}

echo findDifference([3, 2, 5], [1, 4, 4]);