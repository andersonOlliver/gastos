import 'package:flutter/material.dart';
import 'package:gastos/auth/auth.dart';

class GoogleSignInSection extends StatefulWidget {
  GoogleSignInSection({Key key, this.auth, this.onSignIn}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<GoogleSignInSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 40.0, right: 40.0),
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: ButtonTheme(
            height: 50,
            child: RaisedButton(
              onPressed: () async {
                _signInWithGoogle();
              },
              child: new Text(
                'Entre com Google',
                style: TextStyle(color: Colors.black38),
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
            ),
          ),
        ),
      ],
    );
  }

  void _signInWithGoogle() async {
    try {
      await widget.auth.signInWithGoogle();
      Navigator.of(context).pop();
      widget.onSignIn();
    } catch (e) {
      print(e);
    }
  }
}
