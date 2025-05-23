<?php
$str = <<<EOD

000087
000088
000082
000096
0
000084
000085
000086
000083


EOD;

echo str_replace(["\r\n", "\r", "\n"], ",", trim($str));