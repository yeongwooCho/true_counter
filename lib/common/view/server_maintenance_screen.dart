import 'package:flutter/material.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';

class ServerMaintenanceScreen extends StatelessWidget {
  const ServerMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(title: '서버 점검'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 3 * 2,
              height: MediaQuery.of(context).size.width / 3 * 2,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 48.0),
            Text(
              '더 나은 서비스를 위해',
              style: MyTextStyle.headTitle,
              textAlign: TextAlign.center,
            ),
            Text(
              '서버를 점검하고 있습니다.',
              style: MyTextStyle.headTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            Text(
              '잠시만 기다려 주세요.',
              style: MyTextStyle.bodyTitleBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }
}
