<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('product_code');
            $table->unique(['issuer_id', 'product_code']);
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('product', 120);
            $table->string('barcode', 14)->unique();
            $table->unique(['issuer_id', 'barcode']);
            $table->string('barcode_internal', 16)->unique();
            $table->unique(['issuer_id', 'barcode_internal']);
            $table->binary('image')->nullable();
            $table->unsignedBigInteger('group_id')->nullable();
            $table->foreign('group_id')->references('id')->on('groups')->onDelete('cascade');
            $table->string('group', 120)->nullable();
            $table->integer('amount');
            $table->decimal('cost_price', 16,2);
            $table->decimal('sale_price', 16,2);
            $table->decimal('profit_percentage', 16,2);
            $table->string('cfop', 4);
            $table->string('csosncst', 3);
            $table->string('ncm', 8);
            $table->string('cest', 7);
            $table->string('unit', 4)->default('UN');
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};