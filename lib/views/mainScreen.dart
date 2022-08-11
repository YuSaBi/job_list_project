//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_list_project/views/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// MAIN CLASS ///
class MainScreen extends StatefulWidget{
  //String userName;
  //MainScreen(this.userName);

  @override
  State<StatefulWidget> createState() {
    //return _MainScreenState(userName);
    return _MainScreenState();
  }

}
/// MAIN STATE ///
class _MainScreenState extends State<MainScreen> {
  // shared preferences dan kullanıcı adı çekilecek
  /*late SharedPreferences sharedPreferences;*/
  //String userName;

  @override
  void initState() {
    super.initState();
    /*checkLoginStatus();*/
  }

  /*checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("userID").toString()==null || sharedPreferences.getString("userID").toString()=="0") {// .toString() isteye bilir!!!!
      //Navigator.push(context,MaterialPageRoute(builder: (context) => loginScreen()));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainScreen()), (Route<dynamic> route) => false);
    }
  }*/

  //_MainScreenState(this.userName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Hoşgeldiniz"),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              /*sharedPreferences.clear();*/
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginScreen()), (Route<dynamic> route) => false);
            },
            child: Text("Çıkış yap",style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: Form(child: buildBody())
    );
  }
  
  buildBody() {
    /*print("shared pref üyesi = "+sharedPreferences.getString("userID").toString());*/
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // üst tarafa bişeyler eklersek.
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("asdasd"),
          ),
          _IsGirisBtn(),
          _IsListeleBtn(),
        ],
      ),
    );
    
  }
  
  _IsGirisBtn() => ButtonTheme(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        onSurface: Colors.amber,
        minimumSize: Size(120.0, 40.0)
      ),
      child: Text("İş ekleme"),
      onPressed: () {
        return null;
      },
    ),
  );
  
  _IsListeleBtn() => ButtonTheme(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        onSurface: Colors.amber,
        minimumSize: Size(120.0, 40.0)
      ),
      child: Text("İşleri listele"),
      onPressed: () {
        return null;
      },
    ),
  );

}
