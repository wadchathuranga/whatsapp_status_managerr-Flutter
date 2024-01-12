import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class AppProvider extends ChangeNotifier {

  List<FileSystemEntity> getImage = [];
  List<FileSystemEntity> getVideo = [];

  bool isWhatsappAvailable = false;

  getStatus(String endPoint) {
    final directory = Directory("/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses");

    if (directory.existsSync()) {
      final item = directory.listSync();
      isWhatsappAvailable = true;
      notifyListeners();

      if (endPoint == ".mp4"){
        getVideo = item.where((element) => element.path.endsWith(".mp4")).toList();
        notifyListeners();
      } else {
        getImage = item.where((element) => element.path.endsWith(".jpg")).toList();
        notifyListeners();
      }
    } else {
      isWhatsappAvailable = false;
      notifyListeners();
    }
  }
}