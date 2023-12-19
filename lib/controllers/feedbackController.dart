import 'package:get/get.dart';
import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/endpoints.dart';
import 'package:moolah/helper/network.dart';
import 'package:moolah/helper/repo/feedbackRepo.dart';
import 'package:moolah/util/customtoast.dart';

class FeedbackContactController extends BaseController {

  postReview(String msg, int rate) async {
    if((await FeedbackRepo.postReview(rate.toString(), msg)).isSuccessful){
      Get.back();
      successToast("Review Submitted!!!");
    }
  }


  postFeedback(String msg) async {
    if((await FeedbackRepo.postFeedback(msg)).isSuccessful){
      Get.back();
      successToast("Feedback Submitted!!!");
    }
  }





}