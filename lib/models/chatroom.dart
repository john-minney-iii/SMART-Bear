class ChatRoom {
  List<String> userIds;

  ChatRoom({required this.userIds});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(userIds: List.from(json['Users']));
  }

  Map<String, dynamic> getJson() {
    return {
      'Users': {'0': userIds[0], '1': userIds[1]}
    };
  }
}
