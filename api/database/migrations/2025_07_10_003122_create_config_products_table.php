<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('config_products', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->unsignedBigInteger('config_product_cod');
            $table->float('default_profit_percentage')->default(100.00);
            $table->boolean('validate_gtin')->default(false);
            $table->boolean('reserve_dav_quantity')->default(false);
            $table->boolean('allow_profit_zero')->default(false);
            $table->timestamps();
            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('config_products');
    }
};
