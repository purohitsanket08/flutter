import 'app-contact.class.dart';
import 'package:flutter/material.dart';
import 'contact-avatar.dart';
import 'dart:core';
import 'package:contact_sych/pages/contactsPage.dart';

class ContactsList extends StatefulWidget {
  final List<AppContact> contacts;
  Function() reloadContacts;
  List<SelectedContacts> arrayselected = [];
  final arrayadd,arrayremove;
  ContactsList({required this.contacts,required this.reloadContacts,this.arrayadd, this.arrayremove});
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {

  @override

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.contacts.length,
        itemBuilder: (context, index) {
          AppContact contact = widget.contacts[index];

          return ListTile(
            title: Text(contact.info.displayName),
            subtitle: Text(
                contact.info.phones.length > 0 ? contact.info.phones.elementAt(0).value : ''
            ),
            leading: ContactAvatar(contact, 36),
            trailing: Checkbox(
                activeColor: Colors.green,
                value: contact.isChecked,
                onChanged: (value) {
                  if(value == true){
                    setState(() {
                      contact.isChecked = value!;
                      widget.arrayadd(index);
                    });
                  }else{
                    setState(() {
                      contact.isChecked = value!;
                      widget.arrayremove(index);
                    });
                  }
                  //print('my text is :$value and index $index');
                  //addvalue(contact.info.identifier, contact.isChecked);
                }),
          );
        },
      ),
    );
  }
}


// class ContactsList extends StatefulWidget {
//   final List<AppContact> contacts;
//   Function() reloadContacts;
//        ContactsList({required this.contacts,required this.reloadContacts});
//
//   List<AppContact> arrayselected = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: contacts.length,
//         itemBuilder: (context, index) {
//           AppContact contact = contacts[index];
//
//           return ListTile(
//             title: Text(contact.info.displayName),
//             subtitle: Text(
//                 contact.info.phones.length > 0 ? contact.info.phones.elementAt(0).value : ''
//             ),
//             leading: ContactAvatar(contact, 36),
//             trailing: Checkbox(
//                 activeColor: Colors.green,
//                 value: contact.isChecked,
//                 onChanged: (value) {
//                   addvalue(contact.info.identifier, index);
//                 }),
//           );
//         },
//       ),
//     );
//   }
// }
