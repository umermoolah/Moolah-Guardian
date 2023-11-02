import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/images.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: _messageTextField(),
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          reverse: true,
          children: [
            verticalSpace(20),
            // _buildChildMessageTyping(),
            _buildMyMessage("Ok fine just 5 min"),
            _buildChildMessage('Mom i need 5 more minutes'),
            _buildMyMessage("Turn off your device"),
            _buildMyMessage("John"),

          ],
        ),
      ),
    );
  }

  Widget _messageTextField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset('assets/images/home/paperclip-2.svg'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              const BorderSide(width: 0, color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SvgPicture.asset('assets/images/home/send-2.svg')
            ],
          ),
        )
      ],
    );
  }

  Widget _buildChildMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.child1,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF2F4F5)),
            child: regularText(
              message,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildMessageTyping() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.child1,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 10),
          regularText('Typing...', color: const Color(0xff979C9E)),
        ],
      ),
    );
  }

  Widget _buildMyMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.normalGreen),
              child: regularText(message, color: Colors.white, fontSize: 16)),
          const SizedBox(width: 10),
          SvgPicture.asset('assets/images/home/Avatar.svg'),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Center(child: commonBackButton()),
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.asset(
            AppImages.child1,
            height: 40,
            width: 40,
          ),
          title:
              regularText('John Campbell', color: Colors.black, fontSize: 14),
          subtitle: Row(
            children: [
              regularText('Online',
                  color: const Color(0xff596372), fontSize: 12),
              Container(
                margin: const EdgeInsets.only(left: 5),
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.normalGreen,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
