import 'dart:convert';
//import 'dart:js';
import 'package:http/http.dart' as http;
import 'package:job_list_project/views/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
//import 'package:job_list_project/models/userLogin.dart';
//import 'package:job_list_project/models/userLoginRequest.dart';
import '../decorations/textFieldClass.dart';
//import '../models/userLogin.dart';
import '../models/userLoginResponse.dart';
//import '../models/userLoginM.dart';




/// MAIN CLASS ///
class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);
  //bool isLogged=false;
  //loginScreen.withLogged(this.isLogged);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

/// MAIN STATE ///
class _loginScreenState extends State<loginScreen> {
  //bool _isLogged;
  final TextEditingController _usernameController=new TextEditingController();
  final TextEditingController _passwordController=new TextEditingController();
  Future<LoginResponseModel>? _futureUserLogin;
  late SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  //bool? sharedisLogged;

  //_loginScreenState (this._isLogged);
  _loginScreenState ();

  @override
  void initState() /*async*/{
    /*
    sharedPreferences = await SharedPreferences.getInstance();
    sharedisLogged = sharedPreferences.getBool('isLogged');
    if (sharedisLogged!=null) {
      
    }
    if (_isLogged) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool('isLogged', true);
      checkLogin();
    }
    */
    checkLogin();
    super.initState();
  }

   void checkLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    //sharedisLogged = sharedPreferences.getBool("isLogged");
    if (sharedPreferences.getBool("isLogged")==null||sharedPreferences.getBool("isLogged")==false) {
      
    }
    else if (sharedPreferences.getString("userID").toString().isNotEmpty && sharedPreferences.getString("userID").toString()!="0") {// .toString() isteye bilir!!!!
      //Navigator.push(context,MaterialPageRoute(builder: (context) => loginScreen()));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainScreen()), (Route<dynamic> route) => false);
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Giriş Ekranı"), // uygulama üst barı
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false, // klavye açılınca oynatma
      body: Form(child: buildBody()),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
      child: _isLoading ? Center(child: CircularProgressIndicator(),) : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildUsernameField(),
          const SizedBox(height: 10.0,),
          buildPasswordField(),
          SizedBox(height: 30.0,),
          buildLoginButton(),
        ],
      ),
    );
  }

  buildUsernameField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _usernameController,
      decoration: textDecoration().usernameFieldDecoration(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Kullanıcı adı boş bırakılamaz.";
        } else {
          return null;
        }
      },
      /*
      onSaved: (String? newValue) {
        username = newValue!;
      },
      */
    );
  }
  
  buildPasswordField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      controller: _passwordController,
      decoration: textDecoration().passwordFieldDecoration(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Şifre boş bırakılamaz.";
        } else {
          return null;
        }
      },
      /*
      onSaved: (String? newValue) {
        password=newValue!;
      },
      */
    );
  }
  
  buildLoginButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          //_futureUserLogin = userLogin(_usernameController.text,_passwordController.text);//userLogin(_usernameController.text,_passwordController.text)
          userLogin(_usernameController.text,_passwordController.text);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
        child: Text("Giriş yap",style: TextStyle(color: Colors.white),),
        /*color: Colors.teal,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),*/
      ),
    );
  }
  
  // future post method
  //Future<LoginResponseModel> userLogin(String name, String password) async {
  userLogin(String name, String password) async {
    var jsonData;
    //sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/Default/UserLogin_Manager'),// 10.0.2.2   localhost  Mert : 192.168.177.172  Test_UserLogin
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': name,
        'userpassword': password,
      }),
    );

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      
      if (jsonData['responseCode']==null) {
        print("HATA: !!! responseCode boş geldi :( beklenmeyen hata :() ");
        sharedPreferences.setString("responseMsg", "HATA: !!! responseCode boş geldi :( ");
      } else if(jsonData['responseCode']==0) {
        print("Kullanıcı adı veya şifre hatalı.");
        sharedPreferences.setString("responseMsg", "Kullanıcı adı veya şifre hatalı.");
      } else if(jsonData['responseCode']==1) {
        setState(() {
        _isLoading=false;
        sharedPreferences.setString("responseMsg", "Giriş başarılı");
        sharedPreferences.setString("userID", jsonData['userID'].toString());
        sharedPreferences.setString("userName", name.toString());
        sharedPreferences.setBool('isLogged', true);
        sharedPreferences.commit();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainScreen()), (Route<dynamic> route) => false);
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
      //return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {// responseCode!=200
      print("net hatası olabilir, bağlantı hatası");
      setState(() {
        _isLoading=false;
      });
    }
  }

  //FutureBuilder<LoginResponseModel> buildFutureBuilder() {
    FutureBuilder buildFutureBuilder() {// buraya hiç girmiyoruz artık
    return FutureBuilder(
      future: _futureUserLogin,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          //return Text(snapshot.data!.responseMsg);
          if (snapshot.data!.responseCode==1) {
            print("giriş sayfasına yönlendiriliyorsunuz...");
            //return Text(snapshot.data!.responseMsg);
            //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false); /// BURADAN YENİ SAYFAYA GİDİLECEK
            // ÇALIŞAN Navigator.push(context,MaterialPageRoute(builder: (context) => MainScreen()));
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainScreen()), (Route<dynamic> route) => false);
            //GİDERKEN YANINDA LOGİNRESPONSE CLASSINDAN ÖRNEK GOTURECEK SNAPSHOT DATA İLE
            //return buildMainScreen();
          }else{
            print("responsecode 1 değil");
            return Text("Yanlış girdiniz.");
          }
        } else if(snapshot.hasError){
          print(snapshot.error);
          return Text('${snapshot.error}');
        }  
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
  
  buildMainScreen() {
    return Stack(
        //key: _formKey,
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 140, 167, 181),//Color(0xFF84FDD9),//Color(0xFF73AEF5),
                  Color.fromARGB(255, 108, 142, 159),//Color(0xFF60E6BE),//  Color(0xFF61A4F1),
                  Color.fromARGB(255, 107, 141, 155),//Color(0xFF72F5CE),// Color(0xFF478DE0),
                  Color.fromARGB(255, 45, 92, 114),//Color(0xFF1AB7AC),// Color(0xFF398AE5),
                ],
                stops: [
                  0.1,
                  0.4,
                  0.7,
                  0.9
                ]),
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 300.0,
            ),
            //key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                //_loginButton()
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                _IsGirisBtn(),
                const SizedBox(
                  height: 30.0,
                ),
                _IsListeleBtn(),
              ],
            ),
          ),
        )
      ],
    );
  }
  
  //ButtonTheme 

  Widget _IsGirisBtn() => ButtonTheme(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        onSurface: Colors.amber,
        minimumSize: Size(100.0, 40.0)
      ),
      child: Text("İş ekleme"),
      onPressed: () {
        return null;
      },
    ),
  );
      
  Widget _IsListeleBtn() => ButtonTheme(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        onSurface: Colors.amber,
        minimumSize: Size(100.0, 40.0)
      ),
      child: Text("İşleri listele"),
      onPressed: () {
        return null;
      },
    ),
  );
  
 
  
  /*
  Future<UserLoginResponseModel> login(String username, String userpassword) async{
    final response = await http.post(
    Uri.parse('https://localhost:8082/api/Default/userLogin_Manager'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'userpassword': userpassword,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return UserLoginResponseModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
  }
  */

}
