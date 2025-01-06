import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/utils/app_colors.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }

  final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://135degrees.in/about-us/"));

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        title: '',
        accountType: accountType,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            )
          : WebViewWidget(controller: webViewController),
    );
  }
}
