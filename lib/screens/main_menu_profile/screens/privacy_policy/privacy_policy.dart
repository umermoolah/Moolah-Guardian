import 'package:flutter/material.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyScreen extends StatefulWidget {
  static const screenName = "privacyScreen";
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {

  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://geolock.co/privacy-policy'));
      // ..loadRequest(Uri.parse('https://moolahwireless.com/term-and-conditions/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonGradientBackground(
        child: Column(children: [
          commonAppBar(heading: "Privacy Policy"),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: roundedContainer(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: WebViewWidget(controller: controller)
              ),
            ),
          )
        ],));
  }
}
