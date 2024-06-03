// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:algoriza_todo/core/models/task_model.dart';
import 'package:algoriza_todo/core/utils/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  Database? database;

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('Database Created');
        database
            .execute(
          'CREATE TABLE Todo ('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'date TEXT,'
          'startTime TEXT,'
          'endTime TEXT,'
          'remind TEXT,'
          'repeat TEXT,'
          'color INTEGER,'
          'completed INTEGER,'
          'favorite INTEGER)',
        )
            .then((value) {
          debugPrint('Table Created');
        }).catchError((error) {
          print('Error on create table ${error.toString()}');
        });
      },
      onOpen: (db) {
        getTaskFromDatabase();
        debugPrint('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreatedDatabaseState());
    });
  }

  List<TaskModel> allTasks = [];

  void getTaskFromDatabase() async {
    emit(AppLoadingDatabaseState());
    allTasks = [];
    database?.rawQuery('SELECT * FROM Todo').then(
      (value) {
        debugPrint('${value.toString()} get task from database');
        for (var element in value) {
          allTasks.add(
            TaskModel.fromJson(element),
          );
        }

        emit(AppGetTaskFromDatabaseState());
      },
    );
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  TextEditingController repeatController = TextEditingController();

  void insertTaskToDatabase() async {
    await database?.transaction(
      (txn) async {
        await txn.rawInsert(
          'INSERT INTO Todo('
          'title,'
          'date,'
          'startTime,'
          'endTime,'
          'remind,'
          'repeat,'
          'color,'
          'completed,'
          'favorite)'
          'VALUES('
          '"${titleController.text}",'
          '"${dateController.text}",'
          '"${startTimeController.text}",'
          '"${endTimeController.text}",'
          '"${remindController.text}",'
          '"${repeatController.text}",'
          '"$selectedTaskColor",'
          '0,'
          '0)',
        );
        debugPrint('Task Inserted');
      },
    ).then(
      (value) {
        print('${value.toString()} insert successfully');
        titleController.clear();
        dateController.clear();
        startTimeController.clear();
        endTimeController.clear();
        remindController.clear();
        repeatController.clear();
        getTaskFromDatabase();
        emit(AppInsertTaskToDatabaseState());
      },
    ).catchError(
      (error) {
        log('Error on insert data ${error.toString()}');
      },
    );
  }

  void updateCompleteTask(int taskId) async {
    int completed =
        allTasks.firstWhere((element) => element.id == taskId).completed == 1
            ? 0
            : 1;

    database?.rawUpdate('UPDATE Todo SET completed = ? WHERE id = $taskId',
        [completed]).then((value) {
      debugPrint('Task Data Updated');
      getTaskFromDatabase();
    });
  }

  void updateFavoriteTask(int taskId) async {
    int favorite =
        allTasks.firstWhere((element) => element.id == taskId).favorite == 1
            ? 0
            : 1;

    database?.rawUpdate('UPDATE Todo SET favorite = ? WHERE id = $taskId',
        [favorite]).then((value) {
      debugPrint('Task Data Updated');
      getTaskFromDatabase();
    });
  }

  void deleteTaskData({required int id}) async {
    database?.rawDelete(
      'DELETE FROM Todo WHERE id = ?',
      [id],
    ).then((value) {
      getTaskFromDatabase();
      emit(AppDeleteTaskDataState());
    });
  }

  List<String> remindList = [
    'None',
    '10 minutes before',
    '30 minutes before',
    '1 hour before',
    '1 day before',
  ];

  void setReminder(String value) {
    remindController.text = value;
    emit(AppRemindState());
  }

  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  void setRepeater(String value) {
    repeatController.text = value;
    emit(AppRepeatState());
  }

  int selectedTaskColor = 0;

  List<MaterialColor> taskColorList = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.blue,
    Colors.purple,
  ];

  void changeTaskColor(int value) {
    selectedTaskColor = value;
    emit(AppChangeColorIndexState());
  }
} //AppCubit
