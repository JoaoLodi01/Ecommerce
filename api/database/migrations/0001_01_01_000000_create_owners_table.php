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
        Schema::create('owners', function (Blueprint $table) {
            $table->id();
            $table->string('name', 120);
            $table->string('surname', 120);
            $table->string('cpf', 11)->unique();
            $table->string('phone', 30)->nullable();
            $table->string('email', 120)->unique();
            $table->string('forgot_email', 120);
            $table->string('password', 120);
            $table->string('address', 100);
            $table->string('number', 10);
            $table->string('cep', 11);
            $table->boolean('active', 1)->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('owners');
    }
};
