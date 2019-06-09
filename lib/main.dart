import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hero Bug',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Hero Bug - StartPage"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                  tag: "image",
                  child: Image.network("https://i.ibb.co/F6dxwfC/dummy.jpg")),
              RaisedButton(
                  child: Text("Navigate with error",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => DestinationWithErrorPage()));
                  }),
              RaisedButton(
                  child: Text("Navigate without error",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => DestinationWithoutErrorPage()));
                  })
            ],
          ),
        ));
  }
}

class DestinationWithErrorPage extends StatefulWidget {
  DestinationWithErrorPage({Key key}) : super(key: key);
  @override
  _DestinationWithErrorPageState createState() =>
      _DestinationWithErrorPageState();
}

class _DestinationWithErrorPageState extends State<DestinationWithErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("With Error"),
      ),
      body: SafeArea(
          child: Center(
        child: Hero(
            tag: "image",
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network("https://i.ibb.co/F6dxwfC/dummy.jpg"),
                Container(color: Colors.black54),
                Center(
                    child: IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.error),
                  color: Colors.white,
                  tooltip: 'Anterior',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
              ],
            )),
      )),
    );
  }
}

class DestinationWithoutErrorPage extends StatefulWidget {
  DestinationWithoutErrorPage({Key key}) : super(key: key);
  @override
  _DestinationWithoutErrorState createState() =>
      _DestinationWithoutErrorState();
}

class _DestinationWithoutErrorState extends State<DestinationWithoutErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Without Error"),
      ),
      body: SafeArea(
          child: Center(
        child: Hero(
            tag: "image",
            flightShuttleBuilder: (BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext) =>
                Material(child: toHeroContext.widget),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network("https://i.ibb.co/F6dxwfC/dummy.jpg"),
                Container(color: Colors.black54),
                Center(
                    child: IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.error),
                  color: Colors.white,
                  tooltip: 'Anterior',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
              ],
            )),
      )),
    );
  }
}
