import 'components/app-contact.class.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contact_sych/pages/reminder.dart';

import 'components/contacts-list.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AppContact> contacts = [];
  List<AppContact> contactsFiltered = [];
  List arrayselected = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();
  bool contactsLoaded = false;

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  arrayadd(add) {
    setState(() {
      arrayselected.add(add);
      print(arrayselected);
    });
  }

  arrayremove(remove) {
    setState(() {
      arrayselected.add(remove);
      print(arrayselected);
    });
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];
    int colorIndex = 0;
    List<AppContact> _contacts =
        (await ContactsService.getContacts()).map((contact) {
      Color baseColor = colors[colorIndex];
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
      return new AppContact(info: contact, color: baseColor);
    }).toList();
    setState(() {
      contacts = _contacts;
      contactsLoaded = true;
    });
  }

  filterContacts() {
    List<AppContact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.info.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.info.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        // ignore: unnecessary_null_comparison
        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    contactsFiltered.forEach((element) {
      print(element);
    });
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist =
        ((isSearching == true && contactsFiltered.length > 0) ||
            (isSearching != true && contacts.length > 0));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Imports Contacts',
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: <Widget>[
          TextButton(
            child: Text('Next'),
            onPressed: () {
              // var route = new MaterialPageRoute(
              //   builder: (BuildContext context) =>
              //   MyReminder(key: key,contacts: [],),
              // );
              // Navigator.of(context).push(route);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => M(text: textToSend,),
              //     ));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyReminder(SelectedContacts: ['Sanket','Devendra','Tukaram'],Contacts:contacts)
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10),
              decoration: BoxDecoration(
                // color: Colors.white,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Select the phone contacts you'd like to add to Dex.",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Search",
                    fillColor: Colors.white70),
              ),
            ),
            contactsLoaded == true
                ? // if the contacts have not been loaded yet
                listItemsExist == true
                    ? // if we have contacts to show
                    ContactsList(
                        reloadContacts: () {
                          getAllContacts();
                        },
                        contacts:
                            isSearching == true ? contactsFiltered : contacts,
                        arrayadd: arrayadd,
                        arrayremove: arrayremove,
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          isSearching
                              ? 'No sea rch results to show'
                              : 'No contacts exist',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ))
                : Container(
                    // still loading contacts
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}


