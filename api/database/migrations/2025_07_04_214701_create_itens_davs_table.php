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
        Schema::create('itens_davs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('iten_dav_cod')->index();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');

            $table->foreign('dav_cod')->references('dav_cod')->on('davs')->onDelete('cascade');
            $table->unsignedBigInteger('dav_cod');
            $table->foreign('product_cod')->references('product_cod')->on('products')->onDelete('cascade');
            $table->unsignedBigInteger('product_cod');
            $table->string('product', 120);
            $table->decimal('cost_price', 16,2);
            $table->decimal('sale_price', 16,2);
            $table->string('unit', 4);        
            $table->float('amount');
            $table->decimal('addition', 16,2)->nullable();
            $table->decimal('discount', 16,2)->nullable();
            $table->decimal('gross_value', 16,2);
            $table->decimal('net_value', 16,2);
            $table->string('status', 60)->nullable()->default('Pendente');
            $table->boolean('finished', 1)->default(0);
            $table->boolean('canceled', 1)->default(0);
            $table->string('type', 20);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('itens_davs');
    }
};
