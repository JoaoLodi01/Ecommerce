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
            $table->unsignedBigInteger('iten_pdv_code');
            $table->unique(['issuer_id', 'iten_pdv_code']);

            $table->unsignedBigInteger('issuer_id');
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');

            $table->unsignedBigInteger('pdv_code');
            $table->foreign('pdv_code')->references('pdv_code')->on('pdvs')->onDelete('cascade');

            $table->unsignedBigInteger('product_code');
            $table->foreign('product_code')->references('product_code')->on('products')->onDelete('cascade');

            $table->string('product', 120);
            $table->decimal('cost_price', 16,2);
            $table->decimal('sale_price', 16,2);
            $table->string('cfop', 4)->nullable();;
            $table->string('csosncst', 3)->nullable();;
            $table->string('ncm', 8)->nullable();;
            $table->string('cest', 7)->nullable();;
            $table->string('unit', 4);        
            $table->float('amount', 16,2);
            $table->decimal('addition', 16,2)->nullable();
            $table->decimal('discount', 16,2)->nullable();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->unsignedBigInteger('user_id');
            $table->string('seller', 120);
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
