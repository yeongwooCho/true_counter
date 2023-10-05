import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/chat/view/chat_screen.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/festival/component/custom_festival_card.dart';
import 'package:true_counter/festival/model/festival_model.dart';
import 'package:true_counter/festival/provider/festival_provider.dart';

class FestivalDetailScreen extends StatefulWidget {
  final FestivalModel festivalModel;

  const FestivalDetailScreen({
    Key? key,
    required this.festivalModel,
  }) : super(key: key);

  @override
  State<FestivalDetailScreen> createState() => _FestivalDetailScreenState();
}

class _FestivalDetailScreenState extends State<FestivalDetailScreen> {
  String? chatText;
  TextEditingController? chatController;
  FocusNode? chatFocus;

  @override
  void initState() {
    super.initState();

    chatController = TextEditingController();
    chatFocus = FocusNode();
  }

  @override
  void dispose() {
    chatFocus?.dispose();
    chatController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final provider = context.watch<FestivalProvider>();
    final festival =
        provider.cache[widget.festivalModel.id] ?? widget.festivalModel;

    return DefaultLayout(
      isLoading: provider.cache[widget.festivalModel.id] == null,
      appbar: const DefaultAppBar(title: '행사 상세정보'),
      bottomNavigationBar: SizedBox(
        height: 64.0 + bottomInset,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: CustomTextFormField(
            controller: chatController,
            focusNode: chatFocus,
            onEditingComplete: () {
              if (chatController != null && chatFocus != null) {
                chatText = chatController!.text;
                chatController!.clear();
                chatFocus!.unfocus();

                // TODO: request 댓글작성

                setState(() {});
              }
            },
            onSaved: (String? value) {},
            validator: (String? value) {
              return null;
            },
            hintText: '댓글을 입력해 주세요.',
            suffixIcon: const Icon(Icons.edit),
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _renderFestivalDescription(
                    context: context,
                    festivalModel: festival,
                  ),
                  const SizedBox(height: 48.0),
                  CustomFestivalCard(festivalModel: festival),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              color: LIGHT_GREY_COLOR,
              height: 10.0,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '응원 댓글',
                    style: headTitleTextStyle,
                  ),
                  const SizedBox(height: 16.0),
                  _renderDescriptionContainer(),
                  const SizedBox(height: 32.0),
                  ChatScreen(
                    chats: festival.chats
                        .where((element) => element.parentChatId != 0)
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderFestivalDescription({
    required BuildContext context,
    required FestivalModel festivalModel,
  }) {
    String start = convertDateTimeToDateString(datetime: festivalModel.startAt);
    String end = convertDateTimeToDateString(datetime: festivalModel.endAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _renderDescriptionRow(
          title: '행사명',
          description: "[${festivalModel.region}] ${festivalModel.title}",
        ),
        const SizedBox(height: 24.0),
        _renderDescriptionRow(
          title: '주최자/단체',
          description: festivalModel.applicant,
        ),
        const SizedBox(height: 24.0),
        _renderDescriptionRow(
          title: '행사 장소',
          description: festivalModel.address,
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              RouteNames.kakaoMap,
              arguments: ScreenArguments<LatLng>(
                data: LatLng(
                  festivalModel.latitude,
                  festivalModel.longitude,
                ),
              ),
            );
          },
          style: secondButtonStyle,
          child: const Text('지도 보기'),
        ),
        const SizedBox(height: 24.0),
        _renderDescriptionRow(
          title: '행사 기간',
          description: "$start ~ $end",
        ),
        if (festivalModel.message.isNotEmpty) const SizedBox(height: 24.0),
        if (festivalModel.message.isNotEmpty)
          _renderDescriptionRow(
            title: '문의/전달사항',
            description: festivalModel.message,
          ),
      ],
    );
  }

  Widget _renderDescriptionRow({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: bodyTitleBoldTextStyle,
        ),
        const SizedBox(height: 4.0),
        Text(
          description,
          style: bodyRegularTextStyle,
        ),
      ],
    );
  }

  Widget _renderDescriptionContainer() {
    return Container(
      decoration: BoxDecoration(
        color: LIGHT_GREY_COLOR,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "◦ 댓글 작성자는 ‘닉네임'으로만 표시됩니다.",
              style: descriptionTextStyle,
            ),
            SizedBox(height: 8.0),
            Text(
              '◦ 서로의 의견이 존중될 수 있도록 배려해 주시고, 타인에게 불쾌감을 줄 수 있는 표현 및 권리침해에 해당하는 내용에 주의 해주세요.',
              style: descriptionTextStyle,
            ),
            SizedBox(height: 8.0),
            Text(
              '◦ 작성한 댓글이 100명 이상에게 신고될 경우 자동 삭제됩니다.',
              style: descriptionTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
