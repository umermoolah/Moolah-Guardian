import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:moolah/helper/sharedHelper.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';

import '../helper/endpoints.dart';
import '../helper/network.dart';
import 'baseController.dart';
import 'package:http/http.dart' as http;

class SubscriptionController extends BaseController {

  Future<void> checkIfUserAlreadyHasTheSubscription() async {

  }


  Future<void> purchaseSubscription({bool isMonthly = false}) async {
    // var res = await createPaymentIntent("30", "USD", getStripeSecretKey());
    isLoading = true;
    var res = await Network.post(EndPoints.createSubscription, body: {
      "amount": isMonthly ? 399 : 3000
      // "email": Prefs.email.get(),
      // "paymentMethod": isMonthly ? "prod_RNFOrZWTFTOgD7": "prod_RNFPiTGFkjNQIz",
    });

    if(res.isSuccessful){
      print("ress:S:S:S:${res}");
      // return;

      try {
        // Setup payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: res.data["clientSecret"], // From backend
            merchantDisplayName: 'GeoLock',
          ),
        );

        // Display payment sheet
        PaymentSheetPaymentOption? e = await Stripe.instance.presentPaymentSheet();
        print("e?.toJson()");
        print(e?.toJson());

        print("Payment completed");
      } catch (e) {
        print("Error: $e");
      }

    }
    isLoading = false;
  }


  createPaymentIntent(String amount, String currency, String apiKey) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

}