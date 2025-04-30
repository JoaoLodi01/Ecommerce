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
        Schema::create('cash_registers', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('cash_register_cod');
            $table->unique(['issuer_id', 'cash_register_cod']);

            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('description', 200);
            $table->string('document', 200);
            $table->foreign('pdv_id')->references('id')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('pdv_id')->nullable();
            $table->unsignedBigInteger('customer_id');
            $table->foreign('customer_id')->references('id')->on('customers')->onDelete('cascade');
            $table->string('name', 120);
            $table->unsignedBigInteger('especie_id');
            $table->foreign('especie_id')->references('id')->on('payments_forms')->onDelete('cascade');;
            $table->string('especie', 120);
            $table->date('date_register');
            $table->decimal('input_value', 16,2)->nullable();
            $table->decimal('output_value', 16,2)->nullable();
            $table->decimal('real_balance', 16,2)->nullable();
            $table->string('origem', 120);
            $table->unsignedBigInteger('user_id')->nullable();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->string('seller', 120)->nullable();
            $table->boolean('canceled', 1)->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cash_registers');
    }
};
