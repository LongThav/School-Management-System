<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AssignmentModel extends Model
{
    use HasFactory;
    protected $table = "assignment";
    protected $fillable = [
        'class_id', 'major_id', 'all_exam_id', 'user_id', 'persion_id', 'title', 'image', 'subject_id', 'assignment_id','date_time', 'score'
    ];

    public function getCommentAssignment(){
        return $this->hasMany(CommentAssignmentModel::class, 'assignment_id');
    }

    public function getAnswerAssignment(){
        return $this->hasOne(AnswerAssignmentModel::class, 'assignment_id');
    }

    public function getAllAnswerAssignment(){
        return $this->hasMany(AnswerAssignmentModel::class, 'assignment_id');
    }
}
