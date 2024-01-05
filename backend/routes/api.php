<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PersonController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\MajorController;
use App\Http\Controllers\ClassController;
use App\Http\Controllers\GenderController;
use App\Http\Controllers\ProvinceController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\ExamController;
use App\Http\Controllers\SubjectController;
use App\Models\PersonModel;
use Illuminate\Console\View\Components\Task;
use App\Http\Controllers\ResultController;

Route::get('/get-img/{name}', [PersonController::class, "Image"]);
Route::group(['middleware' => 'api'], function ($routes) {
    Route::post('add-user-infor', [PersonController::class, 'AddUserInfor']);
    Route::get('/user-infor', [PersonController::class, 'UserInfor']);
    Route::post('/add-user', [PersonController::class, 'AddUser']);
    Route::post('/add-admin', [PersonController::class, 'AddAdmin']);
    Route::get('/user', [PersonController::class, 'User']);
    Route::get('/user/{id}', [PersonController::class, 'UserById']);
    Route::post('/login', [PersonController::class, 'UserSingIn']);
    Route::post('/logout', [PersonController::class, 'Loggout']);
    Route::delete('/delete-user/{id}', [PersonController::class, 'DeleteUser']);
    Route::get('/get-profile', [PersonController::class, 'Profile']);
    Route::put('/update-profile', [PersonController::class, 'UpdateProfile']);
    Route::post('/add-payment', [PaymentController::class, 'AddPayment']);
    Route::get('/payment', [PaymentController::class, 'GetPayment']);
    Route::get('/payment/{id}', [PaymentController::class, 'ByIdPayment']);
    Route::post('/role', [RoleController::class, 'AddRole']);
    Route::get('/role', [RoleController::class, 'GetRole']);
    Route::post('/major', [MajorController::class,'AddMajor']);
    Route::get('/major/{id}', [MajorController::class, 'GetMajor']);
    Route::get('/all-major', [MajorController::class, 'AllMajor']);
    Route::post('/class', [ClassController::class, 'AddClass']);
    Route::get('/class', [ClassController::class, 'getClass']);
    Route::post('/create-gender', [GenderController::class, 'AddGender']);
    Route::get('/gender', [GenderController::class, 'getGender']);
    Route::post('/create-province', [ProvinceController::class, 'AddProvince']);
    Route::get('/province', [ProvinceController::class, 'GetProvince']);
    Route::put('/update-user-infor', [PersonController::class, 'UpdateUserInfor']);
    Route::get('/search-user/{search}', [PersonController::class, 'SearchUser']);
    Route::get('/major/{id}', [MajorController::class, 'MajorById']);
    Route::get('/class/{id}', [ClassController::class, 'ClassById']);
    Route::post('/all-exam', [ExamController::class, 'AllExam']);
    Route::get('/all-exam/{id}', [ExamController::class, 'GetClass']);
    Route::get('/all-exam', [ExamController::class, 'GetAllClass']);
    Route::post('/add-Final-Exam', [ExamController::class, 'addFinalExam']);
    Route::post('/add-midterm-exam', [ExamController::class, 'addMidtermExam']);
    Route::post('/add-quiz', [ExamController::class, 'addQize']);
    Route::post('/add-assignment', [ExamController::class, 'addAssignment']);
    Route::put('/update-payment/{id}', [ClassController::class, 'UpdatePayment']);
    Route::post('/year', [ExamController::class, 'addYear']);
    Route::get('/year', [ExamController::class, 'Year']);
    Route::put('/major/{id}', [MajorController::class, 'UpdateMajor']);
    Route::put('/update-year/{id}', [MajorController::class, 'UpdateClassByYear']);
    Route::post('/add-class', [MajorController::class, 'AddClass']);
    Route::get('/major-by-id/{id}', [MajorController::class, 'MajorByIdYear']);
    Route::post('/create-subject', [SubjectController::class, 'CreateSubject']);
    Route::get('/subject', [SubjectController::class, 'Subject']);
    Route::get('/subject/{id}', [SubjectController::class, 'SubectById']);
    Route::put('/subject-add-person/{id}', [SubjectController::class, 'AddPersonInSubject']);
    Route::get('/subject-by-class/{id}', [SubjectController::class, 'GetSubjectById']);
    Route::put('/add-person-into-subject/{id}', [SubjectController::class, 'AddPersonIntoSubject']);
    Route::post('/payment', [PersonController::class, "Payment"]);
    Route::get('/history-payment/{id}', [PaymentController::class, 'Payment']);
    Route::get('/user-infor/{id}', [PersonController::class, 'UserInforById']);

    //student
    Route::get('/task/{id}', [SubjectController::class, 'AllTaskByOneSubject']);
    Route::get('/quiz/{id}', [SubjectController::class, 'Quize']);
    Route::get('/assignment/{id}', [SubjectController::class, 'Assignment']);
    Route::get('/midterm/{id}', [SubjectController::class, 'Midterm']);

    //quiz
    Route::post('/cmt-quiz', [SubjectController::class, 'CommentInQuize']);
    Route::get('/cmt-quize/{id}', [SubjectController::class, 'CommnetQuize']);
    Route::get('/cmt-quiz', [SubjectController::class, 'CmtQuize']);

    //midterm
    Route::post('/cmt-midterm', [SubjectController::class, 'CommentInMidterm']);
    Route::get('/cmt-midterm/{id}', [SubjectController::class, 'CommentMidterm']);

    //assignment
    Route::post('/cmt-assignment', [SubjectController::class, 'CommentInAssignment']);
    Route::get('/cmt-assignment/{id}', [SubjectController::class, 'Commentassignment']);

    Route::post('/add-answer-quiz', [TaskController::class, 'SubmitAnswerQuiz']);
    Route::get('/question-quiz/{id}', [TaskController::class, 'QuestionQuiz']);

    Route::post('/add-answer-midterm', [TaskController::class, 'AddAnserMidterm']);
    Route::get('/question-midterm/{id}', [TaskController::class, 'QuestionMidterm']);

    Route::post('/add-answer-assignment', [TaskController::class, 'AddAnserAssignment']);
    Route::get('/question-assignment/{id}', [TaskController::class, 'QuestionAssignment']);

    //Teacher
    Route::get('/all-answer-quiz/{id}', [TaskController::class, 'AllAnswerQuiz']);
    Route::get('/all-answer-assignment/{id}', [TaskController::class, 'AllAssignment']);
    Route::get('/all-answer-midterm/{id}', [TaskController::class, 'AllMidterm']);
    Route::get('/who-submit/{id}', [TaskController::class, 'WhoSubmit']);

    Route::put('/add-score-quiz/{id}', [TaskController::class, 'AddScoreQuiz']);
    Route::put('/add-score-midterm/{id}', [TaskController::class, 'AddScoreMidterm']);
    Route::put('/add-score-assignment/{id}', [TaskController::class, 'AddScoreAssignment']);

    Route::put('/update-answer-quiz/{id}', [TaskController::class, 'UpdateAnswerQuiz']);
    Route::put('/update-answer-midterm/{id}', [TaskController::class, 'UpdateAnswerMidterm']);
    Route::put('/update-answer-assignment/{id}', [TaskController::class, 'UpdateAnswerAssignment']);
    Route::post('/final-exam', [TaskController::class, 'FinalExam']);
    Route::get('/final-exam-in-subject/{id}', [TaskController::class, 'finalExamInSubject']);

   Route::post('/add-event', [TaskController::class, 'AddEvent']); 
   Route::get('/get-event', [TaskController::class, 'GetEvent']); 
   Route::put('/update-lat-long-user-info/{id}', [TaskController::class, 'AddLatLong']);

   Route::get('/info/{id}', [TaskController::class, 'InfoById']);
   Route::post('/find-code-id-child/{codeId}', [TaskController::class, 'FindCodeIdChild']);

   Route::get('/result', [ResultController::class, 'ResultStudent']);

   Route::post('/forgot-password', [PersonController::class, 'ForgotPassword']);
   Route::post('/resent-otp', [PersonController::class, 'ForgotPassword']);
   Route::post('/verfiy-pin', [PersonController::class, 'VerifyPin']);
   Route::post('/reset-password', [PersonController::class, 'ResetPassword']);
});

//https://www.youtube.com/watch?v=7fBSUPhf1eQ
//https://www.youtube.com/watch?v=CHy2TyROq2A

//https://pkbhai-com.medium.com/flutter-push-notification-from-laravel-admin-panel-570ace94b8ed

// /https://www.youtube.com/watch?v=TfxFbi8ZoDA
//https://www.youtube.com/watch?v=TfxFbi8ZoDA
//https://www.youtube.com/watch?v=0Gz-PUnEUF0

//https://www.youtube.com/watch?v=CHy2TyROq2A&t=629s

//MVC
//Model
//View
//Controller