<?php

namespace App\Http\Controllers;

use App\Http\Resources\PersonResource;
use App\Http\Resources\UserResource;
use App\Mail\ResetPassword;
use App\Models\PersonModel;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Http\Resources\RoleResource;
use App\Models\PaymentModel;
use App\Models\RoleModel;

class PersonController extends Controller
{
    public function AddUserInfor(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:posts|max:255',
            'sex' => 'required|unique:posts|max:255',
            'role' => 'required|unique:posts|max:255',
            'codeId' => 'required|unique:posts|max:255',
            'age' => 'required|unique:posts|max:255',
            'person_id' => 'required|unique:posts|max:255',
            'major_id' => 'required|unique:posts|max:255',
            'city' => 'required|unique:posts|max:255',
            'khan' => 'required|unique:posts|max:255',
            'sangkat' => 'required|unique:posts|max:255',
            'country' => 'required|unique:posts|max:255',
            'user_id' => 'required',
            'year_id' => 'required',
            'id_class' => 'required',
            'phone' => 'required|unique:posts|max:255'
        ]);

        if ($validator->failed()) {
            return response()->json([$validator->errors()]);
        }

        $code_id = PersonModel::where('codeId', $request->codeId)->first();
        if ($code_id) {
            return response([
                "message" => "Code ID has been use",
                "statue" => false
            ]);
        }

        $user_model = PersonModel::create($request->all(), [
            'name' => $request->name,
            'codeId' => $request->codeId,
            'age' => $request->age,
            'year_id' => $request->year_id,
            'role' => $request->role,
            'id_class' => $request->id_class,
            'person_id' => $request->person_id,
            'city' => $request->city,
            'major_id' => $request->major_id,
            'khan' => $request->khan,
            'sangkat' => $request->sangkat,
            'user_id' => $request->user_id,
            'country' => $request->country,
            'phone' => $request->country,
        ]);
        return response([
            "code" => 200,
            "status" => "success response.",
            "data" => $user_model,
        ]);
    }

    public function UserInfor()
    {
        $user = PersonModel::all($person = "*");
        return response([
            "code" => 200,
            "status" => "success response.",
            "data" => PersonResource::collection($user),
        ]);
    }

    public function UserInforById($id)
    {
        $user = PersonModel::find($id);
        return response([
            "code" => 200,
            "status" => "success response.",
            "data" => new PersonResource($user),
        ]);
    }

    public function AddUser(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'role_id' => 'required|unique:posts|max:255',
                'gender_id' => 'required|unique:posts|max:255',
                'email' => 'required|unique:posts|max:255',
                'username' => 'required|unique:posts|max:255',
                'password' => 'required|unique:posts|max:6',
            ]);
            if ($validator->failed()) {
                return response()->json($validator->errors());
            }
            $user = User::create($request->all(), [
                'role_id' => $request->role_id,
                'email' => $request->email,
                'gender_id' => $request->gender_id,
                'password' => Hash::make($request->password),
                'username' => $request->username,
            ]);
            $role = $user->role;
            // $token = JWTAuth::fromUser($user);
            return response([
                "code" => 200,
                "status" => "add user success.",
                "data" => [
                    // "access_token" => $token,
                    "user" => $user,
                ],
                "role" => $role
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function User()
    {
        if (auth()->user()) {
            // $user_query = User::all();
            if (request('query')) {
                // $user_query->where('username','LIKE','%'.$request->keyword.'%');
                $user = User::where('username', 'like', '%' . request('query') . '%')->get();
                $user = User::where('email', 'like', '%' . request('query') . '%')->get();
            } else {
                $user = User::all();
            }
            return response([
                "code" => 200,
                "status" => "add user success.",
                "data" => UserResource::collection($user),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UserSingIn(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|min:2|max:100',
            'password' => 'required|string|min:6',
        ]);
        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        if (!$token = auth()->attempt($validator->validate())) {
            return response()->json(['success' => false, 'message' => 'Username & Password is incorrect']);
        }
        $roleId = auth()->user()->id;
        $user = User::find($roleId);
        $role = RoleModel::find($user->role_id);
        $role_user = $user->role = $role->role;
        $role_id = $user->role = $role->id;
        return response()->json([
            'message' => "user create successfully",
            'statusCode' => 200,
            'data' => [
                'token' => $token,
                'user' => auth()->user(),
                'info' => new UserResource($user)
            ],
            // 'role' => new RoleResource($user),
            // 'role_id' => auth()->user()->role_id,
            'role' => $role_user,
            'role_id' => $role_id,
        ]);
    }


    public function Loggout()
    {
        if (auth()->user()) {
            auth()->logout();
            return response([
                "status" => "reponse successfully",
                "message" => "User Loggout!!",
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function DeleteUser($id)
    {
        if (auth()->user()) {
            $user = User::find($id);
            $user->delete();
            return response([
                "status" => "reponse successfully",
                "message" => "User has been delete!",
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }


    public function Profile()
    {
        if (auth()->user()) {
            return response([
                "status" => "reponse successfully",
                "profile" => auth()->user(),
                "role" => auth()->user()->role
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UpdateProfile(Request $request)
    {
        if (auth()->user()) {
            // $validator = Validator::make($request->all(), [
            //     'id' => 'required',
            //     'email' => 'required',
            //     'role' => 'required',
            //     'password' => 'required'
            // ]);
            // if ($validator->fails()) {
            //     return response([$validator->errors()]);
            // }

            $image_base64 = $request->image;
            $extension = explode('/', explode(':', substr($image_base64, 0, strpos($image_base64, ';')))[1])[1];
            $replace = substr($image_base64, 0, strpos($image_base64, ',') + 1);
            $image = str_replace($replace, '', $image_base64);
            $image = str_replace(' ', '+', $image);
            $imageName = Str::random(10) . '.' . $extension;
            Storage::disk('public')->put($imageName, base64_decode($image));

            $user = User::find($request->id);
            $user->image = $imageName;
            $user->save();
            return response([
                "status" => "reponse successfully",
                "profile" => $user,
                "role" => auth()->user()->role
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UserById($id)
    {
        if (auth()->user()) {
            $user = User::find($id);
            return response([
                "code" => 200,
                "status" => "response successfully.",
                "data" => new UserResource($user),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddAdmin(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'role_id' => 'required|unique:posts|max:255',
            'email' => 'required|unique:posts|max:255',
            'password' => 'required|unique:posts|max:6',
        ]);
        if ($validator->failed()) {
            return response()->json($validator->errors());
        }
        $user = User::create($request->all(), [
            'role_id' => $request->role_id,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);
        $role = $user->role;
        $token = JWTAuth::fromUser($user);
        return response([
            "code" => 200,
            "status" => "add user success.",
            "data" => [
                "access_token" => $token,
                "user" => $user,
            ],
            "role" => $role
        ]);
    }


    public function UpdateUserInfor(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'role' => 'required|unique:posts|max:255',
                'sex' => 'required|unique:posts|max:255',
                'age' => 'required|unique:posts|max:255',
                'person_id' => 'required|unique:posts|max:255',
                'city' => 'required|unique:posts|max:255',
                'khan' => 'required|unique:posts|max:255',
                'sangkat' => 'required|unique:posts|max:255',
                'year_id' => 'required|unique:posts|max:255',
                'major_id' => 'required|unique:posts|max:255',
                'country' => 'required|unique:posts|max:255',
                'user_id' => 'required',
                'id_class' => 'required',
                'phone' => 'required|unique:posts|max:255'
            ]);

            if ($validator->failed()) {
                return response()->json([$validator->errors()]);
            }

            // $code_id = PersonModel::where('codeId', $request->codeId)->first();
            // if (!$code_id) {
            //     return response([
            //         "message" => "Code ID has been use",
            //         "statue" => false
            //     ]);
            // }
            // $image_base64 = $request->image;
            // $extension = explode('/', explode(':', substr($image_base64, 0, strpos($image_base64, ';')))[1])[1];
            // $replace = substr($image_base64, 0, strpos($image_base64, ',') + 1);
            // $image = str_replace($replace, '', $image_base64);
            // $image = str_replace(' ', '+', $image);
            // $imageName = Str::random(10) . '.' . $extension;
            // Storage::disk('public')->put($imageName, base64_decode($image));
            $user_infor = PersonModel::find($request->id);
            $user_infor->sex = $request->sex;
            $user_infor->age = $request->age;
            $user_infor->id_class = $request->id_class;
            $user_infor->person_id = $request->person_id;
            $user_infor->city = $request->city;
            $user_infor->khan = $request->khan;
            $user_infor->role = $request->role;
            $user_infor->year_id = $request->year_id;
            $user_infor->major_id = $request->major_id;
            $user_infor->sangkat = $request->sangkat;
            $user_infor->user_id = $request->user_id;
            $user_infor->year_id = $request->year_id;
            $user_infor->country = $request->country;
            $user_infor->phone = $request->phone;

            $user_infor->save();
            return response([
                "code" => 200,
                "status" => "success response.",
                "data" => $user_infor,
                "province_Id" => $user_infor->person_id,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function SearchUser($search)
    {
        if (auth()->user()) {
            return User::where("name", "like", "%" . $search . "$")->get();
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function Image($img)
    {
        return response()->file(storage_path("/app/public/$img"));
    }

    public function Payment(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'person_id' => 'required',
                'total_payment' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $payment = PaymentModel::create($request->all());
            return response([
                "code" => 200,
                "status" => "success response.",
                "data" => $payment,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function forgotPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => ['required', 'string', 'email', 'max:255'],
        ]);

        if ($validator->fails()) {
            return new JsonResponse(['success' => false, 'message' => $validator->errors()], 422);
        }

        $verify = User::where('email', $request->all()['email'])->exists();

        if ($verify) {
            $verify2 =  DB::table('password_reset_tokens')->where([
                ['email', $request->all()['email']]
            ]);

            if ($verify2->exists()) {
                $verify2->delete();
            }

            $token = random_int(100000, 999999);
            $password_reset = DB::table('password_reset_tokens')->insert([
                'email' => $request->all()['email'],
                'token' =>  $token,
                'created_at' => Carbon::now()
            ]);

            if ($password_reset) {
                Mail::to($request->all()['email'])->send(new ResetPassword($token));

                return new JsonResponse(
                    [
                        'success' => true,
                        'message' => "Please check your email for a 6 digit pin"
                    ],
                    200
                );
            }
        } else {
            return new JsonResponse(
                [
                    'success' => false,
                    'message' => "This email does not exist"
                ],
                400
            );
        }
    }

    public function verifyPin(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => ['required', 'string', 'email', 'max:255'],
            'token' => ['required'],
        ]);

        if ($validator->fails()) {
            return new JsonResponse(['success' => false, 'message' => $validator->errors()], 422);
        }

        $check = DB::table('password_reset_tokens')->where([
            ['email', $request->all()['email']],
            ['token', $request->all()['token']],
        ]);

        if ($check->exists()) {
            $difference = Carbon::now()->diffInSeconds($check->first()->created_at);
            if ($difference > 3600) {
                return new JsonResponse(['success' => false, 'message' => "Token Expired"], 400);
            }

            $delete = DB::table('password_reset_tokens')->where([
                ['email', $request->all()['email']],
                ['token', $request->all()['token']],
            ])->delete();

            return new JsonResponse(
                [
                    'success' => true,
                    'message' => "You can now reset your password"
                ],
                200
            );
        } else {
            return new JsonResponse(
                [
                    'success' => false,
                    'message' => "Invalid token"
                ],
                401
            );
        }
    }

    public function resetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => ['required', 'string', 'email', 'max:255'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
        ]);

        if ($validator->fails()) {
            return new JsonResponse(['success' => false, 'message' => $validator->errors()], 422);
        }

        $user = User::where('email', $request->email);
        $user->update([
            'password' => Hash::make($request->password)
        ]);

        $token = $user->first()->createToken('myapptoken')->plainTextToken;

        return new JsonResponse(
            [
                'success' => true,
                'message' => "Your password has been reset",
                'token' => $token
            ],
            200
        );
    }
}
