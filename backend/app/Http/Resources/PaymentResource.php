<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PaymentResource extends JsonResource
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
            // 'user' => $this->getUser,
            'total_payment' => $this->total_payment,
            'person_id' => $this->person_id,
            'user_id' => $this->user_id,
            // 'major' => $this->getMajor,
            'user_infor' => $this->getPerson,
        ];
    }
}
