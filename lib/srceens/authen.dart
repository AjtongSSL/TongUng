import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tong_ung/srceens/my_service.dart';
import 'package:tong_ung/srceens/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Explicit
  Color textColor = MyStyle().textColor;
  final formKey = GlobalKey<FormState>();
  String email = '',
      password = ''; //need initial value for firebase should not be null
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Method
  Widget passwordText() {
    return Container(
      width: 300.0,
      padding: EdgeInsets.only(left: 30.0),
      child: TextFormField(
        obscureText: true,
        //keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Password : ',
          labelStyle: TextStyle(color: textColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColor),
          ),
          hintText: 'More than 6 characters',
        ),
        onSaved: (String value) {
          password = value.trim();
        },
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: 300.0,
      padding: EdgeInsets.only(left: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email : ',
          labelStyle: TextStyle(color: textColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColor),
          ),
          hintText: 'you@email.com',
        ),
        onSaved: (String value) {
          email = value.trim();
        },
      ),
    );
  }

  Widget showAppName() {
    return Container(
      //color: Colors.green,
      //alignment: Alignment.Center ,
      padding: EdgeInsets.only(left: 30.0),
      child: ListTile(
        leading: Container(
          width: 48.0,
          height: 48.0,
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          'Tong Ung',
          style: TextStyle(
            fontSize: MyStyle().h1,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget showAuthen() {
    return Container(
      //decoration: BoxDecoration(color: Colors.lime),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, textColor],
          radius: 1.0,
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showAppName(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return IconButton(
      icon: Icon(
        Icons.navigate_before,
        size: 36.0,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      print('Login Success');
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      print('Error Login');
      String message = response.message;
      mySnackBar(message);
    });
  }

  void mySnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.orange.shade700,
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            showAuthen(),
            backButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyStyle().whiteText,
        child: Icon(
          Icons.navigate_next,
          size: 36.0,
          color: textColor,
        ),
        onPressed: () {
          formKey.currentState.save();
          print('Email : $email , Password : $password');
          checkAuthen();
        },
      ),
    );
  }
}
