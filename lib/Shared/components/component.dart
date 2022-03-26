import 'package:flutter/material.dart';
import 'package:todo/layout/TodoApp/TodoApp.dart';
import 'package:todo/layout/TodoApp/cubit.dart';
Widget BuildListItem(context,model)=>Dismissible(
  key:Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children: [

        CircleAvatar(

          radius: 30,

          child:Text(

              '${model["time"]}'

          ) ,

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model["title"]}',

                style: TextStyle(

                  fontSize: 14,

                ),

              ),

              SizedBox(

                height: 5,

              ),

              Text(

                  '${model["date"]}',

                  style:Theme.of(context).textTheme.caption!.copyWith(

                      color: Colors.grey

                  )

              ),





            ],

          ),

        ),

        SizedBox(

          width: 20,

        ),

        IconButton(

            onPressed: (){

              TodoAppCubit.get(context).UpdateDatabase(status: "done", id: model['id']);

            },

            icon: Icon(

              Icons.check_box,

              color: Colors.green

            )

        ),

        IconButton(

            onPressed: (){

              TodoAppCubit.get(context).UpdateDatabase(status: "archive", id: model['id']);



            },

            icon: Icon(

                Icons.archive,

                color: Colors.deepOrange

            )

        ),



      ],

    ),

  ),
  onDismissed: (direction){
    TodoAppCubit.get(context).DeleteDatabase(id: model['id']);
  },
);
Widget DefaultTextField(
    {
      required TextInputType? type,
      required TextEditingController? controller,
      required String label,
      required IconData prefix,
      IconData? suffix,
      required  function,
      bool secure = false,
      SuffixPressed,
      Function? onSubmit,
       OnTap
    }
    )=>TextFormField(
  onTap: OnTap,
  keyboardType: type,
  obscureText: secure,
  controller:controller ,
  validator:function,
  onFieldSubmitted:(s) {
    onSubmit!(s);
  },

  decoration:InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      prefixIcon: Icon(
          prefix
      ),
      suffixIcon: TextButton(
        onPressed: SuffixPressed,
        child: Icon(
            suffix
        ),
      )

  ) ,
);