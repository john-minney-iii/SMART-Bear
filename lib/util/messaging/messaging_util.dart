import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';

Future<ChatRoom> accountListTileOnTap(String id, String id2) async {
  ChatRoom? _chatRoom = await getChatRoomByUsers(id, id2);
  _chatRoom ??= await startNewChatRoom(id, id2);
  return _chatRoom;
}

Future<ChatRoom> startNewChatRoom(String id, String id2) async {
  ChatRoom _chatRoom =
      ChatRoom(id: id + '_' + id2, userIds: [id, id2], isOpen: true);
  createChatRoom(_chatRoom);
  return _chatRoom;
}
