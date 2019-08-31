import 'package:flutter/material.dart';
import 'package:tong_ung/srceens/my_service.dart';
import 'package:tong_ung/srceens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Explicit
  Color textColor = Colors.black;

  //Method
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 5.0,
      height: 10.0,
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: textColor,
      child: Text('Sign In', style: TextStyle(color: Colors.white)),
      onPressed: () {},
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      borderSide: BorderSide(color: textColor),
      child: Text(
        'Sign Up',
        style: TextStyle(color: textColor),
      ),
      onPressed: () {
        print('U Click SignUP');
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Container(
      //color: Colors.grey,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          signInButton(),
          mySizeBox(),
          signUpButton(),
        ],
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 150.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showText() {
    return Text(
      'Tong Ung = ไทย',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bamboo_2.jpg'), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                mySizeBox(),
                showText(),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
