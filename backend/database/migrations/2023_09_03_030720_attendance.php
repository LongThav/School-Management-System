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
        Schema::create('attendance', function(Blueprint $table){
            $table->id();
            $table->string('name')->nullable();
            $table->string('email')->nullable();
            $table->string('major')->nullable();
            $table->integer('major_id')->nullable();
            $table->string('class')->nullable();
            $table->integer('class_id')->nullable();
            $table->string('codeId')->nullable();
            $table->integer('person_id')->nullable();
            $table->integer('user_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendance');
    }
};
