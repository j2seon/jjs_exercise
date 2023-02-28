class Data<T> {
  final String img;
  final String title;
  final List<T> des;

  Data({required this.img, required this.title, required this.des});

  //네임드 생성자를 사용하자

  Data.json(e, List<T> Function(List) list)
      : img = e['img'],
        title = e['title'],
        des = list(e['des']);
}

class DesData {
  final String img;
  final String name;
  final String desc;

  DesData({required this.img, required this.name, required this.desc});

  DesData.json(k)
      : img = k['img'],
        name = k['name'],
        desc = k['desc'];
}
