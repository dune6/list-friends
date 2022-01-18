import 'package:flutter/material.dart';

// dynamic data
class FriendsPage extends StatefulWidget {

  static const routeName = "/friends";

  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.deepOrange,);
  }
}
