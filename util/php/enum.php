<?php

enum Senioridade
{
    case Junior;
    case Pleno;
    case Senior;
}

$nivel = Senioridade::cases();
print_r($nivel);
