// ignore: import_of_legacy_library_into_null_safe
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class AppContact {
  final Color color;
  Contact info;
  late final Month;
  bool isChecked;

  AppContact({Key, required this.color, required this.info,this.isChecked = false, this.Month = '1'});
}


class SelectedContacts {
  int ContactInfo;
  SelectedContacts({required this.ContactInfo});
}

