import 'dart:async';

import '../model/todo_model.dart';

abstract class TodoService{

  ///테스트 용!!!
  TodoModel readDummy(){
    final dumy = {
      'id':'0',
      'content':'myTodo',
      'isCheck': false,
    };
    return TodoModel.json(dumy);
  }

  ///읽기 서비스
  ///그냥 todoModel이 필요할수도있고 아니면 서버에서 읽어와야되서 Future<TodoModel>이 필요할수도있다.->FutureOr
  FutureOr<TodoModel> read();

  // Future<TodoModel> add();
}

class TodoServiceImpl extends TodoService{

  @override
  TodoModel readDummy(){
    return super.readDummy();
  }

  @override
  FutureOr<TodoModel> read(){
    throw '테스트용 서비스입니다 readDummy함수를 이용하세요';
  }
  // @override
  // Future<TodoModel> add({required String id, required String content, required bool isCheck}){
  //   TodoModel addModel = TodoModel(id: id, content: content, isCheck: isCheck);
  //   return addModel;
  // }


}
