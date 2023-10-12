import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_loading.dart';
import 'package:true_counter/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final PreferredSizeWidget? appbar;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  final Widget child;
  final bool isLoading;

  const DefaultLayout({
    this.backgroundColor,
    this.appbar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    required this.child,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appbar,
          backgroundColor: backgroundColor ?? BACKGROUND_COLOR,
          // 기본배경이 완전 흰색은 아니다.
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: child,
            ),
          ),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
        Positioned.fill(
          child: Visibility(
            visible: isLoading,
            child: const CustomLoadingScreen(),
          ),
        )
      ],
    );
  }
}
