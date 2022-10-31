import 'package:flutter/material.dart';

navigateAndFinish(widget, context) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}
