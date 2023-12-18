<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PersonModel extends Model
{
    use HasFactory;
    protected $table = "person";
    
    protected $fillable = [
        'name',
        'id_class',
        'image',
        'codeId',
        'age',
        'role',
        'sex',
        'city',
        'person_id',
        'user_id',
        'khan',
        'year_id',
        'class_id',
        'sangkat',
        'country',
        'phone',
        'payment_id',
        'payment',
        'major_id',
        'lat',
        'long'
    ];


    public function getClass(){
        return $this->belongsTo(ClassModel::class, 'id_class');
    }

    public function getUser(){
        return $this->hasMany(User::class, 'person_id');
    }

    public function getPayment(){
        return $this->hasMany(PaymentModel::class, 'person_id');
    }

    public function getMajor(){
        return $this->belongsTo(MajorModel::class, 'major_id');
    }

    public function getRolePerson(){
        return $this->hasOne(RoleModel::class, 'person_id');
    }


    public function getGender(){
        return $this->belongsTo(GenderModel::class, 'person_id');
    }

    public function getProvince(){
        return $this->belongsTo(ProvinceModel::class, 'person_id');
    }

    public function getYear(){
        return $this->belongsTo(YearModel::class, 'year_id');
    }

    public function getTotalPayment(){
        return $this->hasMany(PaymentModel::class, 'person_id');
    }

    // public function getOneTotalPayment(){
    //     return $this->hasOne(PaymentModel::class, 'person_id');
    // }
}
