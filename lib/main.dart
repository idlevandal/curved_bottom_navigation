import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    MyUser(),
    MyAdd(),
    MyList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curved Bottom Nav Bar'),
        centerTitle: true,
      ),
      body: _children[_currentIndex],
      backgroundColor: Colors.blueGrey[300],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueGrey[300],
        color: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        height: 60.0,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        items: <Widget>[
          Icon(Icons.verified_user, size: 22.0, color: Colors.white),
          Icon(Icons.add, size: 22.0, color: Colors.white),
          Icon(Icons.list, size: 22.0, color: Colors.white),
        ],
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
      ),
    );
  }
}

class MyUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyParent(meText: 'This is the USER page', iconData: Icons.people_outline,);
  }
}

class MyAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyParent(meText: 'This is the ADD page', iconData: Icons.add,);
  }
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyParent(meText: 'This is the LIST page', iconData: Icons.featured_play_list,);
  }
}

// main parent widget
class MyParent extends StatefulWidget {
  final IconData iconData;
  final String meText;
  MyParent({this.meText, this.iconData});

  @override
  _MyParentState createState() => _MyParentState();
}

class _MyParentState extends State<MyParent> with TickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this
    );
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeInCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(widget.iconData, size: 110.0,color: Colors.white),
          SizedBox(height: 40.0,),
          MyBody(myText: widget.meText,)
        ],
      ),
    );
  }
}

// main body of widget
class MyBody extends StatelessWidget {
  final String myText;

  MyBody({this.myText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          myText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}





