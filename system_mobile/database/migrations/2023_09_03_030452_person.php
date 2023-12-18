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
        Schema::create('person', function (Blueprint $table) {
            $table->id();
            $table->string('name')->nullable();
            $table->string('codeId')->unique();
            $table->string('age')->nullable();
            $table->string('sex')->nullable();
            $table->string('city')->nullable();
            $table->string('khan')->nullable();
            $table->string('sangkat')->nullable();
            $table->integer('user_id')->nullable();
            $table->integer('person_id')->nullable();
            $table->longText('image')->nullable();
            $table->string('country')->nullable();
            $table->string('phone')->nullable();
            $table->timestamp('last_used_at')->nullable();
            $table->timestamp('expires_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('person');
    }
};
