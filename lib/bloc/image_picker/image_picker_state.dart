import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerState extends Equatable {
  final XFile? file;
  final XFile? galleryFile;
  const ImagePickerState({this.file, this.galleryFile});

  @override
  List<Object?> get props => [file, galleryFile];

  ImagePickerState copyWith({XFile? file, XFile? galleryFile}) {
    return ImagePickerState(
        file: file ?? this.file, galleryFile: galleryFile ?? this.galleryFile);
  }
}
