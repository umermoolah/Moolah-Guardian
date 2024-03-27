import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_text_field.dart';
import 'package:moolah/util/images.dart';

class BlackListScreen extends StatefulWidget {
  const BlackListScreen({Key? key}) : super(key: key);

  @override
  State<BlackListScreen> createState() => _BlackListScreenState();
}

class _BlackListScreenState extends State<BlackListScreen> {
  bool inEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 20),
          for (int i = 0; i < 5; i++)
            urlItem('https://www.fiverr.com/cp/product-release-2023'),
          if (!inEditMode)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Add URL',
                onTap: _showAddBlackListDialog,
              ),
            )
        ],
      ),
    );
  }

  void _showAddBlackListDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: Builder(builder: (context) {
            var width = MediaQuery.of(context).size.width;
            return SizedBox(
              width: width - 40,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 26,
                      ),
                      boldText('Black List URL', fontSize: 18),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(hintText: "Enter URL"),
                  ),
                  CustomButton(
                    text: 'Black List',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            );
          }),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: boldText('Black Listed URL', fontSize: 18, color: Colors.black),
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: SvgPicture.asset('assets/images/home/back.svg'),
        ),
      ),
      actions: [
        Center(
          child: InkWell(
            onTap: () {
              setState(() {
                inEditMode = !inEditMode;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: boldText(inEditMode ? 'Save' : 'Edit',
                  color: AppColors.normalGreen, fontSize: 18),
            ),
          ),
        )
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget urlItem(String url) {
    final color = inEditMode ? Colors.black : Colors.red;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            AppImages.globalOutlined,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              url,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (inEditMode)
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child:
                    SvgPicture.asset("${AppImages.pathToHomeImages}/trash.svg"),
              ),
            )
        ],
      ),
    );
  }
}
