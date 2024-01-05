<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MajorResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'  => $this->id,
            'major_name' => $this->major_name ?? null,
            'all_class' => $this -> getAllClass ?? null,
            'year' => $this->getYear,
            // 'year_id' => $this->year_id,
            // 'all_class_by_major' => $this->getYear->getAllClass ?? null,
            // 'class_id' => $this->getYear->id_class ?? null,
            // 'all_student' => $this->getYear->getAllStudent ?? null,
        ];
    }
}
