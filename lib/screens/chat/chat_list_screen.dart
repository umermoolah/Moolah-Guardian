import 'package:flutter/material.dart';
import 'package:moolah/screens/chat/messaging_screen.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/images.dart';

import '../../util/common_widgets/CommonGradientBackground.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMessageItem(context, AppImages.child1,
            'John Campbell', "Mom i need 5 more mins", "9:56am"),
        const Divider(),
        _buildMessageItem(
            context,
            AppImages.child2,
            "Anna Campbell",
            "Mom can i use my device",
            "Yesterday")
      ],
    );
    // return CommonGradientBackground(
    //   child: Padding(
    //     padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
    //     child: Column(
    //       children: [
    //         commonAppBar(heading: "Inbox"),
    //         Expanded(
    //           child: SizedBox(
    //             width: double.infinity,
    //             child: DecoratedBox(
    //               decoration: BoxDecoration(
    //                   borderRadius: const BorderRadius.only(
    //                       topLeft: Radius.circular(15),
    //                       topRight: Radius.circular(15)),
    //                   color: AppColors.white),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding:
    //                         const EdgeInsets.only(left: 16, right: 16, top: 16),
    //                     child: boldText('Unread - 2', fontSize: 16),
    //                   ),
    //                   const SizedBox(height: 10),
    //                   _buildMessageItem(context, AppImages.child1,
    //                       'John Campbell', "Mom i need 5 more mins", "9:56am"),
    //                   const Divider(),
    //                   _buildMessageItem(
    //                       context,
    //                       AppImages.child2,
    //                       "Anna Campbell",
    //                       "Mom can i use my device",
    //                       "Yesterday")
    //                 ],
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _buildMessageItem(BuildContext context, String imageRes, String name,
      String message, String time) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MessagingScreen(),
          ),
        );
      },
      leading: Image.asset(imageRes),
      title: regularText(name, fontSize: 14, color: AppColors.black),
      subtitle: boldText(message, fontSize: 14, color: AppColors.black),
      trailing: SizedBox(
        width: 65,
        child: Align(
          alignment: Alignment.topCenter,
          child:
              regularText(time, fontSize: 14, color: const Color(0xff6C7072)),
        ),
      ),
    );
  }
}
