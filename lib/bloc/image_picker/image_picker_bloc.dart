import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_learning/bloc/image_picker/image_picker_event.dart';
import 'package:flutter_bloc_learning/bloc/image_picker/image_picker_state.dart';
import 'package:flutter_bloc_learning/utils/image_picker_utils.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc(this.imagePickerUtils) : super(ImagePickerState()) {
    on<CameraCapture>(_cameraCapture);
    on<GalleryPicker>(_galleryPicker);
  }

  void _cameraCapture(
      CameraCapture event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }

  void _galleryPicker(
      GalleryPicker event, Emitter<ImagePickerState> emit) async {
    final XFile? galleryFile = await imagePickerUtils.galleryPicker();
    emit(state.copyWith(galleryFile: galleryFile));
  }
}
