import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Register extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _RegisterStatePage();
}

class _RegisterStatePage  extends State<Register>
{
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  void validateData()
  {
    final form = formKey.currentState;
    form.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              autovalidate: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'email'
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'password'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  MaterialButton(
                    height: 30.0,
                    minWidth: 80.0,
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    child: Text('Create Account'),
                    onPressed: ()=> _createUser(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
Future _createUser() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: "sean91t@hmail.com", password: "123456789UHG", )
    ) as FirebaseUser;
  }
}
