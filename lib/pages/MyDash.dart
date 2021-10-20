import 'dart:async';
import 'package:flutter/material.dart';
import 'contactsPage.dart';
import 'contactsPageDisplay.dart';

class MyDash extends StatefulWidget {
  const MyDash({Key? key}) : super(key: key);

  @override
  _MyDashState createState() => _MyDashState();
}

class _MyDashState extends State<MyDash> {
  @override

  int _selectedIndex = 0;
  final List<Widget> _childern = [];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Good Morning SKt'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: Column(children: <Widget>[
        new Row(
        //ROW 1
        children: <Widget>[Container(

          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: 15),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Welcome to Lead Managemenet!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),
              Text("You Can get started with any of these  actions for managing your relationship:",
              style: TextStyle(
                fontSize: 17.0,
              ),),
            ],
          ),
        ),],),
        Row(
            children: <Widget>[Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize:  MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    height: 80,
                    padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.supervised_user_circle_rounded, size: 18,)
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Add To Contact",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),


                  SizedBox(height: 15),

                  Container(
                    height: 80,
                    padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MyHomePage(),
                        ));
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.mobile_screen_share_sharp, size: 18)
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text("Import your phone contacts", textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  Container(
                    height: 80,
                    padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.calendar_today, size: 18)
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text("Sync Your Calender", textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                ],
              ),
            ),]
        ),
      ],
      ),

        // <Widget>[
        //   Container(
        //     child: Text(""),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        //   ),
        //   child: Text(""),
        // ],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Colors.black12,
        unselectedItemColor: Colors.black,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),

            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_cal_outlined),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outlined),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Infomation',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Infomation',

          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
