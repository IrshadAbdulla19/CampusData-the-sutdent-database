part of 'student_bloc.dart';

class StudentState {
  List<StudentModel>? studentList;
  int? current;

  StudentState({required this.studentList, this.current});
  StudentState.forScreenNav({required this.current, this.studentList});
}

class StudentInitial extends StudentState {
  StudentInitial()
      : super(
          studentList: theStudentList,
          current: 0,
        );
}
