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
            $table->string('full_name', 120);
            $table->string('email', 120)->unique();
            $table->string('cpf', 11)->unique();
            $table->date('active_license');
            $table->date('expire_license');
            $table->float('monthly_fee', 16,2);
            $table->boolean('pay')->default(0);
            $table->boolean('hotel')->default(0);
            $table->boolean('ecommerce')->default(1);
            $table->boolean('site')->default(0);
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
