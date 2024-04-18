


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';

import '../../layout/todo_app/cubit/cubit.dart';


Widget defaultButton(
    {
   double width = double.infinity,
   Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  required void Function() function,
  required String text,
}) => Container(
  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      // ignore: prefer_const_constructors
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultTextButton({
  required void Function() function,
  required String text,
})=>TextButton(
  onPressed: function,
  child: Text(text),
);

Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  Function()? suffixPressed,
  IconData? suffix,
  bool isClickable = true,
}) => TextFormField(
keyboardType: type,
controller: controller,
  obscureText: isPassword,
enabled: isClickable,
onFieldSubmitted: onSubmit,
onChanged: onChange,
onTap: onTap,
validator: validate,
decoration: InputDecoration(
labelText: label,
border: const OutlineInputBorder(),
prefixIcon: Icon(
prefix,
),
    suffixIcon: suffix!=null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ) : null,
),
);
Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
              '${model["time"]}'
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model["title"]}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${model["date"]}",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: ()
            {
              AppsCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
              );
            },
            icon: Icon(
                Icons.check_box
            ),
          color: Colors.blue,
        ),
        IconButton(
            onPressed: ()
            {
              AppsCubit.get(context).updateData(
                status: 'archive',
                id: model['id'],
              );
            },
            icon: Icon(
                Icons.archive
            ),
          color: Colors.greenAccent,
        ),
      ],
    ),
  ),
  onDismissed: (direction)
  {
    AppsCubit.get(context).deleteData(
        id: model['id'],
    );
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
condition: tasks.length > 0,
builder: (BuildContext context) {
return ListView.separated(
itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
separatorBuilder: (context, index) => myDivider(),
itemCount: tasks.length,
);
},
fallback: (BuildContext context) {
return Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.menu,
size: 100.0,
color: Colors.blue,
),
Text(
'No Tasks Yet, Please Add Some Tasks',
style: TextStyle(
fontSize: 20.0,
fontWeight: FontWeight.bold,
color: Colors.blue,
),
),
],
),
);
},
);

Widget myDivider() => Padding(
padding: const EdgeInsetsDirectional.only(
start: 20.0,
),
child: Container(
width: double.infinity,
height: 1.0,
color: Colors.grey[300],
),
);