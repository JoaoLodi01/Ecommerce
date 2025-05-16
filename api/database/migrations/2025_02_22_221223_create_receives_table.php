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
        Schema::create('receives', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('receive_cod');
            $table->unique(['issuer_id', 'receive_cod']);
            $table->unique(['issuer_id', 'document']);

            $table->string('document', 200);
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('description', 200);
            $table->unsignedBigInteger('customer_cod');
            $table->foreign('customer_cod')->references('customer_cod')->on('customers')->onDelete('cascade');

            $table->unsignedBigInteger('especie_cod');
            $table->foreign('especie_cod')->references('payment_cod')->on('payments_forms')->onDelete('cascade');;
            $table->string('name', 120);

            $table->string('especie', 120);
            $table->date('date_register');
            $table->date('due_date');     
            $table->decimal('installment_value', 16,2);
            $table->unsignedBigInteger('installment_cod');
            $table->string('type_interest', 3);
            $table->decimal('interest_value', 16,2);
            $table->decimal('total_amount');
            $table->string('origem', 120);
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->string('user');
            $table->boolean('canceled', 1)->default(0);
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('receives');
    }
};
