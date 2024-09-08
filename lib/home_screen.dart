import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/add_task_bottom_sheet.dart';
import 'package:todo/providers/theme_provider.dart';
import 'package:todo/tabs/setting.dart';
import 'package:todo/tabs/tasks.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: themeProvider.themeMode==ThemeMode.light?Color(0xFFDFECDB):Color(0xFF060e1e),
      appBar: AppBar(
        title: Text(
          'ToDo',
          style: TextStyle(fontSize: 30, color:themeProvider.themeMode==ThemeMode.light? Colors.white:Colors.black),
        ),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddTaskBottomSheet(),
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: Colors.transparent)),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(

      color: themeProvider.themeMode==ThemeMode.light?Colors.white:Color(0xFF141922),
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          iconSize: 30,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [TasksTab(), SettingsScreen()];
}
