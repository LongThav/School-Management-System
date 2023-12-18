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
        Schema::create('subject', function(Blueprint $table){
            $table->id();
            $table->string('subject_name')->nullable();
            $table->string('room_code')->nullable();
            $table->integer('class_id')->nullable();
            $table->integer('major_id')->nullable();
            $table->string('major_name')->nullable();
            $table->integer('person_id')->nullable();
            $table->integer('user_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('subject');
    }
};
