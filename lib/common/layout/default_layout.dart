import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final PreferredSizeWidget? appbar;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  final Widget child;

  const DefaultLayout({
    this.backgroundColor,
    this.appbar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      backgroundColor: backgroundColor ?? Colors.white,
      // 기본배경이 완전 흰색은 아니다.
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
