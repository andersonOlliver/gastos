import 'package:flutter/material.dart';

class GoogleSignInSection extends StatelessWidget {
  GoogleSignInSection({Key key, this.height, this.onPressed}) : super(key: key);

  final VoidCallback onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: height ?? 40.0,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        // Google doesn't specify a border radius, but this looks about right.
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: RaisedButton(
        onPressed: this.onPressed,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: height ?? 38.0,
                width: height ?? 38.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Center(
                  child: Image(
                    image: AssetImage('graphics/google_logo.png',
                        package: 'gastos'),
                    height: 24.0,
                    width: 24.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 14.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
              child: Text(
                'Entre com o Google',
                style: TextStyle(
                    fontSize: 16.0,
                    // fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.54)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
