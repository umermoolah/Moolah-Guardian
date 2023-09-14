import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/util/colors.dart';

import '../../controllers/authController.dart';

class Loader extends StatefulWidget {
  Loader({required this.child, required this.c});
  Widget child;
  BaseController c;

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    bool loading = widget.c.isLoading;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print("bool loading = Get.find<BaseController>().isLoading;:::$loading");
    return WillPopScope(
      onWillPop: () async {
        return  loading ? false : true;
        // return true;
      },
      child: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            SizedBox(
              height: height,
                child: widget.child),
            if(loading)
            Align(
              alignment: Alignment.center,
              child: AbsorbPointer(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                    height: height,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height:40, width:40,child: CircularProgressIndicator(color: AppColors.normalGreen,)),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
