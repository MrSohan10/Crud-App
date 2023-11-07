import 'package:flutter/material.dart';

InputDecoration textFormStyle(label, hind) {
  return InputDecoration(
    border: const OutlineInputBorder(),
    labelText: label,
    hintText: hind,
    contentPadding: EdgeInsets.all(16)
  );
}
