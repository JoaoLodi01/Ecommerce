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
        Schema::create('errors_pdvs', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('title', 120);
            $table->string('incorret_cfop', 100)->nullable();
            $table->string('incorret_csosn_cst', 100)->nullable();
            $table->boolean('completed', 1)->default(0);
            $table->foreign('pdv_id')->references('id')->on('pdvs')->onDelete('cascade');
            $table->unsignedBigInteger('pdv_id');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('errors_pdvs');
    }
};
