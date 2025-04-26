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
        Schema::create('itens_pdvs', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->unsignedBigInteger('pdv_id');
            $table->foreign('pdv_id')->references('id')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('product_id');
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
            $table->string('product', 120);
            $table->decimal('cost_price', 16,2);
            $table->decimal('sale_price', 16,2);
            $table->string('cfop', 4);
            $table->string('csosn', 3);
            $table->string('ncm', 8);
            $table->string('cest', 7);
            $table->string('unit', 4);        
            $table->float('amount');
            $table->decimal('addition', 16,2)->nullable();
            $table->decimal('discount', 16,2)->nullable();
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->string('seller', 255);
            $table->string('is_nfce_nm', 4)->nullable();
            $table->boolean('finished', 1)->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('itens_pdvs');
    }
};
