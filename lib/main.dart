import 'package:flutter/material.dart';
import 'home_about.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
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
  @override
  void initState() {
    super.initState();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          title: Text(
            "dictionary",
            style: GoogleFonts.concertOne(
              textStyle: TextStyle(
                fontSize: 30,
                letterSpacing: 2.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.article),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [layoutHomeAbout(0, context), layoutHomeAbout(1, context)],
        ),
      ));
}
