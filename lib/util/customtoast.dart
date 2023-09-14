import 'package:fluttertoast/fluttertoast.dart';
import 'package:moolah/helper/models/response_model.dart';

import 'colors.dart';

errorToast(String text){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.red,
      textColor: AppColors.white,
      fontSize: 16.0
  );
}
errorToastShow(Map? r){
  if(r != null){
    if(r["errorMsg"]!= null){
      errorToast(r["errorMsg"]);
    }else if(r["message"]!=null){
      errorToast(r["message"]);
    }
  }
}
successToast(String text){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.normalGreen,
      textColor: AppColors.white,
      fontSize: 16.0
  );
}