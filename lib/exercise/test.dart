import 'package:flutter/material.dart';

class MyController {
  // int count = 0;

  void Function()? update;
  void Function(void Function())? dd;

  // void update(int count) {
  //   this.count = count;
  //   print('update : ${this.count}');
  // }
}

class MainPage extends StatelessWidget {

  final MyController controller = MyController();

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(title: Text(controller.count.toString()),centerTitle: true,),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Widget1(controller: this.controller),
              Widget2(controller: this.controller),
            ],
          ),
        ),
      );
}

class Widget1 extends StatelessWidget {
  final MyController controller;
  Widget1({required this.controller, Key? key}) : super(key: key);

  int count = 0;


  @override
  Widget build(BuildContext context) {
    print('widget1');
    return IconButton(
      iconSize: 50.0,
      onPressed: (){
        if(this.controller.update==null)return;
        this.controller.update!();
        this.controller.dd!((){});
      },
      icon: Icon(
        Icons.person,
      ),
    );
  }
}

class Widget2 extends StatefulWidget {
  final MyController controller;

  const Widget2({required this.controller, Key? key}) : super(key: key);

  @override
  State<Widget2> createState() => _Widget2State();
}

class _Widget2State extends State<Widget2> {


  int v = 0;
  void update(){
    this.setState(() {
      this.v+=1;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('w2 build');
    this.widget.controller.dd = this.setState;
    return Text(this.v.toString(),
      style: TextStyle(fontSize: 30.0),
    );
  }
}
