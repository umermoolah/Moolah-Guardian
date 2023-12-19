import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/feedbackController.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_text_field.dart';

import '../../../../util/common_widgets/common_widgets.dart';
import '../../../../util/images.dart';

class FeedbackScreen extends StatefulWidget {
  static const screenName = "feedbackScreen";
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  int rating = 1;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CommonGradientBackground(
      child: Column(
        children: [
          commonAppBar(heading: "Feedback"),
          verticalSpace(20),
          roundedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            width: width,
            child: Form(
              key: form,
              child: Column(
                children: [
                  RatingBar(
                    initialRating: 1,
                    allowHalfRating: false,
                    itemCount: 5,
                    direction: Axis.horizontal,
                    onRatingUpdate: (rate) {
                      setState(() {
                        rating = rate.toInt();
                      });
                    },
                    itemPadding: const EdgeInsets.all(5),
                    ratingWidget: RatingWidget(
                      empty: SvgPicture.asset(AppImages.rating),
                      full: SvgPicture.asset(AppImages.ratingFilled),
                      half: SvgPicture.asset(AppImages.ratingFilled),
                    ),
                  ),
                  verticalSpace(50),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: regularText("Write a Review", fontWeight: FontWeight.w600)),
                  CustomTextField(hintText: "", maxLines: 5,textEditingController: textEditingController, validators: Validators.notEmpty),
                  CustomButton(text: "Submit", margin: const EdgeInsets.only(top: 30),onTap: (){
                    print("MSG:::${textEditingController.text}");
                    print("rating:::$rating");
                    if(form.currentState?.validate() ?? false){
                      Get.find<FeedbackContactController>().postReview(textEditingController.text.trim(), rating);
                    }
                  },)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
