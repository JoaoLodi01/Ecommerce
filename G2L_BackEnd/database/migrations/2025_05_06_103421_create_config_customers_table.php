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
        Schema::create('config_customers', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->unique(['issuer_id', 'config_customer_code']);
            
            $table->unsignedBigInteger('config_customer_code');
            $table->boolean('validate_cnpj', 1)->default(0);
            $table->boolean('validate_cpf', 1)->default(0);
            $table->boolean('validate_addres', 1)->default(0);
            $table->string('last_filter', 8)->default('all');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('config_customers');
    }
};
