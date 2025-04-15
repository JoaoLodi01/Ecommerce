<?php

function setAlarm(bool $employed, bool $vacation){
    if(
        $employed === true &&
        $vacation === true ||
        $employed === false &&
        $vacation === false 
        
    ) {
        return 'false';
    } else {
        return 'true';
    }

}

echo setAlarm(false, false);