<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PersonResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this -> id,
            'id_class' => $this -> id_class,
            'name' => $this -> name,
            'code_id' => $this->codeId,
            'age' => $this -> age,
            'sex' => $this -> sex,
            'city' => $this -> city,
            'khan' => $this -> khan,
            'sangkat' => $this -> sangkat,
            'country' => $this -> country,
            'phone' => $this -> phone,
            'gender' => $this -> getGender,
            'class_id' => $this -> getMajor,
            'province' => $this -> getProvince,
            'role' => $this->getRolePerson,
            'class_name' => $this -> getClass,
            'payments' => $this -> getPayment,
            'user_accounts' => $this -> getUser,
            'majorId' => $this->major_id,
            'year' => $this->getYear,
            'year_id' => $this->year_id
        ];
    }
}
