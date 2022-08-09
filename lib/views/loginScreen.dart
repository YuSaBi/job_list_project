import 'package:flutter/material.dart';
import '../decorations/textFieldClass.dart';

/// MAIN CLASS ///
class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

/// MAIN STATE ///
class _loginScreenState extends State<loginScreen> {
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
  
  TextEditingController usernameController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

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
          //login(usernameController.text,passwordController.text);
        },
        color: Colors.teal,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text("Giriş yap",style: TextStyle(color: Colors.white),),
      ),
    );
  }

}
