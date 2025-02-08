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
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('produto', 255)->unique();
            $table->integer('quantidade');
            $table->decimal('preco_custo', 16,2);
            $table->decimal('preco_venda', 16,2);
            $table->decimal('perc_lucro', 16,2);
            $table->string('gtin', 13);
            $table->integer('NCM');
            $table->integer('CEST');
            $table->integer('CSOSN');
            $table->integer('CFOP');
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
