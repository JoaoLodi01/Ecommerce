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
            $table->unsignedBigInteger('nfce_id');
            $table->foreign('nfce_id')->references('id')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('products_id');
            $table->foreign('products_id')->references('id')->on('products')->onDelete('cascade');
            $table->string('produto', 255);
            $table->float('qtde_vendida');
            $table->decimal('acrescimo', 16,2)->nullable();
            $table->decimal('desconto', 16,2)->nullable();
            $table->unsignedBigInteger('id_vendedor');
            $table->foreign('id_vendedor')->references('id')->on('users')->onDelete('cascade');
            $table->string('vendedor', 255);
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
