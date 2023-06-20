import 'package:hive_flutter/adapters.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String age;

  @HiveField(3)
  int? id;

  @HiveField(4)
  String imagePath;

  StudentModel(
      {required this.name,
      required this.phone,
      required this.age,
      required this.imagePath,
      this.id});
}

List<StudentModel> theStudentList = [];
