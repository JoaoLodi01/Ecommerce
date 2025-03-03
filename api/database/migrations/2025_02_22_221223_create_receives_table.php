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
            $table->string('description', 200);
            $table->unsignedBigInteger('customer_id');
            $table->foreign('customer_id')->references('id')->on('customers')->onDelete('cascade');
            $table->string('name', 120);
            $table->unsignedBigInteger('especie_id');
            $table->foreign('especie_id')->references('id')->on('payments')->onDelte('cascade');
            $table->string('especie', 120);
            $table->date('date_register');
            $table->date('due_date');
            $table->integer('installment_amount');
            $table->integer('installment_number');
            $table->decimal('installment_value', 16,2);
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
