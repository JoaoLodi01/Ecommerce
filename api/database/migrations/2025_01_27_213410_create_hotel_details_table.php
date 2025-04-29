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
        Schema::create('hotel_details', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('name', 120);
            $table->string('cnpj', 14)->unique();
            $table->string('email', 170)->unique();
            $table->string('cep', 8)->unique();
            $table->string('address', 120);
            $table->integer('number', false, 20)->nullable();
            $table->integer('number_of_rooms', false, 20)->nullable();
            $table->integer('number_of_employees', false, 20)->nullable();
            
            $table->boolean('active', 1)->default(1);
            $table->date('end_date')->nullable();
            $table->timestamps();

        });
    }

    public function down(): void
    {
        Schema::dropIfExists('hotel_details');
    }
};
