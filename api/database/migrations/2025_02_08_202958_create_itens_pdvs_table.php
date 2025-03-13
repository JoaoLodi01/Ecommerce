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
            $table->unsignedBigInteger('pdv_id');
            $table->foreign('pdv_id')->references('id')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('product_id');
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
            $table->string('product', 255);
            $table->float('amount_sold');
            $table->decimal('addition', 16,2)->nullable();
            $table->decimal('discount', 16,2)->nullable();
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->string('user', 255);
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
