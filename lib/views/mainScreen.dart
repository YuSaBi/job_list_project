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
        title: Text("Hoşgeldiniz"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: (){
              /*sharedPreferences.clear();*/
              //Navigator.push(context,MaterialPageRoute(builder: (context) => loginScreen()));
              //Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginScreen()), (Route<dynamic> route) => false);
            },
            child: Text("Çıkış yap",style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: buildBody(),
    );
  }
  
  Container buildBody() {
    /*print("shared pref üyesi = "+sharedPreferences.getString("userID").toString());*/
    return Container(
      //child: Text(sharedPreferences.getString("userID").toString()),
      child: Text("listele, job ekle cart curt"),
    );
  }
}