<?php

function check($email){
    $split = str_split($email); 

    for ($i=0; $i < count($split); $i++) { 
        if($split[$i] === '@')
        {
            "O E-mail é válido";
        } else {
            "O E-mail não é válido";
            
        }
    }


}

echo check('gabikochem55@gmail.com');