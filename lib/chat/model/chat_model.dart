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
    required this.chatLike,
    required this.declaration,
    required this.createdAt,
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
}
