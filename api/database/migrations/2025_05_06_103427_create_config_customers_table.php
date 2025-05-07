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

            $table->boolean('allow_addres_null', 1)->default(0);
            $table->boolean('allow_cnpj_null', 1)->default(0);
            $table->boolean('allow_cpf_null', 1)->default(0);
            $table->boolean('allow_company_name_null', 1)->default(0);
            $table->boolean('allow_trade_name_null', 1)->default(0);
            $table->string('default_register', 1)->default('');
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
