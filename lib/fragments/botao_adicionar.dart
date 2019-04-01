import 'package:flutter/material.dart';

class BotaoAdicionar extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  const BotaoAdicionar({Key key, this.onPressed, this.tooltip, this.icon})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BotaoAdicionarState();
}

class _BotaoAdicionarState extends State<BotaoAdicionar>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.red,
      end: Colors.redAccent,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

//
//  Widget add() {
//    return new Container(
//      child: FloatingActionButton(
//        onPressed: null,
//        backgroundColor: Colors.black26,
//        tooltip: 'Add',
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//
//  Widget image() {
//    return new Container(
//      child: FloatingActionButton(
//        onPressed: null,
//        tooltip: 'Image',
//        backgroundColor: Colors.teal,
//        child: Icon(Icons.add),
//      ),
//    );
//  }

  Widget add() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            child: new Chip(
              backgroundColor: Colors.transparent,
              label: Text(
                'Ops',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.black26,
              tooltip: 'Add',
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }

  Widget image() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            child: new Chip(
              backgroundColor: Colors.transparent,
              label: Text(
                'Receita',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: FloatingActionButton(
              onPressed: null,
              tooltip: 'Image',
              backgroundColor: Colors.teal,
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }

  Widget inbox() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            child: new Chip(
              backgroundColor: Colors.transparent,
              label: Text(
                'Despesa',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.redAccent,
              tooltip: 'Inbox',
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }

  Widget toggle() {
    return Container(
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
          backgroundColor: _buttonColor.value,
          onPressed: animate,
          tooltip: 'Toggle',
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animateIcon,
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value * 3.0, 0.0),
          child: new Opacity(
            opacity: new Tween<double>(begin: 0.0, end: 1.0)
                .animate(
                  new CurvedAnimation(
                    parent: _animationController,
                    curve: new Interval(
                      0.100,
                      0.600,
                      curve: Curves.ease,
                    ),
                  ),
                )
                .value,
            child: add(),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: new Opacity(
            opacity: new Tween<double>(begin: 0.0, end: 1.0)
                .animate(
                  new CurvedAnimation(
                    parent: _animationController,
                    curve: new Interval(
                      0.100,
                      0.600,
                      curve: Curves.ease,
                    ),
                  ),
                )
                .value,
            child: image(),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: new Opacity(
            opacity: new Tween<double>(begin: 0.0, end: 1.0)
                .animate(
                  new CurvedAnimation(
                    parent: _animationController,
                    curve: new Interval(
                      0.100,
                      0.600,
                      curve: Curves.ease,
                    ),
                  ),
                )
                .value,
            child: inbox(),
          ),
        ),
        toggle()
      ],
    );
  }
}
