<?php
  
function getCount(string $str): int {
    $total = 0;
    $vowels = array(
        'a',
        'e',
        'i',
        'o',
        'u',

    );

    $split = str_split($str);
    
    if($str !== null)
    {
        foreach ($vowels as $i => $val) {
            for ($i=0; $i < count($split); $i++) { 
                if($split[$i] == $val)
                {
                    $total += 1;
                }
            }
        }
        return $total;

    } else {
        return 0;
    }
}

echo getCount('abracadabra');