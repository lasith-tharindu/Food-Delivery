import 'package:flutter/material.dart';
import 'package:mobile_cw2/screen/wrapper.dart';
import 'package:mobile_cw2/model/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAdmin = Wrapper.loggedUser.role == "admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Hello " + Wrapper.loggedUser.name + "!",
              style: TextStyle(fontSize: 40),
            ),
            Text(
              Wrapper.loggedUser.role,
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 20),

            (isAdmin)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text(
                          'Manager Projects',
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.blueGrey[200],
                        onPressed: () {
                          print(
                              'send to Manager project screen password screen');
                        },
                      ),
                    ),
                  )
                : Container(),

            //show project
            //for admin all projects. including: active
            //for employees assigned project. including: hold and active
            (isAdmin)
                ? Card(
                    color: Colors.blueGrey[400],
                    child: ExpansionTile(
                      title: Text('All active Projects'),
                      initiallyExpanded: true,
                      children: <Widget>[
                        //sanuda - display all  projects
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.blueGrey[800],
                            child: ListTile(
                              title: Text('Abanse',style: TextStyle(color: Colors.white,fontSize: 20),),
                              subtitle: Text('software for them',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.4,horizontal: 8.0),
                          child: Container(
                            color: Colors.blueGrey[800],
                            child: ListTile(
                              title: Text('Softlogic ',style: TextStyle(color: Colors.white,fontSize: 20),),
                              subtitle: Text('software for them',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.blueGrey[800],
                            child: ListTile(
                              title: Text('Esoft',style: TextStyle(color: Colors.white,fontSize: 20),),
                              subtitle: Text('software for them',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Card(
                    color: Colors.blueGrey[400],
                    child: ExpansionTile(
                      title: Text('Your projects'),
                      initiallyExpanded: true,
                      children: <Widget>[
                        //Lasith
                        Text('Big Bang'),
                        Text('Birth of the Sun'),
                        Text('Earth is Born'),
                      ],
                    ),
                  ),

            //Sanuda show all projects on hold for admin only
            (isAdmin)
                ? Card(
                    color: Colors.blueGrey[400],
                    child: ExpansionTile(
                      title: Text('Projects on hold'),
                      children: <Widget>[
                        //sanuda - display all  projeccts
                        Text('Big Bang'),
                        Text('Birth of the Sun'),
                        Text('Earth is Born'),
                      ],
                    ),
                  )
                : Container(),

            //Sanuda show stopped projects for admin only
            (isAdmin)
                ? Card(
                    color: Colors.blueGrey[400],
                    child: ExpansionTile(
                      title: Text('All closed Projects'),
                      children: <Widget>[
                        //sanuda - display all  projeccts
                        Text('Big Bang'),
                        Text('Birth of the Sun'),
                        Text('Earth is Born'),
                      ],
                    ),
                  )
                : Container(),
            (isAdmin)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text(
                          'Manager Users',
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.blueGrey[200],
                        onPressed: () {
                          print('send to Manage staff password screen');
                        },
                      ),
                    ),
                  )
                : Container(),

            //all users
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'Change password',
                    style: TextStyle(fontSize: 20),
                  ),
                  color: Colors.blueGrey[200],
                  onPressed: () {
                    print('send to change password screen');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
