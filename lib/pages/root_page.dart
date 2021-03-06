import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gastos/auth/auth.dart';
import 'package:gastos/pages/private/home_logged_page.dart';
import 'package:gastos/pages/home_public_page.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth, this.app}) : super(key: key);
  final BaseAuth auth;
  final FirebaseApp app;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();

    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
  }

  void _updateAuthStatus(AuthStatus status) {
    print('Entrou no _updateAuthStatus');
    setState(() {
      authStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new HomePublicPage(
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),
        );
      default:
        return new HomePublicPage(
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
        );
    }
  }
}
