<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'email',
        'username',
        'user_code',
        'person_id',
        'user_id',
        'gender_id',
        'role_id',
        'role',
        'password',
        'image',
    ];
    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    public $timestamps = false;

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }
    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    public function getAllPerson(){
        return $this->hasOne(PersonModel::class, 'user_id');
    }

    public function getRole(){
        return $this->belongsTo(RoleModel::class, 'role_id')->select('id','role');
    }

    public function getClass(){
        return $this -> hasOne(ClassModel::class, 'user_id');
    }

    public function getGender(){
        return $this->hasOne(GenderModel::class, 'gender_id');
    }

    public function getIdCode(){
        return $this->hasOne(PersonModel::class, 'user_id')->select('codeId');
    }
}
