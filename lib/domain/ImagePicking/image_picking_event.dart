part of 'image_picking_bloc.dart';

@immutable
abstract class ImagePickingEvent {}

class ChangeImg extends ImagePickingEvent {
  final String image;
  ChangeImg({required this.image});
}
