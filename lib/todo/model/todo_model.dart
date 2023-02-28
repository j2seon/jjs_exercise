//final을 이용해서 상수로 만든다
//왜? 한번 지정되면 이 클래스는 변하면 안돼
// final 이 아닐 경우 내부에서 id = 3; 이런식으로 할당해서 바꿔버릴수있음. 그럼 불변객체가 아니다
//플러터는 참조값을 쳐다봐서 바꾸는 방식(명령형) 선언형의 방식으로 더 작동이 잘되게 되어있다.
//따라서 참조한 값을 바꾸는게 아니라 불편객체를 만들어서 다른객체일 경우 통째로 객체를 바꿔주자.

import 'package:uuid/uuid.dart';

class TodoModel {
  final String id;
  final String content;
  final bool isCheck;

  const TodoModel({
    required this.id,
    required this.content,
    this.isCheck = false,
  });

  TodoModel.json(Map<String, dynamic> json):
      id = json['id'],
      content = json['content'],
      isCheck = json['isCheck'];

  //원래 있던 객체의 값을 그대로 가져와서 새로운 객체를 만드는 함수
  TodoModel copy() => TodoModel(id: this.id,content: this.content, isCheck:this.isCheck);


}
