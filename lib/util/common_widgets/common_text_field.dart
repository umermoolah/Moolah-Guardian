import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/images.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {required this.hintText,
      this.required = false,
        this.textEditingController,
        this.validators,
      this.textInputType = TextInputType.text,
        this.passwordForConfirmPassword,
        this.onChange
      });
  String hintText;
  bool required;
  TextInputType textInputType;
  TextEditingController? textEditingController;
  Validators? validators;
  String? passwordForConfirmPassword;
  Function(String)? onChange;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = false;
  bool error = false;
  bool first = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.textInputType == TextInputType.visiblePassword) {
      obscure = true;
    }
    if(widget.textEditingController != null){
      textEditingController = widget.textEditingController!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(10),
        Row(
          children: [
            subHeadingText(widget.hintText, fontWeight: FontWeight.w500, color: error ? Colors.red : Colors.grey),
            if (widget.required) boldText("*", color: Colors.red, fontSize: 13)
          ],
        ),
        verticalSpace(10),
        TextFormField(
          controller: textEditingController,
          validator: (String? text) {
            String? t = validate(text?.trim()??"");
            print("Errroorr: $t");
            setState(() {
              error = t!=null?true:false;
              first = true;
            });
            return t!=null?"":null;
          },
          onChanged: (String? text){
            widget.onChange != null?widget.onChange!(text??""):null;
            if(first){
              String? t = validate(text??"");
              print("Errroorr: $t");
              setState(() {
                error = t!=null?true:false;

              });
            }
          },
          decoration: InputDecoration(
              errorText: null,
              border: error ? errorBorder : border,
              enabledBorder: error ? errorBorder : border,
              focusedBorder: error ? errorBorder : border,
              disabledBorder: error ? errorBorder : border,
              errorBorder: error ? errorBorder : border,
              focusedErrorBorder: error ? errorBorder : border,
              fillColor: AppColors.lightGrey,
              filled: true,
              suffixIcon: widget.textInputType == TextInputType.visiblePassword
                  ? customGestureDetecter(
                      onTap: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SvgPicture.asset(AppImages.unHideIcon),
                      ),
                    )
                  : null),
          obscureText: obscure,
          keyboardType: widget.textInputType,
        ),
      ],
    );
  }




  validate(String text){
    var valid = widget.validators;
    if(valid!=null){
      if((valid == Validators.notEmpty || valid == Validators.email || valid == Validators.password || valid == Validators.confirmPassword) && text.isEmpty){
        if(text.isEmpty) {
          return "Please enter ${widget.hintText}";
        }
      }
      if(valid == Validators.email){
        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text)){
          return "Please enter a valid Email";
        }
      }
      if(valid == Validators.password){
        if(text.length < 8){
          return "Password must be at least of 8 characters";
        }
      }
      if(valid == Validators.confirmPassword){
        if(text != widget.passwordForConfirmPassword){
          return "Confirm Password must be as same as Password";
        }
      }
    }
  }
}
OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 0, color: Colors.transparent));
OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 1, color: Colors.red));

enum Validators {notEmpty, email, password, confirmPassword}