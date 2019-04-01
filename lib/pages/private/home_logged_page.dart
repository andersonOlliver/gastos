import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gastos/auth/auth.dart';
import 'package:gastos/fragments/botao_adicionar.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});

  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(30, 217, 230, 1),
        title: Text('Gastos'),
        actions: <Widget>[
          new FlatButton(
            onPressed: _signOut,
            child: new Text(
              'Logout',
              style: new TextStyle(fontSize: 17.0, color: Colors.white),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: const EdgeInsetsDirectional.only(top: 0.0, start: 0.0),
              child: UserAccountsDrawerHeader(
                accountName: FutureBuilder(
                    future: auth.currentUser(),
                    builder: (context, AsyncSnapshot<FirebaseUser> snapshot) =>
                        snapshot.hasData
                            ? Text(snapshot.data.displayName)
                            : Text('Usuario')),
                accountEmail: FutureBuilder(
                    future: auth.currentUser(),
                    builder: (context, AsyncSnapshot<FirebaseUser> snapshot) =>
                        snapshot.hasData
                            ? Text(snapshot.data.email)
                            : Text('email@email.com')),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: FutureBuilder(
                      future: auth.currentUser(),
                      builder:
                          (context, AsyncSnapshot<FirebaseUser> snapshot) =>
                              snapshot.hasData
                                  ? snapshot.data.photoUrl.isNotEmpty
                                      ? Image.network(snapshot.data.photoUrl)
                                      : Text(
                                          snapshot.data.displayName
                                              .split(' ')
                                              .map((n) => n[0])
                                              .join()
                                              .toUpperCase(),
                                          style: TextStyle(fontSize: 40.0))
                                  : Text(
                                      'U',
                                      style: TextStyle(fontSize: 40.0),
                                    ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 217, 230, 1),
                ),
              ),
            ),
            ListTile(
              title: Text('Lançamentos'),
              leading: Icon(Icons.swap_vertical_circle),
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () {
                _signOut();
              },
              leading: Icon(Icons.exit_to_app),
            )
          ],
        ),
      ),
      body: new Center(
        child: new Text(
          'Hello World!',
          style: new TextStyle(fontSize: 32.0),
        ),
      ),
      floatingActionButton: BotaoAdicionar(
        icon: Icons.add,
        tooltip: 'Adicionar',
        onPressed: () {},
      ),
    );
  }
}
