<?php

namespace App\Http\Controllers;

use App\Models\GenderModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class GenderController extends Controller
{
    public function AddGender(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'sex' => 'required',
                // 'person_id' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $gender = GenderModel::create($request->all());
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $gender,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function getGender()
    {
        if (auth()->user()) {
            $gender = GenderModel::all();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $gender,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
}
