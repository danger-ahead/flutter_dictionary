import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'home_about.dart';
import 'AppConnectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map _source = {ConnectivityResult.none: false};
  AppConnectivity _connectivity = AppConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    String connectionStatus = '';
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        connectionStatus = " Offline";
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        connectionStatus = " Online";
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: Colors.blue,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "D I C T I O N A R Y ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text("$connectionStatus"),
                    ], //row-children
                  ), //Row
                ) //Padding
              ] //column-children
                  ) //Column
              ), //Container
          Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
                child: Center(
                  child: layoutHomeAbout(selected, context),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ), //BoxDecoration
              ) //Container
              ) //Padding
        ],
      ), //Stack
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article_outlined,
            ),
            label: 'About',
          ),
        ],
        onTap: tapBottomNavBar,
        currentIndex: selected,
      ), //BottomNavigationBar
    ); //Scaffold
  }

  void tapBottomNavBar(int integer) {
    setState(() {
      selected = integer;
    });
  }
}
