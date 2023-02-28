import 'package:flutter/foundation.dart';
import 'package:jjs_exercise/todo/model/todo_model.dart';

import '../service/todo_service.dart';

class TodoProvider with ChangeNotifier {

  TodoService _todoService = TodoServiceImpl();

  TodoProvider(){
    Future(this._read);
  }
  ///state 1. todo 전체 내용
  final Map<String, TodoModel> _todoList = {};

  Map<String, TodoModel> get todoList => {...this._todoList};

  //외부에서 접근 못하게 _ 사용하고 getter 만들어 주기>왜? 외부에서 접근해서 값을 날릴수있음.
  //final 은? 내부에서 변경하지 못하게 사용 _todoList = ~~이 안되게함.

  /// desc 1. create
  Future<TodoModel> add({required String content, bool isCheck = false}) async{
    final TodoModel _todo = TodoModel(
      id: _todoList.length.toString(),
      content: content,
      isCheck: false,
    );
    this._todoList.addAll({_todo.id : _todo});
    // await _todoService.add()
    this._todoList.addAll({

    });

    notifyListeners();
    return _todo.copy(); // 참조된 값을 반환하지 않고 카피한 값을 반환.
  }

  //선택한 모델의 경우
  TodoModel? _selectedModel;
  TodoModel? get selectedModel => _selectedModel?.copy();

  void select(int index){
    _selectedModel = todoList.values.toList()[index];
    notifyListeners();
  }

  /// desc 2. update
  TodoModel update({required String id, required String content,bool isCheck = false}){
    TodoModel _updateTodo = TodoModel(id: id, content: content, isCheck: isCheck);
    this._todoList[id] = _updateTodo; // 새로 만든걸로 바꿔끼우기

    this._selectedModel = _updateTodo.copy(); //
    notifyListeners();
    return _updateTodo.copy();
  }
  ///desc 3. delete
  TodoModel? remove({required String id}){
    TodoModel? _deleteTodo = this._todoList[id]?.copy(); //카피한 값으로
    this._todoList.remove(id);
    notifyListeners();
    return _deleteTodo; //반환할때는 참조되어있지 않은 값으로!
  }

  ///desc 4. read
  ///provider가 만들어지고 읽을 수 있게하자 
  ///>>왜? provider은 context를 이용하는데 build가 되기 전에 read가 실행되서 notifyListener가 될수있어서
  void _read(){ 
    /// 일단은 더미데이터를 넘겨주자 fix
    // final dumy = {
    //   'id':'0',
    //   'content':'myTodo',
    //   'isCheck': false,
    // };
    // TodoModel m = TodoModel.json(dumy);
    // _todoList[m.id] = m;

    _todoList.addAll({_todoService.readDummy().id : _todoService.readDummy()});
    notifyListeners();
  }

  //그럼 프로바이더가 실행되고 read를 하게하려면???
  //provider가 생성될때 > 같이 생성되게 근데! 모든 일반함수가 실행되고 read가 실행될 수 있도록
// Future 이용하자!!!!!!!!!!
  
  // void read(){
  //   this._read();
  // }




}
