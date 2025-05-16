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
        Schema::create('payments_forms_pdvs', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');

            $table->unsignedBigInteger('pdv_cod');
            $table->foreign('pdv_cod')->references('pdv_cod')->on('pdvs')->onDelete('cascade');

            $table->unsignedBigInteger('payment_cod');
            $table->foreign('payment_cod')->references('payment_cod')->on('payments_forms')->onDelete('cascade');
            $table->decimal('valor_pago', 16,2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments_forms_pdvs');
    }
};
