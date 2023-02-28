import 'package:flutter/material.dart';
import 'package:jjs_exercise/todo/model/todo_model.dart';
import 'package:jjs_exercise/todo/provider/todo_provider.dart';
import 'package:provider/provider.dart';

//왜 ful? -> ListTile 자체가 변해야되는 ui가 된다 따라서 ful이됨.
class TodoListPage extends StatefulWidget {
  static const path = '/todo';

  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  TodoProvider? _provider;
  bool isDrag = false;
  List<double>? dragPos;

  @override
  void didChangeDependencies() {
    _provider = context.watch<TodoProvider>(); //ful 위젯에서는 이렇게 해줘야한다.
    dragPos = List<double>.generate(_provider!.todoList.length, (index) => 0);
    if (!mounted) return;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) return Scaffold();
    final Map<String, TodoModel> _todo = _provider!.todoList;
    final List<TodoModel> _todos = _todo.values.toList();
    // dragPos = List<double>.generate(_todo.length, (index) => 0);
    return TodoListView(
      itemCount: _todo.length,
      itemBuilder: (context, index) {
        return Transform.translate(
          offset: Offset(dragPos![index], 0),
          child: GestureDetector(
            onPanStart: (DragStartDetails start) {
              // print('start');
              this.isDrag =
                  true; // drag가 시작되니까 바꿔줘야한다. ui가 변경되는 것이 아니기때문에 setState 안해도 됌.
            },
            onPanUpdate: (DragUpdateDetails update) async {
              if (!this.isDrag) return;
              // print(update);
              setState(() {
                dragPos![index] += update.delta.dx;
                // print(dragPos![index]);
              });

              if (dragPos![index] > 200) {
                //dialog로 삭제 여부 물어보기
                bool? check = await showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('${_todo.values.toList()[index].id}'),
                      content: Text('삭제하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop<bool>(true);
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop<bool>(false);
                          },
                          child: Text('NO'),
                        ),
                      ],
                    );
                  },
                );
                // print(check); // await 했다가 받으니까 무조건 값이 있으니 ! 표시
                if (check!) _provider!.remove(id: _todo.keys.toList()[index]);
              }
            },
            onPanEnd: (DragEndDetails end) {
              // print('end');
              this.isDrag = false;
              setState(() {
                this.dragPos![index] = 0;
              });
            },
            child: ListTile(
              onTap: () {
                _provider!.select(index);
                Navigator.pushNamed(context, '/todo/update');
              },
              title: Text('${_todo.values.toList()[index].content}'),
              // trailing: this.isDrag ? Icon(Icons.remove) : null,
            ),
          ),
        );
      },
      //위로 올려서 text에 대한 validation과 저장 등을 수행할수있다.
      addTab: (String text) {
        if (text.isEmpty) return '공백x';
        //추가적인 조건을 줄수도 있다.
        if (text.length < 3) {
          return '3글자 이상 입력해주세요';
        }
        // if (text.isEmpty) return false;
        _provider!.add(content: text);
        return null;
        // return true;
      },
    );
  }
}

class TodoListView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final String? Function(String) addTab;

  const TodoListView(
      {required this.itemCount,
      required this.itemBuilder,
      required this.addTab,
      Key? key})
      : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String? result;

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onTap: (){ // 눌렀을 때
                          result = null;
                          setState(() {});
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // if (!this.widget.addTab(controller.text)) return;
                        String? r = this.widget.addTab(controller.text);

                        if (r == null) {
                          this.controller.clear();
                          this.focusNode.unfocus();
                          // result = null;
                          return;
                        }
                        // print('출력ㄹㄹㄹㄹㄹㄹㄹㄹㄹ');
                        result = r;
                        this.focusNode.unfocus();
                        setState(() {});
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
            if(result != null)
            Container(
              child: Text('$result',style: TextStyle(color: Colors.red),),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: widget.itemCount,
                          itemBuilder: widget.itemBuilder),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
