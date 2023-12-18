<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CommentMidtermModel extends Model
{
    use HasFactory;
    protected $table = "comment_midterm";
    protected $fillable = [
        'title', 'image', 'subject_id', 'midterm_id', 'user_id'
    ];
}
