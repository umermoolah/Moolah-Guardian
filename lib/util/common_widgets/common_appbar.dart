import 'package:flutter/material.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';

Widget commonAppBar({bool withIcon = false, String heading = ""}){
  return Padding(
    padding: const EdgeInsets.all(8.0).copyWith(top: 30),
    child: Stack(
      children: [
        Row(
          children: [
            commonBackButton(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (withIcon)?
            Container(
              // color: Colors.red,
                child: appLogo(size: 100)):
                Center(child: Column(
                  children: [
                    verticalSpace(13),
                    bigSubHeading(heading),
                  ],
                ))
          ],
        )
      ],
    ),
  );
}