import 'package:bloc_student_database/data/model/student_model.dart';
import 'package:bloc_student_database/domain/bloc/student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> addStudents(StudentModel student, BuildContext context) async {
  final student_db = Hive.box<StudentModel>("students_db");
  final studentId = await student_db.add(student);
  context.read<StudentBloc>().add(AddStudent(newStudent: student));
  student.id = studentId;
}

Future<void> getAllstudnets() async {
  final student_db = Hive.box<StudentModel>("students_db");
  theStudentList.clear();
  theStudentList.addAll(student_db.values);
}

Future<void> updateStudents(
    int index, BuildContext context, StudentModel student) async {
  final student_db = Hive.box<StudentModel>("students_db");
  student_db.putAt(index, student);
  context
      .read<StudentBloc>()
      .add(Updatestudent(thisStudent: student, index: index));
  getAllstudnets();
}

Future<void> deleteStudent(int index) async {
  final student_db = Hive.box<StudentModel>("students_db");
  student_db.deleteAt(index);
  getAllstudnets();
}
