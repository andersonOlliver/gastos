import 'package:flutter/material.dart';
import 'package:gastos/auth/auth.dart';
import 'package:gastos/login_page.dart';
import 'package:gastos/register_page.dart';
import 'package:gastos/signin/signin_google.dart';

class HomePublicPage extends StatefulWidget {
  HomePublicPage({Key key, this.title, this.auth, this.onSignIn})
      : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePublicPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: new Container(
              child: new Text(
                'Crie sua conta grátis',
                style: new TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(82, 82, 82, 1)),
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.only(top: 100.0, left: 60.0, right: 60.0),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: new Container(
              child: new Text(
                'Junte-se a mais de meio milhão de pessoas e comece já',
                style: new TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(153, 153, 153, 1)),
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.only(
                  top: 30.0, left: 50.0, right: 50.0, bottom: 30.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 40.0, right: 40.0, bottom: 10.0, top: 10.0),
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: ButtonTheme(
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  _pushPage(
                      context,
                      RegisterPage(
                        auth: widget.auth,
                        onSignIn: widget.onSignIn,
                      ));
                },
                child: new Text(
                  'Cadastre-se',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Color.fromRGBO(30, 217, 230, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.only(
                left: 40.0, right: 40.0, bottom: 10.0, top: 10.0),
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: GoogleSignInSection(
              height: 50.0,
              onPressed: () {
                _signInWithGoogle();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 40.0, right: 40.0, bottom: 10.0, top: 10.0),
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: ButtonTheme(
              height: 50,
              child: FlatButton(
                onPressed: () {
                  _pushPage(context, LoginPage());
                },
                child: Text(
                  'Já tenho conta',
                  style: new TextStyle(color: Colors.black38),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _signInWithGoogle() async {
    try {
      await widget.auth.signInWithGoogle();
      widget.onSignIn();
    } catch (e) {
      print(e);
    }
  }
}
