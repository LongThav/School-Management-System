<?php

namespace App\Http\Controllers;

use App\Models\ResultModel;
use Illuminate\Http\Request;

class ResultController extends Controller
{
    public function ResultStudent(){
        if(auth()->user()){
            $result = ResultModel::all();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $result,
            ]);
        }else{
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
}
