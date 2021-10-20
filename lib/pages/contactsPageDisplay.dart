// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_contact/contacts.dart';
// import 'dart:async';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:full_text_search/full_text_search.dart';
// import 'package:logging/logging.dart';
// import 'package:logging_config/logging_config.dart';
// import 'package:sunny_dart/sunny_dart.dart';
// import 'contactsPage.dart';
// import 'dart:core';
// import 'reminder.dart';
//
// //
// //
// class ContactsPage extends StatefulWidget {
//   @override
//   _ContactsPageState createState() => _ContactsPageState();
// }
//
// class _ContactsPageState extends State<ContactsPage> {
//   late ContactService _contactService;
//   List<Contact> _contacts = [];
//   bool _loading = false;
//   String? searchTerm;
//   String _searchTerm = '';
//
//   //for select of the data
//   var tmpArray = [];
//
//   get values => null;
//
//   getCheckboxItems() {
//     values.forEach((key, value) {
//       if (value == true) {
//         tmpArray.add(key);
//       }
//     });
//     print(tmpArray);
//     tmpArray.clear();
//   }
//
//   //end
//
//   @override
//   void initState() {
//     super.initState();
//     configureLogging(LogConfig.root(Level.INFO, handler: LoggingHandler.dev()));
//     _contactService = UnifiedContacts;
//     refreshContacts();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   Future<void> refreshContacts([bool showIndicator = true]) async {
//     if (showIndicator) {
//       setState(() {
//         _loading = true;
//       });
//     }
//     List<Contact> _newList;
//     if (_searchTerm.isNotNullOrBlank) {
//       _newList = [
//         ...await FullTextSearch<Contact>.ofStream(
//           term: _searchTerm,
//           items: _contactService.streamContacts(),
//           tokenize: (contact) {
//             return [
//               contact.givenName,
//               contact.familyName,
//               ...contact.phones
//                   .expand((number) => tokenizePhoneNumber(number.value)),
//             ].where((s) => s != null && s != '').toList();
//           },
//           ignoreCase: true,
//           isMatchAll: true,
//           isStartsWith: true,
//         ).execute().then((results) => [
//               for (var result in results) result.result,
//             ])
//       ];
//     } else {
//       final contacts = _contactService.listContacts(
//           withUnifyInfo: true,
//           withThumbnails: true,
//           withHiResPhoto: false,
//           sortBy: ContactSortOrder.firstName());
//       var tmp = <Contact>[];
//       while (await contacts.moveNext()) {
//         (await contacts.current)?.let((self) => tmp.add(self));
//       }
//       _newList = tmp;
//     }
//     setState(() {
//       if (showIndicator) {
//         _loading = false;
//       }
//       _contacts = _newList;
//     });
//   }
//
//   Future updateContact() async {
//     final ninja = _contacts.toList().firstWhere(
//         (contact) => contact.familyName?.startsWith('Ninja') == true);
//     ninja.avatar = null;
//     await _contactService.updateContact(ninja);
//
//     await refreshContacts();
//   }
//
//   Future _openContactForm() async {
//     final contact = await Contacts.openContactInsertForm();
//     if (contact != null) {
//       await refreshContacts();
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Imports Contacts',
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         actions: <Widget>[
//           TextButton(
//             child: Text('Next'),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => MyReminder()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await refreshContacts();
//         },
//         child: CustomScrollView(
//           slivers: [ SliverToBoxAdapter(
//               child: Row(
//                 children: <Widget>[Container(
//
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.only(left: 15,right: 15,top: 10),
//                   decoration: BoxDecoration(
//                    // color: Colors.white,
//                   ),
//
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "Select the phone contacts you'd like to add to Dex.",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                       SizedBox(height: 0),
//                     ],
//                   ),
//                 ),],
//               ),
//             ),
//             // SliverToBoxAdapter(
//             //   child: AnimatedSwitcher(
//             //     duration: Duration(milliseconds: 300),
//             //     child: _loading == true
//             //         ? Padding(
//             //             padding: const EdgeInsets.all(10),
//             //             child: Center(
//             //               child: CircularProgressIndicator(),
//             //             ),
//             //           )
//             //         : const SizedBox(),
//             //   ),
//             // ),
//             SliverToBoxAdapter(
//               key: Key('searchBox'),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
//                 child: Center(
//
//                     child: TextField(
//                         onChanged: (term) async {
//                         _searchTerm = term;
//                         await refreshContacts(false);
//                         },
//                         decoration: InputDecoration(
//                           isDense: true,
//                           contentPadding: EdgeInsets.all(13),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                           ),
//                       filled: true,
//                       hintStyle: TextStyle(color: Colors.grey[800]),
//                       hintText: "Search",
//                       fillColor: Colors.white70),
//                     ),
//                   ),
//                 ),
//             ),
//             ..._contacts.map((contact) {
//               child: AnimatedSwitcher(
//                 duration: Duration(milliseconds: 300),
//                 child: _loading == true
//                     ? Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 )
//                     : const SizedBox(),
//               );
//               return SliverToBoxAdapter(
//                 child: ListTile(
//                   onTap: () async {
//
//                   },
//                   leading: (contact.avatar != null &&
//                           contact.avatar.isNotNullOrEmpty)
//                       ? CircleAvatar(
//                           backgroundImage: MemoryImage(contact.avatar!))
//                       : CircleAvatar(child: Text(contact.initials())),
//                   title: Text(contact.displayName ?? ''),
//                   trailing: (contact.linkedContactIds.length) < 2
//                       ? null
//                       : InputChip(
//                           avatar: CircleAvatar(
//                               child:
//                                   Text('${contact.linkedContactIds.length}')),
//                           label: Text('Linked'),
//                         ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //
// // class ContactsPage extends StatefulWidget {
// //   late final String title;
// //   final String reloadLabel = 'Reload!';
// //   final String fireLabel = 'Fire in the hole!';
// //   final Color floatingButtonColor = Colors.red;
// //   final IconData reloadIcon = Icons.refresh;
// //   final IconData fireIcon = Icons.filter_center_focus;
// //
// //   @override
// //   _MyHomePageState createState() => new _MyHomePageState(
// //     floatingButtonLabel: this.fireLabel,
// //     icon: this.fireIcon,
// //     floatingButtonColor: this.floatingButtonColor,
// //   );
// // }
// //
// // class _MyHomePageState extends State<ContactsPage> {
// //   List<Contact> _uiCustomContacts = new List<Contact>();
// //   List<CustomContact> _allContacts = List<CustomContact>();
// //   bool _isLoading = false;
// //   bool _isSelectedContactsView = false;
// //   String floatingButtonLabel;
// //   Color floatingButtonColor;
// //   IconData icon;
// //
// //   _MyHomePageState({
// //     required this.floatingButtonLabel,
// //     required this.icon,
// //     required this.floatingButtonColor,
// //   });
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     getContactsPermission().then((granted) {
// //       if (granted) {
// //         refreshContacts();
// //       } else {
// //         showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //             title: const Text('Oops!'),
// //             content: const Text('Looks like permission to read contacts is not granted.'),
// //             actions: <Widget>[
// //               FlatButton(
// //                 child: const Text('OK'),
// //                 onPressed: () => Navigator.pop(context),
// //               ),
// //             ],
// //           ),
// //         );
// //       }
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return new Scaffold(
// //       appBar: new AppBar(
// //         title: new Text(widget.title),
// //       ),
// //       body: !_isLoading
// //           ? Container(
// //         child: ListView.builder(
// //           itemCount: _uiCustomContacts?.length,
// //           itemBuilder: (BuildContext context, int index) {
// //             CustomContact _contact = _uiCustomContacts[index];
// //             var _phonesList = _contact.contact.phones!.toList();
// //
// //             return _buildListTile(_contact, _phonesList);
// //           },
// //         ),
// //       )
// //           : Center(
// //         child: CircularProgressIndicator(),
// //       ),
// //       floatingActionButton: new FloatingActionButton.extended(
// //         backgroundColor: floatingButtonColor,
// //         onPressed: _onSubmit,
// //         icon: Icon(icon),
// //         label: Text(floatingButtonLabel),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //     );
// //   }
// //
// //   void _onSubmit() {
// //     setState(() {
// //       if (!_isSelectedContactsView) {
// //         _uiCustomContacts =
// //             _allContacts.where((contact) => contact.isChecked == true).cast<Contact>().toList();
// //         _isSelectedContactsView = true;
// //         _restateFloatingButton(
// //           widget.reloadLabel,
// //           Icons.refresh,
// //           Colors.green,
// //         );
// //       } else {
// //         _uiCustomContacts = _allContacts;
// //         _isSelectedContactsView = false;
// //         _restateFloatingButton(
// //           widget.fireLabel,
// //           Icons.filter_center_focus,
// //           Colors.red,
// //         );
// //       }
// //     });
// //   }
// //
// //   ListTile _buildListTile(CustomContact c, List<Item> list) {
// //     return ListTile(
// //       leading: (c.contact.avatar != null)
// //           ? CircleAvatar(backgroundImage: MemoryImage(c.contact.avatar))
// //           : CircleAvatar(
// //         child: Text(
// //             (c.contact.displayName![0] +
// //                 c.contact.displayName![1].toUpperCase()),
// //             style: TextStyle(color: Colors.white)),
// //       ),
// //       title: Text(c.contact.displayName ?? ""),
// //       subtitle: list.length >= 1 && list[0]?.value != null
// //           ? Text(list[0].value)
// //           : Text(''),
// //       trailing: Checkbox(
// //           activeColor: Colors.green,
// //           value: c.isChecked,
// //           onChanged: (bool value) async {
// //             setState(() {
// //               c.isChecked = value;
// //             });
// //           }),
// //     );
// //   }
// //
// //   void _restateFloatingButton(String label, IconData icon, Color color) {
// //     floatingButtonLabel = label;
// //     icon = icon;
// //     floatingButtonColor = color;
// //   }
// //
// //   refreshContacts() async {
// //     setState(() {
// //       _isLoading = true;
// //     });
// //     var contacts = await ContactsService.getContacts();
// //     _populateContacts(contacts);
// //   }
// //
// //   void _populateContacts(contacts) {
// //     _contacts = contacts.where((item) => item.displayName != null).toList();
// //     _contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
// //     _allContacts =
// //         _contacts.map((contact) => CustomContact(contact: contact)).toList();
// //     setState(() {
// //       _uiCustomContacts = _allContacts;
// //       _isLoading = false;
// //     });
// //   }
// //
// //   Future<bool> getContactsPermission() =>
// //       SimplePermissions.requestPermission(Permission.ReadContacts);
// // }
// //
// // class _contacts {
// // }
// //
// // class CustomContact {
// //   final Contact contact;
// //   bool isChecked;
// //
// //   CustomContact({
// //     required this.contact,
// //     this.isChecked = false,
// //   });
// // }

