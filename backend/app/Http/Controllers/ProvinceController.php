<?php

namespace App\Http\Controllers;

use App\Models\ProvinceModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProvinceController extends Controller
{
    public function AddProvince(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'name_province' => 'required',
                // 'person_id' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $gender = ProvinceModel::create($request->all());
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

    public function GetProvince()
    {
        if (auth()->user()) {
            $gender = ProvinceModel::all();
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
