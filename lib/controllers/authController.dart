import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/models/user_model1.dart';
import 'package:moolah/helper/repo/authRepo.dart';
import 'package:moolah/helper/sharedHelper.dart';
import 'package:moolah/screens/home/home.dart';
import 'package:moolah/util/customtoast.dart';

import '../helper/models/user_model.dart';
import '../util/mixpanel_events.dart';
import 'homeController.dart';

class AuthController extends BaseController {
  UserModel? user;
  UserModel1? user1;

  String emailGlob = "";
  String passwordGlob = "";
  String fullNameGlob = "";
  String phoneGlob = "";
  String dobGlob = "";
  String usernameGlob = "";


  ///Old One
  // Future<void> login(String email, String password) async {
  //   if (isLoading) return;
  //   try {
  //     isLoading = true;
  //     print("LOGIN: $isLoading");
  //     var r = await AuthRepo.login(email, password);
  //     print("RESPNCE: ${r.data}");
  //     print("RESPNCE: ${r.data["data"]}");
  //     print("RESPNCE: ${r.isSuccessful}");
  //     if (r.isSuccessful) {
  //       print("Hello 1;");
  //       user1 = UserModel1.fromJson(r.data["data"][0]);
  //       print("Hello 2;");
  //       Prefs.accessToken.set(r.data["tokens"]["access"]["token"]);
  //       print("Hello 3;");
  //       Prefs.refreshToken.set(r.data["tokens"]["refresh"]["token"]);
  //       print("Hello 4;");
  //       Prefs.userId.set(r.data["data"][0]["user_id"]);
  //       print("Hello 5;");
  //       Prefs.isLoggedIn.set(true);
  //       print("Hello 6;");
  //       Prefs.email.set(r.data["data"][0]["email"]);
  //       print("Hello 7;");
  //       print("user model:::${user1?.toJson()}");
  //       print("user:::::::${user1?.firstName}:::::${user1?.lastName}");
  //       Prefs.firstName.set(user1?.firstName??"");
  //       Prefs.lastName.set(user1?.lastName??"");
  //       Prefs.phone.set(user1?.phone??"");
  //       Get.offAllNamed(Home.screenName);
  //       print("Login Successful: \n\n${r.data}");
  //     } else {
  //       errorToastShow(r.data);
  //     }
  //   } catch (e) {}
  //
  //   isLoading = false;
  //   print("LOGIN: $isLoading");
  // }
  // Future<void> signup(String firstName,String lastName,String phone,String dob,String username, String email, String password) async {
  //   Prefs.accessToken.clear();
  //   if (isLoading) return;
  //   try {
  //     isLoading = true;
  //     print("signupsignupsignup: $isLoading");
  //     var r = await AuthRepo.signUp(email, password, firstName, lastName, phone, dob, username);
  //     print("RESPNCE: ${r.data}");
  //     if (r.isSuccessful) {
  //
  //       Prefs.accessToken.set(r.data["tokens"]["access"]["token"]);
  //       Prefs.refreshToken.set(r.data["tokens"]["refresh"]["token"]);
  //       Prefs.userId.set(r.data["data"][0]["user_id"]);
  //       Prefs.isLoggedIn.set(true);
  //       Prefs.email.set(r.data["data"][0]["email"]);
  //       print("UserModel.fromJson");
  //       user = UserModel.fromJson(r.data["data"][0]);
  //       Prefs.firstName.set(user?.firstName??"");
  //       Prefs.lastName.set(user?.lastName??"");
  //       Get.offAllNamed(Home.screenName);
  //       print("SignUp Successful: \n\n${r.data}");
  //     } else {
  //       errorToastShow(r.data);
  //     }
  //   } catch (e) {
  //     print("object$e");
  //   }
  //
  //   isLoading = false;
  //   print("LOGIN: $isLoading");
  // }
  ///Old One
  Future<void> login() async {
    if (isLoading) return;
    try {
      isLoading = true;
      print("LOGIN: $isLoading");
      var r = await AuthRepo.login(emailGlob, passwordGlob);
      print("RESPNCE: ${r.data}");
      print("RESPNCE: ${r.data["data"]}");
      print("RESPNCE: ${r.isSuccessful}");
      if (r.isSuccessful) {
        print("Hello 1;");
        user1 = UserModel1.fromJson(r.data["data"][0]);
        print("Hello 2;");
        Prefs.accessToken.set(r.data["tokens"]["access"]["token"]);
        print("Hello 3;");
        Prefs.refreshToken.set(r.data["tokens"]["refresh"]["token"]);
        print("Hello 4;");
        Prefs.userId.set(r.data["data"][0]["user_id"]);
        print("Hello 5;");
        Prefs.isLoggedIn.set(true);
        print("Hello 6;");
        Prefs.email.set(r.data["data"][0]["email"]);
        print("Hello 7;");
        print("user model:::${user1?.toJson()}");
        print("user:::::::${user1?.firstName}:::::${user1?.lastName}");
        Prefs.firstName.set(user1?.firstName??"");
        Prefs.lastName.set(user1?.lastName??"");
        Prefs.phone.set(user1?.phone??"");
        Get.offAllNamed(Home.screenName);
        print("Login Successful: \n\n${r.data}");
      } else {
        Get.find<MixPanelEventsController>().track(MixEvents.errorLogin);
        errorToastShow(r.data);
      }
    } catch (e) {}

    isLoading = false;
    print("LOGIN: $isLoading");
  }
  Future<void> signup() async {
    Prefs.accessToken.clear();
    if (isLoading) return;
    try {
      isLoading = true;
      print("signupsignupsignup: $isLoading");
      var r = await AuthRepo.signUp(emailGlob, passwordGlob, fullNameGlob, "", phoneGlob, dobGlob, usernameGlob);
      print("RESPNCE: ${r.data}");
      if (r.isSuccessful) {

        Prefs.accessToken.set(r.data["tokens"]["access"]["token"]);
        Prefs.refreshToken.set(r.data["tokens"]["refresh"]["token"]);
        Prefs.userId.set(r.data["data"][0]["user_id"]);
        Prefs.isLoggedIn.set(true);
        Prefs.email.set(r.data["data"][0]["email"]);
        print("UserModel.fromJson");
        user = UserModel.fromJson(r.data["data"][0]);
        Prefs.firstName.set(user?.firstName??"");
        Prefs.lastName.set(user?.lastName??"");
        Get.offAllNamed(Home.screenName);
        print("SignUp Successful: \n\n${r.data}");
      } else {
        Get.find<MixPanelEventsController>().track(MixEvents.errorSignUp);
        errorToastShow(r.data);
      }
    } catch (e) {
      Get.find<MixPanelEventsController>().track(MixEvents.errorSignUp);
      print("object$e");
    }

    isLoading = false;
    print("LOGIN: $isLoading");
  }

  Future<void> googleSignIn() async {
    Get.find<MixPanelEventsController>().track(MixEvents.startGoogleSignin);

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      await _googleSignIn.signIn().then((value) => print(value));
      // Get.find<MixPanelEventsController>().track(MixEvents.completeGoogleSignin);
    } catch (error) {
      print(error);
    }
  }


  Future<void> refreshToken() async {
    var res = await AuthRepo.refreshToken(Prefs.refreshToken.get());
    Prefs.accessToken.set(res.data["access"]["token"]);
    Prefs.refreshToken.set(res.data["refresh"]["token"]);
    print("res:::${res.data}");
  }

  Future<void> logout() async {
    Prefs.accessToken.clear();
    Prefs.refreshToken.clear();
    Prefs.userId.clear();
    Prefs.isLoggedIn.clear();
    Prefs.email.clear();
    Prefs.firstName.clear();
    Prefs.lastName.clear();
    Get.find<HomeController>().logout();
  }
}
