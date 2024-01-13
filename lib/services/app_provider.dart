import 'dart:io';
import 'package:flutter/widgets.dart';


class AppProvider extends ChangeNotifier {

  List<FileSystemEntity> getImage = [];
  List<FileSystemEntity> getVideo = [];

  List<FileSystemEntity> get getImageList {
    return getImage;
  }

  bool isWhatsAppAvailable = false;

  getStatus(String endPoint) {
    final directory = Directory("/storage/emulated/0/WhatsApp/Media/.Statuses");

    if (directory.existsSync()) {
      final item = directory.listSync();
      isWhatsAppAvailable = true;
      notifyListeners();

      if (endPoint == ".mp4"){
        getVideo = item.where((element) => element.path.endsWith(".mp4")).toList();
        notifyListeners();
      } else {
        getImage = item.where((element) => element.path.endsWith(".jpg")).toList();
        notifyListeners();
      }
    } else {
      isWhatsAppAvailable = false;
      notifyListeners();
    }
  }
}