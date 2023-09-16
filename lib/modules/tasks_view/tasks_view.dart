import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/firebase_func/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/modules/login_screen/login_screen.dart';

import '../../shared/widgets/task_item_widget.dart';

class TaskView extends StatefulWidget {
TaskView({super.key});
TaskModel? taskModel;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  DateTime selectedDate = DateTime.now();
  var tasks = [];
              
  @override
  void initState() {
    // loadTask();
        super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
         
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: h * .02, left: w * .07),
            color: Colors.blue,
            height: h * 0.2,
            width: w,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
               Text(
              'To Do List',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(onPressed: (){
              FireBaseFunctions.logout().then((value)async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email').then((value) => Navigator.pushNamedAndRemoveUntil(context,LoginScreen.routeName, (route) => false));
               
              });
            }, icon: const Icon(Icons.logout_outlined)),
            ],
          ),
          
          ),
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateSelected: (date) {
              selectedDate = date;
              setState(() {});
            },
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: theme.primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: const Color(0xFF333A47),
          ),
          Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  padding: const EdgeInsets.only(top: 0.5),
                  itemBuilder: (context, index) {
                    return TaskItemWidget(
                      taskModel:  tasks[index] ,
                    );
                  },
                ),
              ),
        
          StreamBuilder(
            stream: FireBaseFunctions.getTasks(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              }

              var tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if (tasks.isEmpty) {
                return const Text('No tasks');
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  padding: const EdgeInsets.only(top: 0.5),
                  itemBuilder: (context, index) {
                    return TaskItemWidget(
                      taskModel: tasks[index],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
//  Future<List<TaskModel>> loadTask()async{
  
//   var data = await FireBaseFunctions.getAllTasks();
//   setState(() {
//     tasks = data;
//   });
//   return data;
 
   
//   }

}
/*

            ),*/