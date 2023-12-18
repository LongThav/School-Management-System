<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AnswerMidtermModel extends Model
{
    use HasFactory;

    protected $table = "answer_midterm";
    protected $fillable = ['subject_id', 'midterm_id', 'title', 'image', 'user_id', 'score'];
}
