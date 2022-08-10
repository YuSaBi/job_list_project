//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }

}

class _MainScreenState extends State {
  // shared preferences dan kullanıcı adı çekilecek
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoşgeldiniz kullanıcı: "),
      ),
      //body: buildBody(),
    );
  }
  
  buildBody() {

  }
}