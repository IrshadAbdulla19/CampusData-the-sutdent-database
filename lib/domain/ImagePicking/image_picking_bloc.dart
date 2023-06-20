import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_picking_event.dart';
part 'image_picking_state.dart';

class ImagePickingBloc extends Bloc<ImagePickingEvent, ImagePickingState> {
  ImagePickingBloc() : super(ImagePickingInitial()) {
    on<ChangeImg>((event, emit) {
      return emit(ImagePickingState(image: event.image));
    });
  }
}
