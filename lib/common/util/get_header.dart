import 'dart:io';

import 'package:true_counter/common/model/app_info.dart';
import 'package:true_counter/user/model/user_model.dart';

// TODO: 해당 요청은 유저 authorization 이 필요한 모든 http request 에 등록 되어야 함.
Map<String, String> getHeaders({
  bool isJson = true,
}) {
  Map<String, String> headers = {
    // TODO: 이거 두개 어차피 body 에서 보내는데 header 에도 보내야 하는지 의문
    'App-Version': '${AppInfo.currentVersion}',
    'device': Platform.isIOS ? 'ios' : 'android'
  };

  if (isJson) headers['Content-Type'] = 'application/json';

  // TODO: 보통 'Bearer token' 으로 집어 넣음. email 을 따로 넣지 않아도 됨
  // if (UserModel.current != null) {
  //   headers['X-User-Email'] = UserModel.current!.email;
  //   headers['X-User-Token'] = UserModel.current!.token;
  // }

  if (UserModel.current != null) {
    // headers['Authorization'] = 'Bearer ${UserModel.current!.token}';
  }

  return headers;
}
