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
        Schema::create('nfces', function (Blueprint $table) {
            $table->id();
            $table->string('descricao', 255);
            $table->unsignedBigInteger('cliente_id');
            $table->foreign('cliente_id')->on('customers')->onDelete('cascade');
            $table->string('cliente', 255);
            $table->decimal('preco_bruto', 16,2);
            $table->decimal('preco_liquido', 16,2);
            $table->decimal('preco_desconto', 16,2);
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->on('users')->onDelete('cascade');
            $table->string('cancelada', 255);
            $table->boolean('is_nfce_nm')->default(1);
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('nfces');
    }
};
