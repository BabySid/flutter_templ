import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  final String url;
  final String displayText;

  const LinkText({super.key, required this.url, required this.displayText});

  // 静态方法处理链接跳转（无需 State）
  static Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("无法打开链接: $url"),
            duration: const Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              top: 100,
              bottom: MediaQuery.of(context).size.height * .1, // 屏幕高度
              left: 100,
              right: 100,
            ),
          ),
        );
        ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer recognizer =
        TapGestureRecognizer()..onTap = () => _launchUrl(context, url);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: "点击访问: ", style: TextStyle(color: Colors.black)),
          TextSpan(
            text: displayText,
            style: TextStyle(color: Colors.blue),
            recognizer: recognizer,
          ),
        ],
      ),
    );
  }
}
