import 'package:flutter/material.dart';
import 'package:jjs_exercise/todo/model/todo_model.dart';
import 'package:jjs_exercise/todo/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoUpdatePage extends StatelessWidget {
  static const path = '/todo/update';

  const TodoUpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoProvider _provider = context.watch<TodoProvider>();
    TodoModel updateModel = _provider.selectedModel!;
    return TodoUpdateView(
      updateTab: (String text) {
        if (text.isEmpty) return false;
        print(text);
       _provider.update(
          id: updateModel.id,
          content: text,
        );
        return true;
      },
      todo: updateModel.content,
    );
  }
}

class TodoUpdateView extends StatefulWidget {
  final String todo;
  final bool Function(String) updateTab;

  const TodoUpdateView({required this.todo, required this.updateTab, Key? key})
      : super(key: key);

  @override
  State<TodoUpdateView> createState() => _TodoUpdateViewState();
}

class _TodoUpdateViewState extends State<TodoUpdateView> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    this.controller.dispose();
    this.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.todo),
            TextField(
              controller: this.controller,
              focusNode: this.focusNode,
            ),
            IconButton(
              onPressed: () {
                if (!widget.updateTab(controller.text)) return;
                controller.clear();
                focusNode.unfocus();
              },
              icon: Icon(Icons.update),
            ),
          ],
        ),
      ),
    );
  }
}
