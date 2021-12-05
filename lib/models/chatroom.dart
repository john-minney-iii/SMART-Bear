class ChatRoom {
  String id;
  List<String> userIds;
  bool isOpen;
  String subject;

  ChatRoom(
      {required this.id,
      required this.userIds,
      required this.isOpen,
      required this.subject});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
        id: json['Id'],
        userIds: List.from(json['Users']),
        isOpen: json['IsOpen'],
        subject: json['Subject']);
  }

  Map<String, dynamic> getJson() {
    return {
      'Id': id,
      'Users': [userIds[0], userIds[1]],
      'IsOpen': isOpen,
      'Subject': subject
    };
  }
}
