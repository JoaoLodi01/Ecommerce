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
        Schema::create('receives', function (Blueprint $table) {
            $table->id();
            $table->string('descricao', 255);
            $table->unsignedBigInteger('cliente_id');
            $table->foreign('cliente_id')->references('id')->on('customers')->onDelete('cascade');
            $table->string('cliente', 255);
            $table->unsignedBigInteger('especie_id');
            $table->foreign('especie_id')->on('payments')->onDelte('cascade');
            $table->string('especie', 255);
            $table->date('data_vencimento');
            $table->integer('qtde_parcela');
            $table->integer('numero_parcela');
            $table->decimal('valor_parcela', 16,2);
            $table->boolean('tipo_juros', 16,2);
            $table->decimal('valor_juros', 16,2);
            $table->decimal('valor_total');
            $table->string('origem', 255);
            $table->string('cancelada', 255);
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->on('users')->onDelete('cascade');
            $table->string('user');
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('receives');
    }
};
