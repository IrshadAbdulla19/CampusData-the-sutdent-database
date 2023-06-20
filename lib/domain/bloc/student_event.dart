part of 'student_bloc.dart';

@immutable
abstract class StudentEvent {}

class AddStudent extends StudentEvent {
  final StudentModel newStudent;

  AddStudent({required this.newStudent});
}

class NavChange extends StudentEvent {
  final int current;
  NavChange({required this.current});
}

class Updatestudent extends StudentEvent {
  final StudentModel thisStudent;
  final int index;
  Updatestudent({required this.thisStudent, required this.index});
}

class DeleteStudent extends StudentEvent {
  final StudentModel index;
  DeleteStudent({required this.index});
}
