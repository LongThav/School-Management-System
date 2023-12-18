import 'package:flutter/material.dart';

ValueNotifier<int> userId = ValueNotifier(0);
ValueNotifier<String> email = ValueNotifier('');
ValueNotifier<int>? infoId = ValueNotifier(0);
ValueNotifier<int> taskId = ValueNotifier(0);
ValueNotifier<String> questionQuiz = ValueNotifier('');
ValueNotifier<String> subJectName = ValueNotifier('');
ValueNotifier<int> subjectId = ValueNotifier(0);
ValueNotifier<String> image = ValueNotifier('');

//midterm
ValueNotifier<String> questionMidterm = ValueNotifier('');
ValueNotifier<int> midtermTaskId = ValueNotifier(0);
ValueNotifier<String> midtermImage = ValueNotifier('');


//assignment
ValueNotifier<String> questionAssignment = ValueNotifier('');
ValueNotifier<int> assignmentId = ValueNotifier(0);
ValueNotifier<String> assignmentImage = ValueNotifier('');

//Quiz
ValueNotifier<int> quizId = ValueNotifier(0);
ValueNotifier<int> midtermId = ValueNotifier(0);
ValueNotifier<int> assignmentsId = ValueNotifier(0);