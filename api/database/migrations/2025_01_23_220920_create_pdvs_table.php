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
        Schema::create('pdvs', function (Blueprint $table) {
            $table->id();
            $table->string('description', 120);
            $table->unsignedBigInteger('cliente_id');
            $table->foreign('cliente_id')->references('id')->on('customers')->onDelete('cascade');
            $table->string('client', 120);
            $table->decimal('gross_value', 16,2);
            $table->decimal('net_value', 16,2);
            $table->decimal('discount', 16,2)->nullable();
            $table->decimal('addition', 16,2)->nullable();
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->string('user', 120);
            $table->boolean('finished', 1)->default(0);
            $table->boolean('canceled', 1)->default(0);
            $table->string('is_nfce_nm', 4)->nullable();
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pdvs');
    }
};
