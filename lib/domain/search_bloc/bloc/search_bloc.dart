import 'package:bloc/bloc.dart';
import 'package:bloc_student_database/data/model/student_model.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<ForSearch>((event, emit) {
      state.searchStudents = event.students;
      return emit(SearchState(searchStudents: state.searchStudents));
    });
  }
}
