<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubjectModel extends Model
{
    use HasFactory;
    protected $table = "subjects";

    protected $fillable = ['title', 'image', 'class_id', 'major_id', 'year_id', 'persion_id', 'person_id'];

    public function getClass(){
        return $this->belongsTo(ClassModel::class, 'class_id');
    }

    public function getPersonInSubject(){
        return $this->hasMany(PersonModel::class, 'subject_id');
    }

    public function getMidterminSubject(){
        return $this->hasMany(MidtermModel::class, 'subject_id');
    }

    public function getQuiz(){
        return $this->hasMany(QuizModel::class, 'subject_id');
    }

    public function getAssignment(){
        return $this->hasMany(AssignmentModel::class, 'subject_id');
    }

    public function getAllAsnwerQuiz(){
        return $this->hasMany(AnswerQuizModel::class, 'subject_id');
    }

    public function getFinalExam(){
        return $this->hasMany(FinalExamModel::class, 'subject_id');
    }
}
