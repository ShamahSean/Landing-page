import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/ui/register.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class Home extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<Home>
  {

  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  void validateData()
  {
    final form = formKey.currentState;
    form.save();
    if (form.validate())
      {
        print("valid credentials: $_email,$_password");
      }else
        {
          print("invalid credentials:$_email,$_password");
        }
  }

  @override
  Widget build(BuildContext context)
  {
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
                      labelText: "Email/ Phone Number",
                        hintStyle: TextStyle(fontSize: 20.0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value.isEmpty?'email needed' : null,
                    onSaved: (value) => _email = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) => value.isEmpty?'password can\'t be empty' : null,
                    onSaved: (value) => _password = value,

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              50.0, 0.0, 0.0, 0.0),
                        ),
                        MaterialButton(
                          height: 30.0,
                          minWidth: 80.0,
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          child: Text("Register"),
                          onPressed:(){Navigator.push(context, MaterialPageRoute
                            (builder: (context) => Register()));},
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              50.0, 0.0, 30.0, 0.0),
                        ),
                        MaterialButton(
                          height: 30.0,
                          minWidth: 80.0,
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          child: Text("Login"),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text("Or Login with"),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SignInButton(
                            Buttons.Facebook,
                            mini: true,
                            onPressed: (){},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SignInButton(
                            Buttons.Twitter,
                            mini: true,
                            onPressed: (){},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SignInButton(
                            Buttons.Google,
                            mini: true,
                            onPressed: () => _gSignIn(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Center(
                          child: Container(
                            child: MaterialButton(
                              child: Text("LogOut"),
                              color: Colors.red,
                              onPressed: () => _logOut(),
                            ),
                          ),
                    ),
                  )
                ],
              ),
            ),
          )
        ], //Children Widget
      ), //Stack
    ); //Scaffold
  }
  Future<FirebaseUser> _gSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  _logOut() {
    setState(() {
      _googleSignIn.signOut();
      _auth.signOut();
    });
  }

  /*Future _createUser() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: "sean91t@hmail.com", password: "trail12345")
    .then((NewUser){
      print("User Created: ${NewUser.displayName}");
      print("email: ${NewUser.email}");
    });
  }*/
    }