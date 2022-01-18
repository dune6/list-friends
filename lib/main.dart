// imports from external libraries
import 'package:flutter/material.dart';
import 'package:santa_flutter/friends_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String teamNameKey = "TEAM_NAME";

// application entry point
void main() {
  _prepareAndRun();
}

Future<void> _prepareAndRun() async {
  // убеждаемся, что flutter запустился
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final teamName = prefs.getString(teamNameKey);

  runApp(MyApp(teamName: teamName));
}

class MyApp extends StatelessWidget {
  final String? teamName;

  const MyApp({this.teamName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        FriendsPage.routeName: (BuildContext context) => const FriendsPage(),
        MyHomePage.routeName: (BuildContext context) => const MyHomePage(),
      },
      initialRoute:
          teamName == null ? MyHomePage.routeName : FriendsPage.routeName,
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = "/home";

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _goNext() async {
    Navigator.of(context).pushNamed(FriendsPage.routeName);
    // instance of shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(teamNameKey, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Santa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Введи название своей группы:',
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(controller: _controller, autofocus: true, ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goNext,
        tooltip: 'Increment',
        child: const Icon(Icons.check),
      ),
    );
  }
}
