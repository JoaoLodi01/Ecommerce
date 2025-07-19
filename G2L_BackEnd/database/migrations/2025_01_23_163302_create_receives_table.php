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
            $table->unsignedBigInteger('receive_code')->index();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            
            $table->unsignedBigInteger('document');            
            $table->string('description', 200);

            $table->unsignedBigInteger('customer_code');
            $table->foreign('customer_code')->references('customer_code')->on('customers')->onDelete('cascade');

            $table->unsignedBigInteger('especie_cod');
            $table->foreign('especie_cod')->references('payment_code')->on('payments_forms')->onDelete('cascade');

            $table->foreign('dav_code')->references('dav_code')->on('davs')->onDelete('cascade');
            $table->unsignedBigInteger('dav_code')->nullable();

            $table->foreign('pdv_code')->references('pdv_code')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('pdv_code')->nullable();

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
