import 'package:flutter/material.dart';
import 'package:jjs_exercise/state_test.dart';
import 'package:provider/provider.dart';
import 'count_provider.dart';

class StateTestPage2 extends StatelessWidget {
  const StateTestPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountState state = context.read<CountState>();
    return Scaffold(
      appBar: AppBar(),
      // body: Count(count: state.count),
      floatingActionButton:
          // CountStatePage1()
          // ActionBtn3(
          //   count: state.count,
          //   onPressed: state.add,
          // ),
          CountStateBuilder(
            provider: (BuildContext context)=>context.watch<CountState>(),
            builder: (BuildContext context, CountState state)=> ActionBtn3(count: state.count,onPressed: state.add),
        
      ),
    );
  }
}

class ActionBtn3 extends StatelessWidget {
  final int count;
  final void Function()? onPressed;

  const ActionBtn3({required this.count, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //문제점 state랑 ui가 같이 있어버리게된다. -->>? 분리하자
    // CountState state = context.watch<CountState>();
    return FloatingActionButton(
      onPressed: onPressed,
      child: Text(count.toString()),
    );
  }
}

class CountStatePage1 extends StatelessWidget {
  const CountStatePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountState state = context.watch<CountState>();
    return ActionBtn3(
      count: state.count,
      onPressed: state.add,
    );
  }
}

class CountStateBuilder<T> extends StatelessWidget {
  //context watch를 사용하고
  //watch온 값을 이용하는 위젯을 리턴하고싶다.
  final T Function(BuildContext context) provider;
  final Widget Function(BuildContext context, T state) builder;

  const CountStateBuilder(
      {required this.builder, required this.provider, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final T state = provider(context);
    return builder(context, state);
  }
}


