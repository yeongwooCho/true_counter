import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/festival/view/home_screen.dart';
import 'package:true_counter/my_page/view/my_page_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with TickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: getItems().length, vsync: this);
    controller?.addListener(tabListener);
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: SizedBox(
        child: renderBottomNavigationBar(),
      ),
      child: Center(
        child: TabBarView(
          controller: controller,
          children: [
            Center(child: Text('111')),
            HomeScreen(),
            MyPageScreen(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar renderBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 1.0,
      backgroundColor: BACKGROUND_COLOR,
      selectedItemColor: DEFAULT_TEXT_COLOR,
      selectedFontSize: 12.0,
      unselectedItemColor: MIDDLE_GREY_COLOR,
      unselectedFontSize: 12.0,
      onTap: (int index) {
        controller?.animateTo(index);
      },
      items: getItems(),
      currentIndex: controller!.index,
    );
  }

  List<BottomNavigationBarItem> getItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.list,
          size: 32.0,
        ),
        label: '행사리스트',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home_outlined,
          size: 32.0,
        ),
        label: '홈',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person_outline_rounded,
          size: 32.0,
        ),
        label: '마이페이지',
      ),
    ];
  }

  void tabListener() {
    setState(() {});
  }
}
