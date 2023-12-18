<?php

namespace App\Http\Controllers;

use App\Models\RoleModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class RoleController extends Controller
{
    public function AddRole(Request $request){
        $validator = Validator::make($request->all(),[
            'role' => 'required',
            // 'person_id' => 'required'
        ]);
        if($validator->fails()){
            return response($validator->errors());
        }
        $role = RoleModel::create($request->all());
        return response([
            "code" => 200,
            "status" => "reponse successfully",
            "data" => $role,
        ]);
    }

    public function GetRole(){
        $role = RoleModel::all($RoleModel = "*");
        return response([
            "code" => 200,
            "status" => "reponse successfully",
            "data" => $role,
        ]);

    }
    
}
