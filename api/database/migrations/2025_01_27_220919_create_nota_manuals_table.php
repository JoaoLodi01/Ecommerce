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
        Schema::create('nota_manuals', function (Blueprint $table) {
            $table->id();
            $table->string('descricao', 120)->default('VENDA REFERENTE A NOTA MANUAL');
            $table->decimal('preco_bruto', 16,2);
            $table->decimal('preco_liquido', 16,2);
            $table->decimal('preco_desconto', 16,2);
            $table->string('forma_pagamento', 120);
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('nota_manuals');
    }
};
