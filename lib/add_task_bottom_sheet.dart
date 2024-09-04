import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
   AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController=TextEditingController();

  var descriptionController=TextEditingController();
  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Add New Task',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                )),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                )),
          ),
          Text(
            'Select Date',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {
              chooseYourDate();

            },
            child: Center(
                child: Text(
                  selectedDate.toString().substring(0,10)
              ,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  TaskModel model= TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date:DateUtils.dateOnly(selectedDate) .microsecondsSinceEpoch );
                  FirebaseFunctions.addTask(model).then( (value){
                    Navigator.pop(context);

                  });
                  
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text('Add',style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,


                ),),
              ))
        ],
      ),
    );
  }

   chooseYourDate()async{
    DateTime? chosenDate=await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365),)
    );
    if(chosenDate!=null){
      selectedDate=chosenDate;
      setState(() {

      });

    }
   }
}

