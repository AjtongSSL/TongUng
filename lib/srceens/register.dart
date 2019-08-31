import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Explicit

  //Method
  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.face,
            size: 36.0,
          ),
          labelText: 'Display Name :',
          helperText: 'Type Your Display Name',
          hintText: 'English'),
    );
  }

  Widget emailText() {
    return TextFormField(keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 36.0,
          ),
          labelText: 'Email :',
          helperText: 'Type Your Email',
          hintText: 'you@email.com'),
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 36.0,
          ),
          labelText: 'Password :',
          helperText: 'Type Your Password',
          hintText: 'More 6 character'),
    );
  }

  Widget showText() {
    return ListView(
      padding: EdgeInsets.only(
        left: 50.0,
        right: 50.0,
        top: 80.0,
      ),
      children: <Widget>[
        nameText(),
        emailText(),
        passwordText(),
      ],
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      tooltip: 'Register to Firebase',
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Register'),
        actions: <Widget>[
          registerButton(),
        ],
      ),
      body: showText(),
    );
  }
}
