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
            $table->string('address', 120);
            $table->string('number', 120);
            $table->string('email', 120)->unique();
            $table->string('password', 120);
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
