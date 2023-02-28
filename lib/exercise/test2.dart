import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  MyController controller = MyController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetBtn(
              set: controller.set,
            ),
            WidgetText(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}

class MyController {
  int count = 0;
  void Function()? update;
  void Function(void Function())? update2;

  void set(){
    update2!((){
      this.count+=1;
    });
  }

}

//버튼
class WidgetBtn extends StatelessWidget {
  // final MyController controller;
  void Function()? set;
  WidgetBtn({this.set, Key? key}) : super(key: key);

  int v =0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50.0,
      onPressed: () {
        // if(this.controller.update == null) return;
        // this.controller.update!();
        set!();
      },
      icon: Icon(Icons.person),
    );
  }
}

//변해야하는 값은 text
class WidgetText extends StatefulWidget {
  final MyController controller;

  const WidgetText({required this.controller, Key? key}) : super(key: key);

  @override
  State<WidgetText> createState() => _WidgetTextState();
}

class _WidgetTextState extends State<WidgetText> {
  // int v = 0;

  // void update() {
  //   this.setState(() {
  //     this.v += 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('w2 build');
    widget.controller.update2 = this.setState;
    // widget.controller.update = this.update;
    return Text(
      widget.controller.count.toString(),
      style: TextStyle(fontSize: 30.0),
    );
  }
}
