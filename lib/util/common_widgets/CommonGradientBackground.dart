import 'package:flutter/material.dart';

import '../colors.dart';

class CommonGradientBackground extends StatefulWidget {
  CommonGradientBackground({required this.child});

  Widget child;

  @override
  State<CommonGradientBackground> createState() => _CommonGradientBackgroundState();
}

class _CommonGradientBackgroundState extends State<CommonGradientBackground> {
  @override
  Widget build(BuildContext context) {
    /// FOR THE GRADIENT BACKGROUND ON ALL THE SCREENS

      return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.white,
                      // AppColors.veryLightGreen,
                      AppColors.veryLightGreen,
                      AppColors.veryLightGreen,
                      // AppColors.lightGreen,
                      // AppColors.lightGreen,
                      AppColors.lightGreen,
                      AppColors.normalGreen,
                    ],
                  )),
            ),
            widget.child
          ],
        ),
      );
  }
}
