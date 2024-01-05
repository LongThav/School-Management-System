<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'gender_id' => $this -> gender_id,
            'username' => $this->username,
            'email' => $this->email,
            'user_infor' => $this->getAllPerson,
            'image' => $this->image,
            'gender' => $this -> getGender,
            'role' => $this->getRole,
            'class' => $this->getAllPerson->getClass ?? [
                "id" => 0,
                "class_id"=> null,
                "room"=> null,
                "name_class"=> "No-Class",
                "user_id"=> null,
                "person_id"=> null,
                "id_class"=> null
            ],
            'province' => $this->getAllPerson->getProvince ?? [
                "id"=> 0,
                "name_province"=> "No Province",
            ],
            'province_id' => $this->getAllPerson->person_id ?? 0,
            'class_Id' => $this -> getAllPerson->id_class ?? 0,
            'majorId' => $this->getAllPerson->major_id ?? 0,
            'year' => $this->getAllPerson->getYear ?? null,
            'year_id' => $this->getAllPerson->year_id ?? null,
            'payment' => $this->getAllPerson->getTotalPayment ?? null,
            // 'payment_count' => $this->getAllPerson->getTotalPayment == null ? null : $this->getAllPerson->getTotalPayment->count()
            // 'major' => $this->getAllPerson->getMajor ?? null,
            // 'year' =>$this->getAllPerson->getYear ?? null,
            // 'year_id' => $this->getAllPerson->year_id ?? null,
        ];
    }
}
