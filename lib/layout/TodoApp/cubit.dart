import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/layout/TodoApp/States.dart';
import 'package:todo/modules/ArchiveScrren.dart';
import 'package:todo/modules/DoneScreen.dart';
import 'package:todo/modules/NewsScreen.dart';

class TodoAppCubit extends Cubit<TodoAppStates>{
  TodoAppCubit():super(InitialState());
  static TodoAppCubit get(context)=>BlocProvider.of(context);
  var currentIndex=0;
  IconData icon=Icons.add;
  bool button=false;
  late Database database;
  void changeBottomNav(int index){
    currentIndex=index;
    emit(ChangeBottomNavState());
  }
  void changeIcon({
  required IconData ic,
    required bool show,
}){
    icon=ic;
    button=show;
    emit(changeIconState());
  }
  List<Widget> Scrren=
  [
    NewsScreen(),
    DoneScreen(),
    ArchiveScreen()
  ];
  List<String> titles=[
    'News',
    'Done',
    'Archive'
  ];
  List<Map> NewTask=[];
  List<Map> DoneTask=[];
  List<Map> ArchiveTask=[];

  void GetCreateDatabase(){
      openDatabase(
      'todo.db',
      version: 1,

      onCreate: (database,version){

        print("created database");
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT)')
            .then((value){
              print("Table Created");
        }).catchError((error){
          print("Error When Create Database ${error.toString()}");
        });
      },
      onOpen: (database){
        GetDatabase(database);
        print("Opened database");

      }
    ).then((value) {
      database=value;
      emit(CreateDatabaseState());
      });
  }
   InsertedDatabase(
  {
    required String title,
    required String time,
    required String date,

  }
       )async{
   await database.transaction((txn)async{
      txn.rawInsert('INSERT INTO tasks (title,time,date,status) VALUES ("${title}","${time} ","${date}","new")')
          .then((value) {
        print("$value Inserted Success");

        emit(InsertedDatabaseState());

        GetDatabase(database);
      }).
      catchError((error){
        print("Error When Insert Table ${error.toString()}");
      });
      return null;
    });
  }
  void GetDatabase(database){
    database.rawQuery('SELECT * FROM tasks').then((value) {
     NewTask=[];
     DoneTask=[];
     ArchiveTask=[];
      emit(GetDatabaseState());
      value.forEach((element){
        if(element['status']=="new")
          NewTask.add(element);
        else if(element['status']=="done")
          DoneTask.add(element);
        else
          ArchiveTask.add(element);
      });
    });
   }
   void UpdateDatabase(
  {
  required String status,
    required int id
}
       ){
    database.rawUpdate(
      'UPDATE tasks SET status=? WHERE id=?',
      ['${status}',id]
    ).then((value) {
      emit(UpdateDatabaseState());
      GetDatabase(database);
    });
   }
 void DeleteDatabase(
  {
  required int id
}
     ){
    database.rawDelete(
      'DELETE FROM tasks Where id=?',
      [id]
    ).then((value) {
      emit(DeleteDatabaseState());
      GetDatabase(database);
    });
 }

}