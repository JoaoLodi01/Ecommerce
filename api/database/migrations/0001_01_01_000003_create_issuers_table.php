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
            $table->string('name', 120);
            $table->string('cnpj', 14)->nullable()->unique();
            $table->string('cpf', 11)->nullable()->unique();
            $table->string('address', 100);
            $table->string('number', 10);
            $table->string('cep', 11);
            $table->string('email', 100)->unique();
            $table->string('phone', 30)->nullable();
            $table->boolean('active', 1)->default(1);

            $table->foreign('owner_id')->references('id')->on('owners')->onDelete('cascade');
            $table->unsignedBigInteger('owner_id');
        
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
