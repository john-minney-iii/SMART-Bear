import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar globalAppBar(
    BuildContext context, String title, bool applyLeading, bool includeLogout) {
  return AppBar(
      title: Text(title),
      backgroundColor: const Color(0xff173f5f),
      automaticallyImplyLeading: (applyLeading) ? true : false);
}
