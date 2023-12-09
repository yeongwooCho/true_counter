import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';

class CustomSelectableUriText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const CustomSelectableUriText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableAutoLinkText(
      text,
      style: style,
      linkRegExpPattern: '(@[\\w]+|#[\\w]+|${AutoLinkUtils.urlRegExpPattern})',
      onTransformDisplayLink: AutoLinkUtils.shrinkUrl,
      onTap: (url) async {
        final uri = Uri.parse(url);
        launchBrowserTab(uri);
      },
    );
  }
}
