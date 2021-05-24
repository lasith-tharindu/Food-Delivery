import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cw2/controller/login_ctr.dart';
import 'package:mobile_cw2/data/database_helper.dart';
import 'package:mobile_cw2/model/user.dart';
import 'package:mobile_cw2/screen/home/home.dart';
import 'package:mobile_cw2/screen/wrapper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Horizon (pvt) Ltd ',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times New Roman'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                  onChanged: (value) => username = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  onChanged: (value) => password = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Times New Roman'),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      User user = await LoginCtr().getLogin(username, password);
                      Wrapper.loggedUser=user;
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      } else {
                        //User firstUser = new User('Sanuda','admin','admin','123');
                        //print(await LoginCtr().saveUser(firstUser));
                        Flushbar(
                          flushbarPosition: FlushbarPosition.TOP,
                          title: 'Access Denied',
                          message: 'Wrong Username or Password',
                          duration: Duration(seconds: 3),
                        )..show(context);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
