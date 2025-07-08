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
        Schema::create('davs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('dav_cod')->index(); // "ID"  

            $table->unique(['issuer_id', 'dav_number']);
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');

            $table->unsignedBigInteger('dav_number');
            
            $table->decimal('addition', 16,2)->nullable();
            $table->decimal('discount', 16,2)->nullable();
            $table->decimal('gross_value', 16,2);
            $table->decimal('net_value', 16,2);
            $table->string('status', 60)->nullable()->default('Pendente');
            $table->boolean('finished', 1)->default(0);
            $table->boolean('canceled', 1)->default(0);
            $table->string('type', 20);
            $table->string('title', 120);
            $table->string('description', 255);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('davs');
    }
};
