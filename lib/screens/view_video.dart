import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:whatsapp_status_manager/utils/app_colors.dart';

import '../widgets/common_toast.dart';

class ViewVideo extends StatefulWidget {
  const ViewVideo({Key? key, required this.video}) : super(key: key);

  final String video;

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: AppColors.primary,
              heroTag: "Saved Image",
              onPressed: (){
                ImageGallerySaver.saveFile(widget.video).then((value){
                  commToast("Saved Successfully", context);
                }).onError((error, stackTrace){
                  commToast("Error", context);
                });
              },
              child: const Icon(
                Icons.file_download_outlined,
                color: AppColors.whiteColor,
              ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
              backgroundColor: AppColors.primary,
              heroTag: "Share Image",
              onPressed: (){
                FlutterNativeApi.shareImage(widget.video!);
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
