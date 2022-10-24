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
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: const [
                    Icon(Icons.email_outlined,color: Colors.black,),
                    SizedBox(width: 8,),
                    Text("Mail"),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.logout,color: Colors.black,),
                    SizedBox(width: 8,),
                    Text("Çıkış"),
                  ],
                ),
              )
            ]
          )
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
          // Logo Eklenecek
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => jobListView(),));
      },
    ),
  );
  
  

}
