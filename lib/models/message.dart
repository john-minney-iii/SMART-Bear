class Message {
  String authorId;
  String chatRoomId;
  String message;

  Message(
      {required this.authorId,
      required this.chatRoomId,
      required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        authorId: json['AuthorId'],
        chatRoomId: json['ChatRoomId'],
        message: json['Message']);
  }

  Map<String, dynamic> getJson() {
    return {'AuthorId': authorId, 'ChatRoomId': chatRoomId, 'Message': message};
  }
}
