class ChatRoom {
  String id;
  List<String> userIds;
  bool isOpen;

  ChatRoom({required this.id, required this.userIds, required this.isOpen});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
        id: json['Id'],
        userIds: List.from(json['Users']),
        isOpen: json['IsOpen']);
  }

  Map<String, dynamic> getJson() {
    return {
      'Id': id,
      'Users': [userIds[0], userIds[1]],
      'IsOpen': isOpen
    };
  }
}
