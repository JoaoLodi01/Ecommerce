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
        Schema::create('cash_registers', function (Blueprint $table) {
            $table->id();
            $table->string('description', 200);
            $table->unsignedBigInteger('cliente_id');
            $table->foreign('cliente_id')->references('id')->on('customers')->onDelete('cascade');
            $table->string('cliente', 120);
            $table->unsignedBigInteger('especie_id');
            $table->foreign('especie_id')->references('id')->on('payments')->onDelete('cascade');;
            $table->string('especie', 120);
            $table->date('data_hora_cadastro');
            $table->decimal('valor_entrada', 16,2)->nullable();
            $table->decimal('valor_saida', 16,2)->nullable();
            $table->decimal('saldo_real', 16,2)->nullable();
            $table->string('origem', 120);
            $table->boolean('cancelada', 1);
            $table->unsignedBigInteger('user_id')->nullable();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->string('seller', 120)->nullable();
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cash_registers');
    }
};
