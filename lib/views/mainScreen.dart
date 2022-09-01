//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_list_project/views/jobAddView.dart';
import 'package:job_list_project/views/loginScreen.dart';
import 'package:job_list_project/views/mailView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/jobListview.dart';

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
  bool _isLoading = false;
  late SharedPreferences sharedPreferences;
  String userName="";
  //late SharedPreferences sharedPreferences;
  //String userName;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getSharedPreferences();
    
    /*checkLoginStatus();*/
  }

  void getSharedPreferences() async{
    while (true){
      if (userName.isEmpty || userName==""){
        print("bi kere döndü");
        sharedPreferences = await SharedPreferences.getInstance();
        userName = sharedPreferences.getString("userName").toString();
      }
      else{
        break;
      }// else sonu
    }// while sonu
    setState(() {
          _isLoading = false;
        });
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
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) => popUpOnSelected(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text("Mail"),
              ),
              PopupMenuDivider(),
              const PopupMenuItem(
                value: 1,
                child: Text("Çıkış"),
              )
            ]
          )
          /*TextButton(
            onPressed: (){
              sharedPreferences.setBool('isLogged', false);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginScreen()), (Route<dynamic> route) => false);
            },
            child: Text("Çıkış yap",style: TextStyle(color: Colors.white),),
          )*/
        ],
      ),
      body: Form(child: buildBody())
    );
  }

  void popUpOnSelected(BuildContext context, int item){
    switch (item){
      case 1:
        sharedPreferences.setBool('isLogged', false);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginScreen()), (Route<dynamic> route) => false);
        break;
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => mailView(),));
        break;
    }
  }
  
  buildBody() {
    /*print("shared pref üyesi = "+sharedPreferences.getString("userID").toString());*/
    return _isLoading
    ? Center(
      child:  CircularProgressIndicator(
        backgroundColor:  Colors.grey.shade300,
      ),
    )
    : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // üst tarafa bişeyler eklersek.
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("kullanıcı : $userName"),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => jobAdd(),));
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
        //return null;
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginScreen()), (Route<dynamic> route) => false);
        Navigator.push(context, MaterialPageRoute(builder: (context) => jobListView(),));
      },
    ),
  );
  
  

}
