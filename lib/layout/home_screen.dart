import 'package:flutter/material.dart';
import 'package:todo_app/modules/settings/setting_view.dart';
import 'package:todo_app/modules/tasks_view/tasks_view.dart';
import 'package:todo_app/shared/add_task_widget/add_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [
     TaskView(),
    const SettingsView(),
  ];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        extendBody: true,
        body: screens[selectedIndex],
        backgroundColor: const Color(0xffDFECDB),
        floatingActionButton: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              addTaskBottomSheet(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 13,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'takss',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'setting',
                )
              ]),
        ),
      ),
    );
  }

  addTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddTaskWidget(),
      ),
    );
  }
}
