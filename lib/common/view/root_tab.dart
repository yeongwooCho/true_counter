import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/festival/provider/festival_provider.dart';
import 'package:true_counter/festival/view/home_screen.dart';
import 'package:true_counter/festival_list/view/festival_list_screen.dart';
import 'package:true_counter/my_page/view/my_page_screen.dart';
import 'package:true_counter/user/repository/user_repository.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with TickerProviderStateMixin {
  TabController? controller;
  final UserRepositoryInterface _userRepository = UserRepository();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: getItems().length,
      vsync: this,
      initialIndex: 1,
    );
    controller?.addListener(tabListener);
    _userRepository.userInfo();
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    final festivalProvider = context.read<FestivalProvider>();
    festivalProvider.getFestivals();
    setState(() {
      isLoading = false;
    });

    return DefaultLayout(
      isLoading: isLoading,
      bottomNavigationBar: SizedBox(
        child: renderBottomNavigationBar(),
      ),
      child: Center(
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            FestivalListScreen(),
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

  Future<bool> getUserInfo() async {
    final isSuccessGetUserInfo = await _userRepository.userInfo();
    debugPrint("유저정보 가져오기 성공?: $isSuccessGetUserInfo");
    return isSuccessGetUserInfo;
  }

  void tabListener() {
    setState(() {});
  }
}
