import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tong_ung/srceens/home.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  //Explicit
  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    await firebaseAuth.currentUser().then((response) {
      setState(() {
        nameLogin = response.displayName;
        print('Login as $nameLogin');
      });
    });
  }

  Widget showListProductMenu() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 36.0,
        color: Colors.blue.shade900,
      ),
      title: Text('Show List Product'),
      subtitle: Text('Page Show All Listview Product'),
    );
  }

  Widget showMapMenu() {
    return ListTile(
      leading: Icon(
        Icons.map,
        size: 36.0,
        color: Colors.yellow.shade900,
      ),
      title: Text('Show Map'),
      subtitle: Text('Page Map & Location'),
    );
  }

  Widget showSignOutMenu() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        size: 36.0,
        color: Colors.red.shade900,
      ),
      title: Text('Log Out'),
      subtitle: Text('Sign out & Move to Home Page'),
      onTap: () {
        processSignOut();
      },
    );
  }

  Future<void> processSignOut() async {
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget myDivider() {
    return Divider(
      color: Colors.grey,
    );
  }

  Widget showImage() {
    return Container(
      width: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Tong_Ung',
      style: TextStyle(fontSize: 24.0),
    );
  }

  Widget showLoginName() {
    return Text(
      'Login by $nameLogin',
      style: TextStyle(color: Colors.pink),
    );
  }

  Widget myHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bamboo_2.jpg'), fit: BoxFit.cover)),
      child: Column(
        children: <Widget>[
          showImage(),
          showAppName(),
          showLoginName(),
        ],
      ),
    );
  }

  Widget menuDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myHeadDrawer(),
          showListProductMenu(),
          myDivider(),
          showMapMenu(),
          myDivider(),
          showSignOutMenu(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: Text('body'),
      drawer: menuDrawer(),
    );
  }
}
