<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MidtermModel extends Model
{
    use HasFactory;
    protected $table = "midterm";
    protected $fillable = [
        'class_id', 'major_id', 'all_exam_id', 'user_id', 'persion_id', 'title', 'image', 'subject_id', 'midterm_id', 
        'date_time', 'score'
    ];

    public function getSubject(){
        return $this->hasOne(SubjectModel::class, 'subject_id');
    }
    
    public function getCmtMidterm(){
        return $this->hasMany(CommentMidtermModel::class, 'midterm_id');
    }

    public function getAnswerMidterm(){
        return $this->hasOne(AnswerMidtermModel::class, 'midterm_id');
    }

    public function getAllAnswerMidterm(){
        return $this->hasMany(AnswerMidtermModel::class, 'midterm_id');
    }
}
