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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewImage(image : file.getImage[index].path,))),
                    child: Container(
                      height: MediaQuery.of(context).size.width*0.5,
                      width: MediaQuery.of(context).size.width*0.5,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('https://blog.logrocket.com/wp-content/uploads/2021/07/networking-flutter-http-package.png'),
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
