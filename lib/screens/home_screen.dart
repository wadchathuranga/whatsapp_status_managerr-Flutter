import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/app_colors.dart';
import './image_screen.dart';
import './video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  late TabController tabController;

  //double tap to exit
  DateTime current = DateTime.now().subtract(const Duration(milliseconds: 1500));
  Future<bool> popped() {
    DateTime now = DateTime.now();
      if (tabController.index == 0) {
        if (now.difference(current) > const Duration(milliseconds: 1500)) {
          current = now;
          Fluttertoast.showToast(
              msg: "Press Again to Exit!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
          return Future.value(false);
        } else {
          Fluttertoast.cancel();
          return Future.value(true);
        }
      } else {
        setState(() => tabController.index = 0);
        return Future.value(false);
      }
  }

  void _permission() async {
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    if (result[Permission.storage] == PermissionStatus.granted && result[Permission.manageExternalStorage] == PermissionStatus.granted){
      print('================${result[Permission.storage]}');
    } else {
      print('================${result[Permission.storage]}');
      print('================${result[Permission.manageExternalStorage]}');
    }
  }

  @override
  void initState() {
    super.initState();
    _permission();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            'What Saver',
            style: TextStyle(color: AppColors.whiteColor),
          ),
          bottom: TabBar(
            controller: tabController,
            labelColor: AppColors.secondary,
            indicatorColor: AppColors.secondary,
            unselectedLabelColor: AppColors.whiteColor,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Images', icon: Icon(Icons.image)),
              Tab(text: 'Videos', icon: Icon(Icons.video_collection)),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            ImageScreen(),
            VideoScreen(),
          ],
        ),
      ),
    );
  }
}
