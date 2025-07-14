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
            $table->string('company_name', 120)->unique();
            $table->string('trade_name', 120);
            $table->string('cnpj', 14)->nullable()->unique();
            $table->string('cpf', 11)->nullable()->unique();
            $table->string('uf', 2)->nullable();
            $table->integer('cod_ibge', false, 2)->nullable();
            $table->string('city', 100)->nullable();
            $table->string('address', 100)->nullable();
            $table->string('number', 10)->nullable();
            $table->string('cep', 11)->nullable();

            $table->string('ie', 14)->nullable();
            $table->string('im', 12)->nullable();
            $table->string('main_activity', 160)->nullable();
            $table->string('cod_cnae', 40)->nullable();
            $table->string('cnae', 160)->nullable();
            $table->integer('cod_crt', false, 1)->nullable();
            $table->string('crt', 50)->nullable();
            $table->date('date_of_foundation')->nullable();
            $table->foreign('user_code')->references('user_code')->on('users')->onDelete('cascade');
            $table->unsignedBigInteger('user_code');
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
