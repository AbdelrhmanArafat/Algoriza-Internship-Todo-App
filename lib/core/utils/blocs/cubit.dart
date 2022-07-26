// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:algoriza_todo/core/utils/blocs/states.dart';
import 'package:algoriza_todo/core/utils/models/task_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  late Database database;

  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> favoriteTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('Database Created');
        database
            .execute(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, title TEXT,date TEXT, startTime TEXT, endTime TEXT, remind TEXT, repeat TEXT, status TEXT)',
        )
            .then((value) {
          debugPrint('Table Created');
        }).catchError((error) {
          print('Error on create table ${error.toString()}');
        });
      },
      onOpen: (db) {
        getFromDatabase(db);
        debugPrint('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreatedDatabaseState());
    });
  }

  void getFromDatabase(database) async {
    allTasks = [];
    completedTasks = [];
    uncompletedTasks = [];
    favoriteTasks = [];
    emit(AppLoadingDatabaseState());
    await database.rawQuery('SELECT * FROM Todo').then(
      (value) {
        log('$value get from database');
        for (Map element in value) {
          if (element['status'] == 'new') {
            allTasks.add(element);
            uncompletedTasks.add(element);
          }
          if (element['status'] == 'done') {
            allTasks.add(element);
            completedTasks.add(element);
          }
          if (element['status'] == 'favorite') {
            allTasks.add(element);
            favoriteTasks.add(element);
          }
        }
        emit(AppGetFromDatabaseState());
      },
    );
  }

  insertDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String remind,
    required String repeat,
  }) async {
    await database.transaction(
      (txn) async {
        txn
            .rawInsert(
          'INSERT INTO Todo(title, date, startTime, endTime, remind, repeat, status) VALUES("$title", "$date", "$startTime", "$endTime", "$remind", "$repeat", "new")',
        )
            .then(
          (value) {
            print('$value insert successfully');
            emit(AppInsertDatabaseState());
            getFromDatabase(database);
          },
        ).catchError(
          (error) {
            print('Error on insert data ${error.toString()}');
          },
        );
      },
    );
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE Todo SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete(
      'DELETE FROM Todo WHERE id = ?',
      [id],
    ).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
} //AppCubit
