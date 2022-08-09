import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:job_list_project/models/userLoginRequest.dart';
import '../decorations/textFieldClass.dart';
//import '../models/userLogin.dart';
//import '../models/userLoginResponse.dart';
import '../models/userLoginM.dart';

// future post method
Future<UserLoginModelM> userLogin(String name, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.24.172:8082/api/Default/UserLogin_Manager',),// 10.0.2.2   localhost  Mert : 192.168.177.172  Test_UserLogin
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': name,
      'userpassword': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
     

    print("Body'miz bu şekilde: "+response.body);
    print(UserLoginModelM.fromJson(jsonDecode(response.body)));
    return UserLoginModelM.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print("net hatası olabilir");
    throw Exception('net hatası olabilir.');
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
  Future<UserLoginModelM>? _futureUserLogin;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildUsernameField(),
            const SizedBox(height: 10.0,),
            buildPasswordField(),
            SizedBox(height: 30.0,),
            buildLoginButton(),
          ],
        ),
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
  
  //TextEditingController usernameController=new TextEditingController();
  //TextEditingController passwordController=new TextEditingController();

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
          print("Öncesi");
          print("Bu oldu => "+_futureUserLogin.toString());
          print("Sonrası");
        },
        color: Colors.teal,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text("Giriş yap",style: TextStyle(color: Colors.white),),
      ),
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
