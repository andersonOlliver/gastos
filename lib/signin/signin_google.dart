import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class GoogleSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<GoogleSignInSection> {
  bool _success;
  String _userID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: const Text('Test sign in with Google'),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
              _signInWithGoogle();
            },
            child: const Text('Sign in with Google'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _success == null
                ? ''
                : (_success
                    ? 'Successfully signed in, uid: ' + _userID
                    : 'Sign in failed'),
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      setState(() {
        if (user != null) {
          _success = true;
          _userID = user.uid;
        } else {
          _success = false;
        }
      });
    } catch (error) {
      print("google sign in error: $error");
      return;
    }
  }
}