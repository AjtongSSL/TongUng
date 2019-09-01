import 'package:flutter/material.dart';
import 'package:tong_ung/models/product_model.dart';

class Detail extends StatefulWidget {
  final ProductModel productModel;

  Detail({Key key, this.productModel}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  //Explicit
  ProductModel myProductModel;

  //Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      myProductModel = widget.productModel;
    });
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.height / 2,
      child: Image.network(
        myProductModel.path,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showText() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(myProductModel.detail),
    );
  }

  Widget showDetail() {
    return ListView(
      children: <Widget>[
        showImage(),
        showText(),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail of ${myProductModel.name}'),
      ),
      //body: Text('${myProductModel.detail}'),
      body: showDetail(),
    );
  }
}
