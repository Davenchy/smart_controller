import 'dart:io';

import 'package:flutter/material.dart';

Future<T?> openModal<T>(
  BuildContext context,
  Widget modal, {
  bool fixKeyboard = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: fixKeyboard && Platform.isAndroid
              ? MediaQuery.of(context).viewInsets.bottom
              : 0,
        ),
        child: modal,
      ),
    ),
    isScrollControlled: true,
  );
}
