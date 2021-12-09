import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {Key? key,
      required this.text,
      required this.isCurrentUser,
      required this.attachmentPath})
      : super(key: key);

  final String text;
  final bool isCurrentUser;
  final String attachmentPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          isCurrentUser ? 64.0 : 16.0, 4.0, isCurrentUser ? 16.0 : 64.0, 4.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: _bubbleContent(context))),
      ),
    );
  }

  Widget _bubbleContent(BuildContext context) {
    if (attachmentPath != '') {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: isCurrentUser ? Colors.white : Colors.black87),
              ),
            ),
          ),
          _showMessageAttachment()
        ],
      );
    }
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: isCurrentUser ? Colors.white : Colors.black87),
    );
  }

  Widget _showMessageAttachment() {
    return FutureBuilder(
        future: _getDownloadLink(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Image.network(snapshot.data.toString(),
                width: 150, height: 150);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Future<String> _getDownloadLink() async {
    return await FirebaseStorage.instance
        .ref()
        .child(attachmentPath)
        .getDownloadURL();
  }
}
