import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/archived_tasks/archived_tasks_screen.dart';
import 'package:untitled/cubid/states.dart';
import 'package:untitled/done_tasks/done_tasks_screen.dart';
import 'package:untitled/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> titles = ["TODO", "Done", "Archived"];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNav());
  }

  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');

        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT , time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table');
        });
      },
      onOpen: (database) {
        getDatafromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDBState());
    });
  }

  insertToDatabase(@required String title, @required String time,
      @required String date) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('inserted success $value');
        emit(AppInsertDBState());

        getDatafromDatabase(database);
      }).catchError((error) {
        print('errore insert ${error.toString()}');
      });
    });
  }

  void getDatafromDatabase(database) {
    newTasks = [];
     doneTasks = [];
      archiveTasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else
          archiveTasks.add(element);
        print(element['status']);
      });
      emit(AppGetDBState());
    });
  }

  void updateData(
    @required String status,
    @required int id,
  ) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDatafromDatabase(database);
      emit(AppUpdateDBState());
    });
  }

   void deleteData(
  
    @required int id,
  ) async {
    database.rawDelete('DELETE FROM tasks  WHERE id = ?',
        [ id]).then((value) {
      getDatafromDatabase(database);
      emit(AppDeleteDBState());
    });
  }

  void changeBottomSheet({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomsheet());
  }
}
