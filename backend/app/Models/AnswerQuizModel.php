<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AnswerQuizModel extends Model
{
    use HasFactory;

    protected $table = "answer_quiz";
    protected $fillable = ['subject_id', 'quiz_id', 'title', 'image', 'user_id', 'score'];

    public function getUser(){
        return $this->belongsTo(User::class, 'user_id');
    }
}
