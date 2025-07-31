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
        Schema::create('payments_forms', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('payment_code')->index();
            $table->unique(['issuer_id', 'payment_code']);
            $table->unique(['issuer_id', 'pix_key']);
            $table->unique(['issuer_id', 'bank_key']);
            $table->unique(['issuer_id', 'other_key']);
            
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('especie', 100);
            $table->string('tipo_lancamento');
            $table->string('payments_form_type', 120);
            $table->string('pix_key')->nullable();
            $table->string('bank_key')->nullable();
            $table->string('other_key')->nullable();
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments_forms');
    }
};
