import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';

import '../../../../controllers/feedbackController.dart';
import '../../../../util/apptext.dart';
import '../../../../util/common_widgets/common_button.dart';
import '../../../../util/common_widgets/common_text_field.dart';
import '../../../../util/common_widgets/common_widgets.dart';

class ContactUsScreen extends StatefulWidget {
  static const screenName = "contactUsScreen";
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CommonGradientBackground(
        child: Column(children: [
          commonAppBar(heading: "Contact Us"),
          verticalSpace(20),
          roundedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            width: width,
            child: Form(
              key: form,
              child: Column(
                children: [
                  // verticalSpace(50),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: regularText("We’d love to here from you.", fontWeight: FontWeight.w600)),
                  CustomTextField(hintText: "", maxLines: 5,textEditingController: textEditingController, validators: Validators.notEmpty),
                  CustomButton(text: "Submit", margin: const EdgeInsets.only(top: 30),onTap: (){
                    if(form.currentState?.validate() ?? false){
                      Get.find<FeedbackContactController>().postFeedback(textEditingController.text.trim());
                    }
                  },)
                ],
              ),
            ),
          ),
        ],));
  }
}
