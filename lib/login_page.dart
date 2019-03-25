import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
                  ),
                ),
                new TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Entre com sua senha', labelText: 'Senha')),
                SizedBox(height: 20.0),
                Container(
//                  padding: EdgeInsets.only(
//                      left: 40.0, right: 40.0, bottom: 10.0, top: 10.0),
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: ButtonTheme(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('ENTRAR'),
                      color: Color.fromRGBO(30, 217, 230, 1),
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
