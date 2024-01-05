<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QuizModel extends Model
{
    use HasFactory;
    protected $table = "quiz";
    protected $fillable = [
        'class_id', 'major_id', 'all_exam_id', 'user_id', 'persion_id', 'title', 'image', 'subject_id', 'quize_id', 'date_time', 'score',
    ];

    public function getCommentInQuiz()
    {
        return $this->hasMany(CommentQuizModel::class, 'quize_id');
    }

    public function getAnswerQuiz()
    {
        return $this->hasOne(AnswerQuizModel::class, 'quiz_id');
    }

    public function getAllAnswerQuiz()
    {
        return $this->hasMany(AnswerQuizModel::class, 'quiz_id');
    }
}
