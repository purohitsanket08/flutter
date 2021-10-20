import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';
import 'components/contact-avatar.dart';
import 'contactsPage.dart';
import 'components/app-contact.class.dart';

class MyReminder extends StatefulWidget {

  final List SelectedContacts;
  final List<AppContact> Contacts;
  // //NextPage({Key key, this.value}) : super(key: key);
  MyReminder({required this.SelectedContacts,required this.Contacts });

  @override
  _MyReminderState createState() => _MyReminderState();
}

class _MyReminderState extends State<MyReminder> {
  @override
  Widget build(BuildContext context) {
    print(widget.SelectedContacts);
    print(widget.Contacts);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set contact Frequncy'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: <Widget>[
          TextButton(
            child: Text('Done'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data  Saved Successfully')));
            },
          ),
        ],
      ),
      body: new Container(
        padding: new EdgeInsets.all(1.0),
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[Container(

              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "select how often you'd like Dex to remund you to keep in touch",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  SizedBox(height: 10),
                  Text("10 Keep-in-touch frequencies left to set",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
              new Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.Contacts.length,
                  itemBuilder: (context, index) {
                    AppContact contact = widget.Contacts[index];

                    var isSelected;
                    return ListTile(
                      contentPadding: EdgeInsets.only(
                          top: 2, bottom: 5, left: 10, right: 10),
                      title: Text(contact.info.displayName),
                      leading: ContactAvatar(contact, 36),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          ToggleButtons(
                            children: <Widget>[
                              Text("none"),
                              Text("1 mo"),
                              Text("3 mo"),
                              Text("6 mo"),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                contact.Month = isSelected;
                              });
                            },
                            isSelected: isSelected,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

                          // <Widget>[
                          //   FlatButton(
                          //       minWidth: 60,
                          //       color: Colors.blue,
                          //       textColor: Colors.white,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10)),
                          //       child: Text('none',),
                          //   ),
                          //   SizedBox(width: 10),
                          //   FlatButton(
                          //       minWidth: 60,
                          //       color: Colors.blue,
                          //       textColor: Colors.white,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10)),
                          //       child: Text('1 mo')),
                          //   SizedBox(width: 10),
                          //   FlatButton(
                          //       onPressed: () {
                          //       },
                          //       minWidth: 60,
                          //       color: Colors.blue,
                          //       textColor: Colors.white,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10)),
                          //       child: Text('3 mo')),
                          //   SizedBox(width: 10),
                          //   FlatButton(
                          //       onPressed: () {
                          //       },
                          //       minWidth: 60,
                          //       color: Colors.blue,
                          //       textColor: Colors.white,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10)),
                          //       child: Text('6 mo')),
                          // ],

      //             ),
      //         ),
      //
      //       ],
      //     ),
      //   ),
      //
      // ),
    //);
    // Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.max,
    //     children: <Widget>[
    //       SizedBox(
    //         height: 100,
    //       ),
    //       SeasonDetails(
    //         details: SeasonDetailsModel(
    //           title: 'SEASON 1',
    //           description:
    //               'This season covers the absolute basics of Flutter Web Dev to get us up and running with a basic web app.',
    //         ),
    //       ),
    //       SizedBox(
    //         height: 50,
    //       ),
    //     ]),

