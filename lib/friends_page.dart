import 'dart:math';

import 'package:flutter/material.dart';
import 'package:santa_flutter/friend.dart';
import 'package:santa_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// dynamic data
class FriendsPage extends StatefulWidget {
  static const routeName = "/friends";

  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  String? _teamName;
  final List _friends = [];
  static const List _names = [
    "Alex",
    "Dan",
    "Roman",
    "Kate",
    "Ilya",
    "Elizabeth"
  ];
  final ScrollController _controller = ScrollController();


  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final teamName = prefs.getString(teamNameKey);
    setState(() {
      _teamName = teamName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_teamName ?? ""),
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: _friends.length,
          padding: const EdgeInsets.all(15),
          controller: _controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Increment',
        child: const Icon(Icons.plus_one),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 100,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(
                color: _friends[index].color, shape: BoxShape.circle),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            _friends[index].name,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: 10);
  }

  Future<void> _add() async {
    final friend = Friend(
        _friends.length,
        _names[Random().nextInt(6)],
        Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
            Random().nextInt(256)));
    setState(() {
      _friends.add(friend);
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
  }
}
