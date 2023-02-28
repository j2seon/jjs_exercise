class Sample<T> {
  final String img;
  final String title;
  final List<T> des;

  Sample({required this.title, required this.img, required this.des});

  Sample.json(json,List<T> Function(List) list):
      img = json['img'],
      title = json['title'],
      des = list(json['des']);

}

class SampleDes {
  final String img;
  final String name;
  final String desc;
  final String title;

  SampleDes(
      {required this.img, required this.name, required this.desc, required this.title});

  SampleDes.json(data)
      : img = data['img'],
        name = data['name'],
        desc = data['desc'],
        title = data['title'];

}