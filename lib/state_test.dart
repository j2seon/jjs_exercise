import 'package:flutter/material.dart';

class StateTestPage extends StatefulWidget {
  const StateTestPage({Key? key}) : super(key: key);

  @override
  State<StateTestPage> createState() => _StateTestPageState();
}

class _StateTestPageState extends State<StateTestPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Count(
        count: count,
      ),
      floatingActionButton: ActionBtn1(
          count: count,
          onPressed: () {
            //   setState(() {
            //     this.count += 1;
            //   });
          }),
    );
  }
}

class Count extends StatelessWidget {
  final int count;

  const Count({required this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      count.toString(),
      style: TextStyle(fontSize: 30.0),
    ));
  }
}

class ActionBtn1 extends StatefulWidget {
  final int count;
  final void Function()? onPressed;

  // final void Function()? onPressed;
  const ActionBtn1({this.onPressed, required this.count, Key? key})
      : super(key: key);

  // const ActionBtn1({required this.count, Key? key}) : super(key: key);

  @override
  State<ActionBtn1> createState() => _ActionBtn1State();
}

class _ActionBtn1State extends State<ActionBtn1> {
  int? count;

  @override
  void initState() {
    count = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          this.count = this.count! + 1;
        });
      },
      child: Text(count?.toString()?? widget.count.toString()),
    );
  }
}
