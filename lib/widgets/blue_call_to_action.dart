import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget blueCallToAction(String text, function) {
  return Container(
      height: 50.0,
      width: 250.0,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
      child: TextButton(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 25.0),
        ),
        onPressed: function,
      ));
}
