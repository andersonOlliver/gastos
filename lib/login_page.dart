import 'package:flutter/material.dart';
import 'package:gastos/auth/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _authHint = '';

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        var userId = await widget.auth.signIn(_email, _password);
        setState(() {
          _authHint = 'Signed In\n\nUser id: $userId';
        });
        widget.onSignIn();
      } catch (e) {
        setState(() {
          _authHint = 'Sign In Error\n\n${e.toString()}';
        });
        print(e);
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }

  Widget hintText() {
    return new Container(
        //height: 80.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(_authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 217, 230, 1),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: _formKey,
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                new Container(
                  child: new Text(
                    'Acesse sua conta',
                    style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                ),
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  // Use email input type for emails.
                  decoration: new InputDecoration(
                      hintText: 'seuemail@email.com',
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email)),
                ),
                new TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Entre com sua senha',
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock))),
                Container(
//                  padding: EdgeInsets.only(
//                      left: 40.0, right: 40.0, bottom: 10.0, top: 10.0),
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: ButtonTheme(
                    height: 50,
                    child: RaisedButton(
                      onPressed: validateAndSubmit,
                      child: Text('ENTRAR'),
                      color: Color.fromRGBO(30, 217, 230, 1),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                hintText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
