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
        Schema::create('allExam', function(Blueprint $table){
            $table->id();
            $table->integer('class_id')->nullable();
            $table->integer('major_id')->nullable();
            $table->integer('user_id')->nullable();
            $table->integer('persion_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('allExam');
    }
};
