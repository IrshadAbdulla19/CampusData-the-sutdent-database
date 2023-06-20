import 'package:bloc_student_database/domain/bloc/student_bloc.dart';
import 'package:bloc_student_database/presentetion/home_page/home_screen.dart';
import 'package:bloc_student_database/presentetion/student_add_page/student_adding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final _screens = [const MyHomePage(), StudentAddingPage()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        int currentScreen = state.current ?? 0;
        return Scaffold(
            body: _screens[currentScreen],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.deepPurple.withOpacity(0.5),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              currentIndex: state.current ?? 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: "Student List"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_add), label: "Add Student")
              ],
              onTap: (value) {
                context.read<StudentBloc>().add(NavChange(current: value));
                currentScreen = state.current ?? 0;
              },
            ));
      },
    );
  }
}
