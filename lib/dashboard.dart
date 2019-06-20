import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);
  print("signed in " + user.displayName);
  return user;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("SignIn"),
      centerTitle: true,

    ),
    body: Container(
      
      child: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              onPressed: _handleSignIn,
              child: Text("SignIn"),
              color: Colors.redAccent,
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.amberAccent,
              onPressed: (){
                _googleSignIn.signOut();
                _auth.signOut();
              },
              child: Text("SignOut"),
            ),
          ],
        ),
      ),
    ),
      
    );
  }
}