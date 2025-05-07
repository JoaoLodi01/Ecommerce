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
        Schema::create('config_pdvs', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->integer('n_nfce', false)->default(1);
            $table->string('filter_search', 40)->default('');
            $table->string('filter_search_customer', 40)->default('');
            $table->boolean('nm_finaly', 1)->default(1);
            $table->boolean('sale_negative_or_reset', 1)->default(0);
            $table->boolean('supervisor_password_cancel_sale', 1)->default(0);
            $table->boolean('supervisor_password_delete_item', 1)->default(0);
            $table->boolean('active', 1)->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('config_pdvs');
    }
};
