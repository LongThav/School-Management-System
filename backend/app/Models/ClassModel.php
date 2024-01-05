<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClassModel extends Model
{
    use HasFactory;
    protected $table = "class";
    protected $fillable = ['name_class', 'person_id', 'user_id', 'id_class', 'major_id'];

    public $timestamps = false;

    public function getUser(){
        return $this->hasMany(User::class, 'user_id');
    }

    public function getClass(){
        return $this->belongsTo(MajorModel::class, 'major_id');
    }

    public function getAllStudent(){
        return $this->hasMany(PersonModel::class, 'id_class');
    }

    public function getAllExam(){
        return $this->hasMany(AllExamModel::class, 'class_id');
    }

    public function getFinalExam(){
        return $this->hasMany(FinalExamModel::class, 'class_id');
    }

    public function getMidtermExam(){
        return $this->hasMany(MidtermModel::class, 'class_id');
    }

    public function getQuiz(){
        return $this->hasMany(QuizModel::class, 'class_id');
    }

    public  function getAssignment(){
        return $this->hasMany(AssignmentModel::class, 'class_id');
    }

    // public function getYear(){
    //     return $this->belongsTo(YearModel::class, 'year_id');
    // }

    public function getSubject(){
        return $this->hasMany(SubjectModel::class, 'class_id');
    }

    public function getPayment(){
        return $this->hasMany(PaymentModel::class, 'id_class');
    }

    public function getSubjectMidterm(){
        return $this->hasOne(SubjectModel::class, 'class_id');
    }
}
