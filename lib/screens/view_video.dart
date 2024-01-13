import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';

import '../utils/app_colors.dart';
import '../widgets/common_toast.dart';

class ViewVideo extends StatefulWidget {
  const ViewVideo({Key? key, required this.video}) : super(key: key);

  final String video;

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {

  late ChewieController _chewieController;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(File(widget.video));
    _chewieController = ChewieController(
        autoInitialize: true,
        looping: true,
        aspectRatio: 6/7,
        errorBuilder: ((context, errorMessage) {
          return commToast(errorMessage, context);
        }),
        videoPlayerController: videoPlayerController,
    ) ;
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Chewie(controller: _chewieController!),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: AppColors.primary,
              heroTag: "Saved Video",
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
              heroTag: "Share Video",
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
