import 'package:flutter/material.dart';
import 'dart:async';

class MyReminder extends StatefulWidget {
  const MyReminder({Key? key}) : super(key: key);
  @override
  _MyReminderState createState() => _MyReminderState();
}

class _MyReminderState extends State<MyReminder> {
  @override
  Widget build(BuildContext context) {
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

                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.only(left: 15,right: 15,top: 10),
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
                        ),),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
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
  }
}
