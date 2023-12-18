<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AnswerAssignmentModel extends Model
{
    use HasFactory;
    
    protected $table = "answer_assignment";
    protected $fillable = ['subject_id', 'assignment_id', 'title', 'image', 'user_id', 'score'];
}
