import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/image_picker/image_picker_bloc.dart';
import 'package:flutter_bloc_learning/bloc/image_picker/image_picker_event.dart';
import 'package:flutter_bloc_learning/bloc/image_picker/image_picker_state.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image picker screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
                buildWhen: (previous, current) => previous.file != current.file,
                builder: (context, state) {
                  return state.file == null
                      ? InkWell(
                          onTap: () => context
                              .read<ImagePickerBloc>()
                              .add(CameraCapture()),
                          child: CircleAvatar(
                            child: Icon(Icons.camera),
                          ),
                        )
                      : Image.file(
                          height: 200,
                          width: 200,
                          File(state.file!.path.toString()),
                        );
                }),
            SizedBox(
              height: 50,
            ),
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
                buildWhen: (previous, current) =>
                    previous.galleryFile != current.galleryFile,
                builder: (context, state) {
                  return state.galleryFile == null
                      ? InkWell(
                          onTap: () => context
                              .read<ImagePickerBloc>()
                              .add(GalleryPicker()),
                          child: CircleAvatar(
                            child: Icon(Icons.browse_gallery),
                          ),
                        )
                      : Image.file(
                          height: 200,
                          width: 200,
                          File(
                            state.galleryFile!.path.toString(),
                          ),
                        );
                }),
          ],
        ),
      ),
    );
  }
}
