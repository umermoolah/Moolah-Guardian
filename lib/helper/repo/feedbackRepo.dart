import '../endpoints.dart';
import '../models/response_model.dart';
import '../network.dart';

class FeedbackRepo {

  static Future<ResponseModel> postReview(String rating, String msg) async {
    return await Network.post(EndPoints.submitReview, body: {"rating": rating, "message":msg});
  }

  static Future<ResponseModel> postFeedback(String feedback) async {
    return await Network.post(EndPoints.feedback, body: {"feedback": feedback});
  }

}