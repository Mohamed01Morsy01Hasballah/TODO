import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Shared/components/component.dart';
import 'package:todo/layout/TodoApp/States.dart';
import 'package:todo/layout/TodoApp/cubit.dart';
class ArchiveScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoAppCubit,TodoAppStates>(
      listener: (context,state){},
      builder:  (context,state){
        var task=TodoAppCubit.get(context).ArchiveTask;
        return ConditionalBuilder(
            condition: task.length>0,
            builder: (context)=> ListView.separated(
              itemBuilder: (context,index)=>BuildListItem(context,task[index]),
              separatorBuilder: (context,index)=>Container(
                width:double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              itemCount:task.length,
            ),
            fallback: (context)=>Center(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 90,

                  ),
                  Text(
                    'Please Enter Information your in Note ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            )
        );
      },

    );

  }

}