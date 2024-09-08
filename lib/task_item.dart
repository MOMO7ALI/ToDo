import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/providers/theme_provider.dart';
import 'package:todo/task_model.dart';

import 'edit_task_screen.dart';

class TaskItem extends StatelessWidget {
  TaskItem({required this.model, super.key});

  TaskModel model;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: provider.themeMode==ThemeMode.light?Colors.white:Color(0xFF141922),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(model.id);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18), topLeft: Radius.circular(18)),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(task: model),
                ),
              );

            },
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            label: "Edit",
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 2,
                color:   model.isDone? Colors.green:Colors.blue,
              ),
              SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                          color:  provider.themeMode==ThemeMode.light?model.isDone? Colors.green:Colors.black:model.isDone? Color(0xFF61E757
                          ):Colors.blue
                          ),
                    ),
                    Text(model.description, style: TextStyle(fontSize: 16,)),
                  ],
                ),
              ),
              model.isDone
                  ? Text(
                      'DONE!!',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF61E757
                        ),
                      ),
                    )
                  : IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        model.isDone = true;
                        FirebaseFunctions.updateTask(model);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(80, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      icon: Icon(
                        Icons.done,
                        size: 30,
                        color: Colors.white,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
