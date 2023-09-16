import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/custom_text_field/custom_text_form_field.dart';

import '../../core/firebase_func/firebase_functions.dart';
import '../../models/task_model.dart';

class EditTask extends StatefulWidget {
  EditTask({required this.taskModel, super.key});
  TaskModel taskModel;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var mediaQurey = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQurey.width * .05,
            vertical: mediaQurey.height * .05),
        child: SizedBox(
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                  controller: widget.taskModel.title == null
                      ? titleController
                      : titleController
                    ..text = widget.taskModel.title,
                  hintText: 'Edit Title',
                  maxLines: 1,
                  minLines: 1),
              SizedBox(
                height: mediaQurey.height * .078,
              ),
              CustomTextField(
                controller: widget.taskModel.description == null
                    ? descriptionController
                    : descriptionController
                  ..text = widget.taskModel.description,
                hintText: 'Edit Description',
                maxLines: 4,
                minLines: 2,
              ),
              SizedBox(
                height: mediaQurey.height * .078,
              ),
              const Text('done'),
              Row(
                children: [
                  Checkbox(
                      value: widget.taskModel.isDone,
                      onChanged: (value) {
                        setState(() {
                          widget.taskModel.isDone = value!;
                        });
                      }),
                  const Text('done'),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    TaskModel taskModel = TaskModel(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      id: widget.taskModel.id,
                      date: DateUtils.dateOnly(selectedDate)
                          .millisecondsSinceEpoch,
                      title: titleController.text,
                      description: descriptionController.text,
                      isDone: widget.taskModel.isDone,
                    );
                    FireBaseFunctions.updateTask(taskModel)
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('EditTask'))
            ],
          ),
        ),
      ),
    );
  }
}
