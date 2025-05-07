<?php

$email = 'tesTE.@gmail';

echo strpos(strtolower($email), '@') ? "Tem @" : "Não tem @";
