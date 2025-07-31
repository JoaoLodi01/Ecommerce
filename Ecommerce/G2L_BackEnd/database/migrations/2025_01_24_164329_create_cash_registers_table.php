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
            $table->unsignedBigInteger('cash_register_code')->index();
                        
            $table->unsignedBigInteger('document');
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('description', 200);

            $table->foreign('pdv_code')->references('pdv_code')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('pdv_code')->nullable();

            $table->foreign('receive_code')->references('receive_code')->on('receives')->onDelete('cascade');
            $table->unsignedBigInteger('receive_code')->nullable();
            $table->unsignedBigInteger('receive_document')->nullable();

            $table->foreign('to_pay_code')->references('to_pay_code')->on('to_pays')->onDelete('cascade');
            $table->unsignedBigInteger('to_pay_code')->nullable();
            $table->unsignedBigInteger('to_pay_document')->nullable();

            $table->unsignedBigInteger('customer_code');
            $table->foreign('customer_code')->references('customer_code')->on('customers')->onDelete('cascade');

            $table->unsignedBigInteger('especie_code');
            $table->foreign('especie_code')->references('payment_code')->on('payments_forms')->onDelete('cascade');;

            $table->string('name', 120);
            
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