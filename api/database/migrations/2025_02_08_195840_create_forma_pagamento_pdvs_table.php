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
        Schema::create('forma_pagamento_pdvs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('nfce_id');
            $table->foreign('nfce_id')->references('id')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('especie_id');
            $table->foreign('especie_id')->references('id')->on('payments')->onDelete('cascade');
            $table->decimal('valor_pago', 16,2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('forma_pagamento_pdvs');
    }
};
