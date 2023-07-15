import 'dart:io';

import 'package:bloc_student_database/data/db/db_funtions.dart';
import 'package:bloc_student_database/data/model/student_model.dart';
import 'package:bloc_student_database/domain/bloc/student_bloc.dart';
import 'package:bloc_student_database/domain/search_bloc/bloc/search_bloc.dart';
import 'package:bloc_student_database/presentetion/home_page/widgets/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/profile_screen.dart';
import 'widgets/search_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
        automaticallyImplyLeading: false,
        title: const Text("Student List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SearchWidget();
                  },
                ));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.studentList?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen(
                          student: state.studentList![index],
                        );
                      },
                    ));
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(
                        File(state.studentList?[index].imagePath ?? "")),
                  ),
                  title: Text(state.studentList![index].name),
                  subtitle: Text(state.studentList![index].age),
                  trailing: Wrap(children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return UpdateScreen(
                                indx: index,
                                student: state.studentList![index],
                              );
                            },
                          ));
                        },
                        icon: const Icon(Icons.update)),
                    IconButton(
                        onPressed: () {
                          context.read<StudentBloc>().add(
                              DeleteStudent(index: state.studentList![index]));
                          deleteStudent(index);
                        },
                        icon: const Icon(Icons.delete)),
                  ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
