part of 'search_bloc.dart';

class SearchState {
  List<StudentModel> searchStudents;

  SearchState({required this.searchStudents});
}

class SearchInitial extends SearchState {
  SearchInitial() : super(searchStudents: theStudentList);
}
