class ChatModel {
  late int id;
  late int? parentChatId;
  late String username;
  late String content;
  late int like;
  late int declaration;
  late DateTime createdAt;

  // TODO: Dummy
  ChatModel({
    required this.id,
    required this.parentChatId,
    required this.username,
    required this.content,
    required this.like,
    required this.declaration,
    required this.createdAt,
  });

  ChatModel._internal();

  factory ChatModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    ChatModel chatModel = ChatModel._internal();

    chatModel.id = json['id'] ?? '';
    chatModel.parentChatId = json['parentChatId'] ?? '';
    chatModel.username = json['username'] ?? '';
    chatModel.content = json['content'] ?? '';
    chatModel.like = json['like'] ?? '';
    chatModel.declaration = json['declaration'] ?? '';
    chatModel.createdAt = json['createdAt'] ?? '';

    return chatModel;
  }
}
