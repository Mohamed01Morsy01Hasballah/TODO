import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/Shared/components/component.dart';
import 'package:todo/layout/TodoApp/States.dart';
import 'package:todo/layout/TodoApp/cubit.dart';

class TodoApp extends StatelessWidget{
  var scaffoldKey =GlobalKey<ScaffoldState>();
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();
  var fromkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(

      create: (BuildContext context) =>TodoAppCubit()..GetCreateDatabase(),
      child: BlocConsumer<TodoAppCubit,TodoAppStates>(
        listener: (context,state){
          if(state is InsertedDatabaseState){
            Navigator.pop(context);

          }
        },
        builder: (context,state){
          var cubit=TodoAppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar:AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ) ,
            body:cubit.Scrren[cubit.currentIndex],
            bottomNavigationBar:BottomNavigationBar(
              type:BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home
                    ),
                  label: 'Task'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.check_box
                    ),
                    label: 'Done'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.archive_outlined
                    ),
                    label: 'Archive'
                ),
              ],

            ) ,
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(cubit.button){
                  if(fromkey.currentState!.validate()){
                    cubit.InsertedDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text
                    );
                    cubit.changeIcon(ic: Icons.edit, show: false);
                  }
                }else{
                  scaffoldKey.currentState!.showBottomSheet((context) =>

                      Container(
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: fromkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultTextField(
                                    type:TextInputType.text ,
                                    controller: titleController,
                                    label: 'New Task',
                                    prefix: Icons.title,
                                    function: (value){
                                      if(value.isEmpty){
                                        return "Please Enter task";
                                      }
                                      return null;
                                    }
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DefaultTextField(
                                  OnTap: (){
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text=value!.format(context).toString();
                                    });
                                  },
                                    type:TextInputType.datetime ,
                                    controller: timeController,
                                    label: 'Time',
                                    prefix: Icons.watch,
                                    function: (value){
                                      if(value.isEmpty){
                                        return "Please Enter Time";
                                      }
                                      return null;
                                    }

                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DefaultTextField(
                                  OnTap: (){
                                    showDatePicker(
                                        context: context, 
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(), 
                                        lastDate: DateTime.parse('2022-04-20')
                                    ).then((value) {
                                      dateController.text=DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                    type:TextInputType.datetime ,
                                    controller: dateController,
                                    label: 'Date',
                                    prefix: Icons.date_range_outlined,
                                    function: (value){
                                      if(value.isEmpty){
                                        return "Please Enter Date";
                                      }
                                      return null;
                                    }
                                ),

                              ],
                            ),
                          )
                        ),
                      ),
                  ).closed.then((value){
                    cubit.changeIcon(ic: Icons.edit, show: false);

                  });
                  cubit.changeIcon(ic: Icons.add, show: true);



                }

              },
                child: Icon(
                  cubit.icon
                )


          )
          );
        } ,

      ),
    );
  }

}