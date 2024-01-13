import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/app_colors.dart';
import './image_screen.dart';
import './video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
    _permission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text('Save Status'),
          bottom: const TabBar(
            labelColor: AppColors.secondary,
            indicatorColor: AppColors.secondary,
            unselectedLabelColor: AppColors.whiteColor,
            indicatorWeight: 3,
            labelPadding: EdgeInsets.all(15),
            tabs: [
              Text('Images'),
              Text('Videos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ImageScreen(),
            VideoScreen(),
          ],
        ),
      ),
    );
  }
}
