import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/firebase_func/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';

import '../custom_text_field/custom_text_form_field.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var mediaQurey = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: mediaQurey.height * .018, horizontal: 10),
        child: SizedBox(
          height: mediaQurey.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Taks Title',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.length < 4) {
                    return 'Title is requried';
                  }
                  return null;
                },
                controller: titleController,
                maxLines: 1,
                minLines: 1,
                hintText: 'Task Title',
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Taks Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: descriptionController,
                hintText: 'description',
                maxLines: 4,
                minLines: 4,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Select Date',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    selectDate();
                  },
                  child: Text(
                    selectedDate.toString().substring(0, 10),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel taskModel = TaskModel(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        title: titleController.text,
                        description: descriptionController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .millisecondsSinceEpoch,
                        isDone: false);

                    FireBaseFunctions.addTasks(taskModel)
                        .then((value) => Navigator.pop(context));
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(mediaQurey.width, 45),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectDate() async {
    DateTime? chooseDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2024));
    if (chooseDate != null) {
      setState(() {
        selectedDate = chooseDate;
      });
    }

    // }
  }
}
