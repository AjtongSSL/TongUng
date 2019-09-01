import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tong_ung/models/product_model.dart';
import 'package:tong_ung/srceens/detail.dart';
import 'package:tong_ung/srceens/home.dart';
import 'package:tong_ung/srceens/my_style.dart';
import 'package:tong_ung/srceens/show_list_product.dart';
import 'package:tong_ung/srceens/show_map.dart';
import 'package:barcode_scan/barcode_scan.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  //Explicit
  String nameLogin = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget myWidget = ShowListProduct();
  String QrCode = '';
  List<ProductModel> productModels = [];

  //Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
    readProduct();
  }

  Future<void> readProduct() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapShots = response.documents;
      for (var snapShot in snapShots) {
        ProductModel productModel = ProductModel(
            snapShot.data['Name'],
            snapShot.data['Detail'],
            snapShot.data['Path'],
            snapShot.data['QRcode']);
        productModels.add(productModel);
      }
    });
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
      onTap: () {
        setState(() {
          myWidget = ShowListProduct();
          Navigator.of(context).pop();
        });
      },
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
      onTap: () {
        setState(() {
          myWidget = ShowMap();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget showReadQRmenu() {
    return ListTile(
      leading: Icon(
        Icons.android,
        size: 36.0,
        color: Colors.green,
      ),
      title: Text('Read QR Code'),
      subtitle: Text('Read Product by QR Code or Bar Code'),
      onTap: () {
        processReadQRCode();
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> processReadQRCode() async {
    try {
      QrCode = await BarcodeScanner.scan();
      // print('QR Code : $QrCode');
      for (var productModel in productModels) {
        if (QrCode == productModel.qrCode) {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => Detail(
                    productModel: productModel,
                  ));
          Navigator.of(context).push(materialPageRoute);
        }
      }
    } catch (e) {}
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
          showReadQRmenu(),
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
        backgroundColor: MyStyle().textColor,
      ),
      //body: Text('body'),
      body: myWidget,
      drawer: menuDrawer(),
    );
  }
}
