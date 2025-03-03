import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker imagePicker = ImagePicker();

  Future<XFile?> cameraCapture() async {
    final XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    return file;
  }

  Future<XFile?> galleryPicker() async {
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return file;
  }
}
