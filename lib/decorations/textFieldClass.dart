import 'package:flutter/material.dart';

class textDecoration{
  
  Color colorOut = Colors.teal;
  Color colorIn = Colors.blueGrey.shade600;
  Color colorErr = Colors.red;
  BorderRadius radiusEnabled = const BorderRadius.all(Radius.circular(30));
  BorderRadius radiusfocused = const BorderRadius.all(Radius.circular(10));

  //textDecoration(this.colorOut,this.colorIn,this.labelText,this.validatorNullMsg);
 
  InputDecoration usernameFieldDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorOut),
        borderRadius: radiusEnabled,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorOut),
        borderRadius: radiusfocused,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorErr),
        borderRadius: radiusEnabled,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorErr),
        borderRadius: radiusfocused,
      ),
      labelText: "Kullanıcı Adı",
      labelStyle: TextStyle(color:  Colors.blueGrey.shade600),
      prefixIcon: Icon(
        Icons.account_circle,
        color: Colors.blueGrey.shade600,
      ),
    );
  }

  InputDecoration passwordFieldDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorOut),
        borderRadius: radiusEnabled,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorOut),
        borderRadius: radiusfocused,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorErr),
        borderRadius: radiusEnabled,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorErr),
        borderRadius: radiusfocused,
      ),
      labelText: "Şifre",
      labelStyle: TextStyle(color:  Colors.blueGrey.shade600),
      prefixIcon: Icon(
        Icons.lock,
        color: Colors.blueGrey.shade600,
      ),
    );
  }


}




/*
import 'package:flutter/material.dart';

/// MAIN CLASS ///
class textFieldDecoration extends StatelessWidget {
  //const textFieldDecoration({Key? key}) : super(key: key);
  String labelText ="";
  String validatorNullMsg = "";
  Color colorOut = Colors.teal;
  Color colorIn = Colors.blueGrey.shade600;

  textFieldDecoration(this.colorOut,this.colorIn, this.labelText, this.validatorNullMsg);

  
  buildTextFieldDecoration(Color colorOut, Color colorIn,String labelText, String validatorNullMsg) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorOut),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.teal),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      labelText: labelText,
      labelStyle: TextStyle(color:  Colors.blueGrey.shade600),
      prefixIcon: Icon(
        Icons.account_circle,
        color: Colors.blueGrey.shade600,
      ),
    );
  }
  */

  
