import 'package:flutter/material.dart';
import 'package:gastos/auth/auth.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.auth, this.onSignIn}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignIn;
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  bool _passwordVisible = false;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromRGBO(30, 217, 230, 1),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Container(
            margin: new EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                new Container(
                  child: new Text(
                    'Crie sua conta',
                    style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(82, 82, 82, 1)),
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                ),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                      labelText: 'Nome', prefixIcon: Icon(Icons.people)),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: ButtonTheme(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _register();
                        }
                      },
                      child: const Text('Começar'),
                      color: Color.fromRGBO(30, 217, 230, 1),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(_success == null
                      ? ''
                      : (_success
                          ? 'Successfully registered ' + _userEmail
                          : 'Registration failed')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code for registration.
  void _register() async {
    try {
      var userId = await widget.auth
          .createUser(_emailController.text, _passwordController.text);
      widget.onSignIn();
    } catch (e) {
      print(e);
    }
  }
}
