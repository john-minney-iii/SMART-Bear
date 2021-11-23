class ChatRoom {
  List<String> userIds;
  bool isOpen;

  ChatRoom({required this.userIds, required this.isOpen});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(userIds: List.from(json['Users']), isOpen: json['IsOpen']);
  }

  Map<String, dynamic> getJson() {
    return {
      'Users': [userIds[0], userIds[1]],
      'IsOpen': isOpen
    };
  }
}
