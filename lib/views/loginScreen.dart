import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
//import 'package:job_list_project/models/userLogin.dart';
//import 'package:job_list_project/models/userLoginRequest.dart';
import '../decorations/textFieldClass.dart';
//import '../models/userLogin.dart';
import '../models/userLoginResponse.dart';
//import '../models/userLoginM.dart';

// future post method
Future<LoginResponseModel> userLogin(String name, String password) async {
  //var jsonData;
  //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse('http://192.168.2.172:8080/api/Default/UserLogin_Manager'),// 10.0.2.2   localhost  Mert : 192.168.177.172  Test_UserLogin
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': name,
      'userpassword': password,
    }),
  );

  if (response.statusCode == 200) {
    print("Body'miz bu şekilde: "+response.body);
    //jsonData = json.decode(response.body);
    return LoginResponseModel.fromJson(jsonDecode(response.body));
    /*
    if (jsonData['UserID']==null) {
      print("HATA: !!! UserID boş geldi :( ");
    } else if(jsonData['UserID']==0){
      print("Kullanıcı adı veya şifre hatalı.");
    } else{
      sharedPreferences.setString("UserID", jsonData['UserID']);
    }
    */
    
  } else {
    print("net hatası olabilir");
    throw Exception('net hatası olabilir. ${response.body}');
  }
}


/// MAIN CLASS ///
class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

/// MAIN STATE ///
class _loginScreenState extends State<loginScreen> {
  final TextEditingController _usernameController=new TextEditingController();
  final TextEditingController _passwordController=new TextEditingController();
  Future<LoginResponseModel>? _futureUserLogin;
  String username = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Giriş Ekranı"), // uygulama üst barı
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false, // klavye açılınca oynatma
      body: buildBody(),
    );
  }
  
  buildBody() {
    return Form(
      // key verilecek
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: (_futureUserLogin == null) ? buildColumn() : buildFutureBuilder()
      ),
    );
  }

  buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildUsernameField(),
        const SizedBox(height: 10.0,),
        buildPasswordField(),
        SizedBox(height: 30.0,),
        buildLoginButton(),
      ],
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
      onSaved: (String? newValue) {
        username = newValue!;
      },
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
      onSaved: (String? newValue) {
        password=newValue!;
      },
    );
  }
  
  buildLoginButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          _futureUserLogin = userLogin(_usernameController.text,_passwordController.text);//userLogin(_usernameController.text,_passwordController.text)
        },
        color: Colors.teal,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text("Giriş yap",style: TextStyle(color: Colors.white),),
      ),
    );
  }
  
  FutureBuilder<LoginResponseModel> buildFutureBuilder() {
    return FutureBuilder<LoginResponseModel>(
      future: _futureUserLogin,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          //return Text(snapshot.data!.responseMsg);
          if (snapshot.data!.responseCode==1) {
            print("giriş sayfasına yönlendiriliyorsunuz...");
            return Text(snapshot.data!.responseMsg);
            //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
          }else{
            print("responsecode 1 değil");
            return Text("Yanlış girdiniz.");
          }
        } else if(snapshot.hasError){
          print(snapshot.error);
          return Text('${snapshot.error}');
        }  
        return const CircularProgressIndicator();
      },
    );
  }
  
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
