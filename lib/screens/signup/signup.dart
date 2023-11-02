import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:moolah/screens/login/login.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/loader.dart';

import '../../controllers/authController.dart';
import '../../util/apptext.dart';
import '../../util/common_widgets/CommonGradientBackground.dart';
import '../../util/common_widgets/common_appbar.dart';
import '../../util/common_widgets/common_text_field.dart';
import '../../util/common_widgets/common_widgets.dart';
import '../home/home.dart';

class SignUp extends StatefulWidget {
  static const screenName = "signup";
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String phone = "";
  DateTime? dateOfBirth;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CommonGradientBackground(
        child: GetBuilder<AuthController>(builder: (controller) {
      return Loader(
        c: controller,
        child: Column(
          children: [
            verticalSpace(40),
            commonAppBar(withIcon: true),
            Expanded(
              child: roundedContainer(
                  borderRadiusWhole: BorderRadius.circular(13).copyWith(
                      bottomRight: Radius.zero, bottomLeft: Radius.zero),
                  padding:
                      const EdgeInsets.all(25).copyWith(bottom: 0, left: 15),
                  margin: const EdgeInsets.all(10).copyWith(bottom: 0),
                  width: width,
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bigHeadingText("Signup"),
                          verticalSpace(5),
                          subHeadingText(
                              "Start Securing your Moolah Devices"),
                          verticalSpace(20),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                hintText: "First Name",
                                validators: Validators.notEmpty,
                                textEditingController: firstNameController,
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: CustomTextField(
                                hintText: "Last Name",
                                validators: Validators.notEmpty,
                                textEditingController: lastNameController,
                              )),
                            ],
                          ),
                          verticalSpace(15),
                          subHeadingText("Phone Number",
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                          verticalSpace(10),
                          IntlPhoneField(
                            decoration: InputDecoration(
                              border: border,
                              enabledBorder: border,
                              focusedBorder: border,
                              disabledBorder: border,
                              errorBorder: errorBorder,
                              focusedErrorBorder: border,
                              fillColor: AppColors.lightGrey,
                              filled: true,
                              errorText: null,
                            ),
                            onChanged: (number) {
                              phone = number.completeNumber;
                              print("phone: $phone");
                            },
                            validator: (number) {
                              if (number != null) {
                                try {
                                  if (!number.isValidNumber()) {
                                    return "";
                                  }
                                } catch (e) {}
                              }
                              return null;
                            },
                          ),
                          verticalSpace(15),
                          subHeadingText("Date of Birth",
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                          verticalSpace(10),
                          customGestureDetecter(
                            onTap: () async {
                              dateOfBirth = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime(DateTime.now().year - 20),
                                  firstDate: DateTime(1940),
                                  lastDate:
                                      DateTime(DateTime.now().year - 20),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: AppColors
                                              .normalGreen, // header background color
                                          onPrimary: AppColors
                                              .black, // header text color
                                          onSurface: AppColors
                                              .normalGreen, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors
                                                .black, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              setState(() {});
                            },
                            child: roundedContainer(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                color: AppColors.lightGrey,
                                child: Row(
                                  children: [
                                    regularText(dateOfBirth == null
                                        ? "__\\__\\___"
                                        : getSortedDate(dateOfBirth)),
                                  ],
                                )),
                          ),
                          verticalSpace(10),
                          CustomTextField(
                            hintText: "Username",
                            textInputType: TextInputType.emailAddress,
                            validators: Validators.notEmpty,
                            textEditingController: usernameController,
                          ),
                          CustomTextField(
                            hintText: "Email",
                            required: true,
                            textInputType: TextInputType.emailAddress,
                            validators: Validators.email,
                            textEditingController: emailController,
                          ),
                          CustomTextField(
                            hintText: "Password",
                            textInputType: TextInputType.visiblePassword,
                            validators: Validators.password,
                            textEditingController: passwordController,
                            onChange: (c){setState(() {});},
                          ),
                          CustomTextField(
                            hintText: "Confirm Password",
                            textInputType: TextInputType.visiblePassword,
                            validators: Validators.confirmPassword,
                            textEditingController: confirmPasswordController,
                            passwordForConfirmPassword:
                                passwordController.text,
                          ),
                          verticalSpace(30),
                          CustomButton(
                              text: "Sign Up",
                              margin: EdgeInsets.zero,
                              onTap: () {
                                if (key.currentState!.validate()) {
                                  controller.signup(
                                      firstNameController.text,
                                      lastNameController.text,
                                      phone,
                                      dateOfBirth != null
                                          ? getSortedDate(dateOfBirth)
                                          : "",
                                      usernameController.text,
                                      emailController.text,
                                      passwordController.text);
                                }
                                // Get.toNamed(Home.screenName);
                              }),
                          verticalSpace(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              subHeadingText("Already have an account?"),
                              customGestureDetecter(
                                  onTap: () {
                                    Get.toNamed(Login.screenName,
                                        arguments: {"fromSignup": true});
                                  },
                                  child: subHeadingText(" Login here",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black)),
                            ],
                          ),
                          verticalSpace(50),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      );
    }));
  }


}
