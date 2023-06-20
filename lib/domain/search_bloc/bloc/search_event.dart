part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class ForSearch extends SearchEvent {
  final List<StudentModel> students;
  ForSearch({required this.students});
}
