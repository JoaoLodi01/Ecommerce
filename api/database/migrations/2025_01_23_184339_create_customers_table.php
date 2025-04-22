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
        Schema::create('customers', function (Blueprint $table) {
            $table->id();
            $table->string('name', 120);
            $table->string('cnpj', 14)->nullable()->unique();
            $table->string('cpf', 11)->nullable()->unique();
            $table->string('cep', 8);
            $table->string('address', 120)->nullable();
            $table->string('number', 120)->nullable();
            $table->string('email', 100)->unique();
            $table->string('phone', 50)->nullable();
            $table->string('is_customer', 1)->nullable()->default(1);
            $table->string('is_driver', 1)->nullable()->default(0);
            $table->boolean('is_supplier', 1)->nullable()->default(0);
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }
    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customers');
    }
};
