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
        Schema::create('chart_of_accounts', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('chart_of_account_code')->index();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');

            $table->unsignedBigInteger('issuer_id');

            $table->string('code', 20);
            $table->string('name', 120);

            $table->enum('type', ['ativo', 'passivo', 'receita', 'despesa', 'custo', 'resultado']);

            $table->tinyInteger('level')->unsigned()->default(1);
            $table->boolean('is_analytic')->default(true);
            $table->boolean('is_active')->default(true);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('chart_of_accounts');
    }
};
