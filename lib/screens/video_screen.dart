import 'package:flutter/material.dart';

import '../utils/app_images.dart';
import '../widgets/common_toast.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
              ),
            );
          },
        )
    );
  }
}
