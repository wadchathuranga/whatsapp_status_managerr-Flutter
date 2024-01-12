import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';


commToast(String message, BuildContext context){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: AppColors.secondary,
    backgroundColor: CupertinoColors.black,
    fontSize: 16,
  );
}