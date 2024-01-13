import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../utils/app_colors.dart';
import '../widgets/common_toast.dart';

class ViewImageScreen extends StatefulWidget {
  const ViewImageScreen({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Image View'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: FileImage(File(widget.image))
            )
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: AppColors.primary,
            heroTag: "Saved Image",
            onPressed: () {
              ImageGallerySaver.saveFile(widget.image).then((value) {
                commToast("Saved Successfully", context);
              }).onError((error, stackTrace) {
                commToast("Error", context);
              });
            },
            child: const Icon(
              Icons.file_download_outlined,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            backgroundColor: AppColors.primary,
            heroTag: "Share Image",
            onPressed: (){
              FlutterNativeApi.shareImage(widget.image);
            },
            child: const Icon(
              Icons.share,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
