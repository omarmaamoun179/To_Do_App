import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/firebase_func/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/modules/edit_task/edit_task.dart';

class TaskItemWidget extends StatefulWidget {
  TaskItemWidget({required this.taskModel, super.key});
  TaskModel taskModel;

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
          ),
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: EditTask(taskModel: widget.taskModel),
            );
          },
        );
      },
   
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Slidable(
          startActionPane: ActionPane(
             extentRatio: 0.3,
            motion: const ScrollMotion(),
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                borderRadius: BorderRadius.circular(15),
                padding: EdgeInsets.zero,
                onPressed: (context) {
                  FireBaseFunctions.getColletions().doc(widget.taskModel.id).delete();
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',

              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        
              Container(
                
                height: 90,
                width: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: const BoxDecoration(color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.taskModel.title.toString(),
                        style: GoogleFonts.roboto(
                            fontSize: 22,
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 17,
                    ),
                    Text(widget.taskModel.description.toString(),
                        style: GoogleFonts.roboto(
                            fontSize: 15, color: Colors.black)),
                    Row(
                      children: [
                        const Icon(
                          Icons.watch_later_outlined,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text('10:30  AM',
                            style: GoogleFonts.roboto(
                                fontSize: 13, color: Colors.black))
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: 90,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: widget.taskModel.isDone ? Colors.green : Colors.blue),
                child: IconButton(icon: Icon(
                  Icons.check,
                  size: 35,
                  color: Colors.white,
                    
                ),
                
                onPressed: () {
                 widget.taskModel.isDone = !widget.taskModel.isDone;
                 setState(() {
                   
                 });
                },
                )
                
                )
            
            ],
          ),
        ),
      ),
    );
  }
}
 
/*

  */