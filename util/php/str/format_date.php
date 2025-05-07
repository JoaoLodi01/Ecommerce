<?php

$start = '20/02/2025';

echo date('Y-m-d', strtotime(str_replace('/', '-', $start)));