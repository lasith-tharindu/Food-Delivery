import 'package:flutter/material.dart';
import 'package:mobile_cw2/model/user.dart';
import 'package:mobile_cw2/screen/home/home.dart';
import 'package:mobile_cw2/screen/login/login.dart';

class Wrapper extends StatefulWidget {
  static User loggedUser;//logged in staff
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
   // return (Wrapper.loggedUser==null)?Login():Home();
    return Login();
  }
}
