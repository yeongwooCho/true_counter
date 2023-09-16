import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_drop_down_button.dart';
import 'package:true_counter/common/const/data.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/data.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/festival/component/custom_festival_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = locations.first;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '트루카운터',
        action: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_outlined,
              size: 32.0,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.notification,
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 32.0,
            ),
          )
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '오늘 행사',
                    style: titleTextStyle,
                  ),
                  SizedBox(
                    width: 180.0,
                    child: CustomDropDownButton(
                      dropdownList: locationData,
                      defaultValue: location,
                      onChanged: (String? value) {
                        if (value != null) {
                          location = value;
                          setState(() {});
                        }
                      },
                      menuMaxHeight: 465.0,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              CustomFestivalCard(
                title: '[서울] 대한민국에서 열리는 광복 100주년 맞이 광화문에서 열리는 축제',
                cumulativeParticipant: 10000,
                radius: 500,
              ),
              const SizedBox(height: 16.0),
              CustomFestivalCard(
                title: '[서울] 대한민국에서 열리는 광복 100주년 맞이 광화문에서 열리는 축제',
                cumulativeParticipant: 10000,
                radius: 500,
              ),
              const SizedBox(height: 16.0),
              CustomFestivalCard(
                title: '[서울] 대한민국에서 열리는 광복 100주년 맞이 광화문에서 열리는 축제',
                cumulativeParticipant: 10000,
                radius: 500,
              ),
              const SizedBox(height: 16.0),
              CustomFestivalCard(
                title: '[서울] 대한민국에서 열리는 광복 100주년 맞이 광화문에서 열리는 축제',
                cumulativeParticipant: 10000,
                radius: 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
