import 'package:true_counter/user/model/user_model.dart';

class ChatModel {
  late int id;
  late int? parentChatId;
  late String nickName;
  late String content;
  late int chatLike;
  late int declaration;
  late DateTime createdAt;

  // TODO: Dummy
  ChatModel({
    required this.id,
    required this.parentChatId,
    required this.nickName,
    required this.content,
    required this.createdAt,
    this.chatLike = 0,
    this.declaration = 0,
  });

  ChatModel._internal();

  factory ChatModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    ChatModel chatModel = ChatModel._internal();

    chatModel.id = json['id'];
    chatModel.parentChatId = json['parentChatId'];
    chatModel.nickName = json['nickName'] ?? '';
    chatModel.content = json['content'] ?? '';
    chatModel.chatLike = json['chatLike'] ?? 0;
    chatModel.declaration = json['declaration'] ?? 0;
    chatModel.createdAt = DateTime.parse(json['createdAt']);

    return chatModel;
  }

  @override
  String toString() {
    return 'ChatModel ('
        'id: $id, '
        'parentChatId: $parentChatId, '
        'nickName: $nickName, '
        'content: $content, '
        'chatLike: $chatLike, '
        'declaration: $declaration, '
        'createdAt: $createdAt, '
        ')';
  }

  ChatModel copyWith({
    int? id,
    int? parentChatId,
    String? nickName,
    String? content,
    int? chatLike,
    int? declaration,
    DateTime? createdAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      parentChatId: parentChatId ?? this.parentChatId,
      nickName: nickName ?? this.nickName,
      content: content ?? this.content,
      chatLike: chatLike ?? this.chatLike,
      declaration: declaration ?? this.declaration,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
