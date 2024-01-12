import 'dart:io';
import 'package:flutter/material.dart';

import '../utils/app_images.dart';
import '../widgets/common_toast.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            childAspectRatio: 0.7,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewImage(image : file.getImage[index].path,))),
                    child: Container(
                      height: MediaQuery.of(context).size.width*0.45,
                      width: MediaQuery.of(context).size.width*0.45,
                      // color: Colors.black12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(AppImages.logo),
                              // image: FileImage(File(file.getImage[index].path)))
                          ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: (){},
                          // onPressed: () => FlutterNativeApi.shareImage(file.getImage[index].path),
                          icon: const Icon(Icons.share),
                      ),
                      IconButton(
                          onPressed: () {
                            commToast("Saved Successfully", context);
                            // ImageGallerySaver.saveFile(file.getImage[index].path).then((value){
                            //   commToast("Saved Successfully", context);
                            // });
                          },
                          icon: const Icon(Icons.file_download_outlined)),
                    ],
                  )
                ],
              ),
            );
          },
        )
    );
  }
}
