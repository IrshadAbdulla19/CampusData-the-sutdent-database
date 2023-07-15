import 'dart:io';

import 'package:bloc_student_database/data/model/student_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.student});
  final StudentModel student;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
        automaticallyImplyLeading: false,
        title: const Text("Student Profile"),
      ),
      body: Center(
        child: Card(
          child: SizedBox(
            width: size.width * 0.85,
            height: size.height * 0.68,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(student.imagePath)),
                          fit: BoxFit.fill)),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textPart("Name :${student.name}"),
                      textPart("Phone :${student.phone}"),
                      textPart("Age :${student.age}"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text textPart(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 30),
      overflow: TextOverflow.ellipsis,
    );
  }
}
