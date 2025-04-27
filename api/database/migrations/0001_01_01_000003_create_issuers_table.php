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
        Schema::create('issuers', function (Blueprint $table) {
            $table->id();
            $table->string('company_name', 120);
            $table->string('trade_name', 120);
            $table->string('cnpj', 14)->nullable()->unique();
            $table->string('cpf', 11)->nullable()->unique();
            $table->string('address', 100);
            $table->string('number', 10);
            $table->string('cep', 11);
            $table->integer('cod_cnae', false, 1);
            $table->string('cnae', 7);
            $table->integer('cod_crt', false, 1);
            $table->string('crt', 50);
            
            $table->foreign('owner_id')->references('id')->on('owners')->onDelete('cascade');
            $table->unsignedBigInteger('owner_id');
            $table->boolean('active', 1)->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('issuers');
    }
};
