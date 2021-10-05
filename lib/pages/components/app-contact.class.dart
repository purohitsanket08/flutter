import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class AppContact {
  final Key key;
  final Color color;
  Contact info;

  AppContact({required this.key,required this.color,required this.info});
}