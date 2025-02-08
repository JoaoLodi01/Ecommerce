<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pay_ment_methods', function (Blueprint $table) {
            $table->id();
            $table->string('payment_method', 100);
            $table->float('amount_paid', 10, 2);
            $table->unsignedBigInteger('customer_id');
            $table->foreign('customer_id')->references('id')->on('customers')->onDelete('cascade');
            $table->string('customer', 120); 
            $table->date('payment_period');
            $table->timestamps();

        });
    }
    
    public function down(): void
    {
        Schema::dropIfExists('pay_ment_methods');
    }
};
