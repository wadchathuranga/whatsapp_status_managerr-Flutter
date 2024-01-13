import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';

import '../services/app_provider.dart';
import './view_image.dart';
import '../widgets/common_toast.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<AppProvider>(
          builder: (context, file, child) {

            if (isFetched == false) {
              file.getStatus(".jpg");
              Future.delayed(const Duration(microseconds: 10),() {
                isFetched == true;
              });
            }

            return file.isWhatsAppAvailable == false
                ? const Center(
                    child: Text("No Whatsapp available"),
                  )
                : file.getImage.isEmpty
                    ? const Center(
                        child: Text("No Image Found"),
                      )
                    : GridView.builder(
                        itemCount: file.getImage.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.0,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 0.0,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewImage(image: file.getImage[index].path))),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width*0.5,
                                    width: MediaQuery.of(context).size.width*0.5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: FileImage(File(file.getImage[index].path)),
                                        ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        // onPressed: (){},
                                        onPressed: () async {
                                          FlutterNativeApi.shareImage(file.getImage[index].path);
                                        },
                                        icon: const Icon(Icons.share),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          ImageGallerySaver.saveFile(file.getImage[index].path).then((value){
                                            commToast("Saved Successfully", context);
                                          }).onError((error, stackTrace){
                                            commToast("Error", context);
                                          });
                                        },
                                        icon: const Icon(Icons.file_download_outlined)),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                    );
          }
        )
    );
  }
}
