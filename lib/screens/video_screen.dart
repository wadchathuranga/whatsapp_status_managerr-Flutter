import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_manager/screens/view_video.dart';
import 'package:whatsapp_status_manager/services/app_provider.dart';
import 'package:whatsapp_status_manager/services/get_video_thumnail.dart';

import '../widgets/common_toast.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        body: GridView.builder(
          itemCount: appProvider.getVideo.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.75,
            mainAxisSpacing: 0.0,
          ),
          itemBuilder: (context, index) {
            return FutureBuilder<String>(
                future: getThumbnail(appProvider.getVideo[index].path),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Card(
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewVideo(video: appProvider.getVideo[index].path))),
                          child: Container(
                            height: MediaQuery.of(context).size.width*0.5,
                            width: MediaQuery.of(context).size.width*0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(File(snapshot.data!)),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => FlutterNativeApi.shareImage(appProvider.getVideo[index].path),
                              icon: const Icon(Icons.share),
                            ),
                            IconButton(
                                onPressed: () {
                                  commToast("Saved Successfully", context);
                                  ImageGallerySaver.saveFile(appProvider.getVideo[index].path).then((value){
                                    commToast("Saved Successfully", context);
                                  });
                                },
                                icon: const Icon(Icons.file_download_outlined)),
                          ],
                        )
                      ],
                    ),
                  );
                }
            );
          },
        ),
    );
  }
}
