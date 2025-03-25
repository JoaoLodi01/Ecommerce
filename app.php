<?php

use Illuminate\Support\Facades\DB;

$customer = DB::table('customer')->first();

$customer->name;