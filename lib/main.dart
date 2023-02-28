import 'package:flutter/material.dart';
import 'package:jjs_exercise/sample/sample_provider.dart';
import 'package:jjs_exercise/sample/sample_view.dart';
import 'package:jjs_exercise/todo/provider/todo_provider.dart';
import 'package:jjs_exercise/todo/view/todo_page.dart';
import 'package:jjs_exercise/todo/view/todo_update_page.dart';
import 'package:provider/provider.dart';

import 'count_provider.dart';
import 'expanded_feb.dart';
import 'model/model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountState>(
          create: (context) => CountState(),
        ),
        ChangeNotifierProvider<SampleProvider>(
          create: (context) => SampleProvider(),
        ),
        ChangeNotifierProvider<TodoProvider>(
          create: (context) => TodoProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.indigo[500],
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo[300],
            )),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings routeSettings) {
          if (routeSettings.name == SampleListPage.path) {
            return MaterialPageRoute(
              settings: RouteSettings(name: SampleListPage.path),
              builder: (_) => SampleListPage(),
            );
          }
          if (routeSettings.name == SampleDetailPage.path) {
            return MaterialPageRoute(
              settings: RouteSettings(name: SampleDetailPage.path),
              builder: (_) => SampleDetailPage(),
            );
          }
          // return MaterialPageRoute(
          //   settings: RouteSettings(name: SampleViewPage.path),
          //   builder: (_) => SampleViewPage(),
          // );
          if (routeSettings.name == TodoUpdatePage.path) {
            return MaterialPageRoute(
              settings: RouteSettings(name: TodoUpdatePage.path),
              builder: (_)=> TodoUpdatePage(),
            );
          }
          return MaterialPageRoute(
            settings: RouteSettings(name: TodoListPage.path),
            builder: (_) => TodoListPage(),
          );
        },
        // home: SampleViewPage(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final _dumy = [
    {
      'img': '',
      'title': 'EDM',
      'des': [
        {
          'img': '',
          'name': '가수1',
          'desc': '정보...',
        },
        //
        //   'img': '',
        //   'name': '',
        //   'desc': '',
        // },
        // {
        //   'img': '',
        //   'name': '',
        //   'desc': '',
        // }
      ],
    },
    // {
    //   'img': '',
    //   'title': '',
    // },
    // {
    //   'img': '',
    //   'title': '',
    // },
  ];

  // List<Data> parser(List dumy) {
  //   final List<Data> result = dumy.map<Data>((data) => Data(name: data['name'],
  //       title: data['title'],
  //       des: List.of(data['dsc']).map<DetailData>((e) => DetailData(img: e['img'], name: e['name'], desc: e['desc'])).toList()))
  //       .toList();
  //   return result;
  // }
  // List<Data> parser(List dumy) {
  //   final List<Data> result = dumy.map<Data>((e) => Data.json(e)).toList();
  //   return result;
  // }

  // List<Data<DetailData>> parser(List dumy) {
  //   List<Data<DetailData>> result =dumy.map<Data<DetailData>>((e) => Data<DetailData>.json(
  //           e,
  //           (List list) =>
  //               list.map<DetailData>((t) => DetailData.json(t)).toList()))
  //       .toList();
  //   return result;
  // }

  List<Data> parser(List dumy) {
    return dumy
        .map<Data<DesData>>(
          (e) => Data.json(
            e,
            (List list) => list
                .map<DesData>(
                  (k) => DesData.json(k),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Data> _data = parser(_dumy);

    return SafeArea(
      child: Scaffold(
        // drawer: Drawer(),
        endDrawer: Drawer(),
        appBar: AppBar(
          // leading:Container(),
          // actions: [Container()],
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: GridView.builder(
          itemCount: _data.length,
          padding: EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return MyCell(
              isShow: index % 2 == 0,
              onTap: () async {
                bool? b = await showDialog<bool?>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('POPUP'),
                    content: Text('페이지를 이동하시겠습니까?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop<bool>(false);
                        },
                        child: Text('취소'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushReplacement<void, bool?>(
                                  MaterialPageRoute<void>(
                                    builder: (context) => ListScreen(
                                      list: ['list1', 'list2', 'list3'],
                                    ),
                                  ),
                                  result: true);
                        },
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
                //궁금점 : showDialog의 값을 보고 실행되는건데 페이지 이동하고도 값이뜬다,
                // 1. 그럼 새로이동한 페이지에서 값을 사용할수 있는건지?
                // 2. pushReplacement때문에 이전 값이 그냥 띄워지는건지?
                // 3. 이 값을 활용할수있는 법..? route와 관련인거같은데 route개념이 없는듯... ㅠ > 추가로 찾아보자
                if (b == null) {
                  print('b가 널인데?');
                } else if (b) {
                  print('페이지이동');
                } else {
                  print('b는 false야');
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class MyCell extends StatelessWidget {
  final bool isShow;
  final void Function()? onTap;

  const MyCell({required this.onTap, required this.isShow, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(2, 3)),
            ],
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.more_horiz),
              width: double.infinity,
              alignment: Alignment.centerRight,
            ),
            Stack(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black38, offset: Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.circular(50.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://ssl.pstatic.net/melona/libs/1421/1421692/d21d11fe2c890e2d9723_20230117171110324.jpg')),
                  ),
                ),
                if (!isShow)
                  Positioned(
                    right: 0,
                    top: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: 10,
                      height: 10,
                    ),
                  ),
              ],
            ),
            Container(
              child: Text('dddddd'),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Icon(Icons.mail_outline),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  ListScreen({required this.list, Key? key}) : super(key: key);

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text((index + 1).toString()),
            subtitle: Text(list[index]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPage(),
            )),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://ssl.pstatic.net/melona/libs/1432/1432722/103266b5bfd9770b419c_20230120150040883.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight)),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text('data'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(children: [
        ActionButton(
          icon: const Icon(
            Icons.star_border_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            print('star');
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            print('settings');
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            print('add');
          },
        ),
      ], distance: 100),
    );
  }
}
