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
            $table->unsignedBigInteger('receive_cod')->index();
            $table->unique(['issuer_id', 'document']);
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            
            $table->string('document', 200);            
            $table->string('description', 200);

            $table->unsignedBigInteger('customer_cod');
            $table->foreign('customer_cod')->references('customer_cod')->on('customers')->onDelete('cascade');

            $table->unsignedBigInteger('especie_cod');
            $table->foreign('especie_cod')->references('payment_cod')->on('payments_forms')->onDelete('cascade');

            $table->foreign('dav_cod')->references('dav_cod')->on('davs')->onDelete('cascade');
            $table->unsignedBigInteger('dav_cod')->nullable();

            $table->foreign('pdv_cod')->references('pdv_cod')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('pdv_cod')->nullable();

            $table->string('name', 120);
            $table->string('especie', 120);
            $table->date('due_date');     
            $table->integer('installment_amount');
            $table->integer('installment_number');
            $table->decimal('installment_value', 16,2);
            $table->unsignedBigInteger('installment_cod');
            $table->string('type_interest', 10);
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
