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
            $table->unsignedBigInteger('pdv_code')->index();
            $table->unique(['issuer_id', 'pdv_code']);

            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');

            $table->string('description', 120);
            $table->date('issue_date');
            $table->integer('n_nfce', false)->nullable();

            $table->foreign('customer_code')->references('customer_code')->on('customers')->onDelete('cascade');
            $table->unsignedBigInteger('customer_code');

            $table->foreign('chart_of_account_code')->references('chart_of_account_code')->on('chart_of_accounts')->onDelete('cascade');
            $table->unsignedBigInteger('chart_of_account_code')->nullable();
            
            $table->foreign('cost_center_code')->references('cost_center_code')->on('cost_centers')->onDelete('cascade');
            $table->unsignedBigInteger('cost_center_code')->nullable();

            $table->string('customer', 120);
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
            $table->string('status', 60)->nullable()->default('Pendente');
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
