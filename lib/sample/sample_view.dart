import 'package:flutter/material.dart';
import 'package:jjs_exercise/sample/sample_provider.dart';
import 'package:provider/provider.dart';

//SampleView의 데이터를 관리할 위젯
class SampleViewPage extends StatelessWidget {
  static const path = '/sample';
  const SampleViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SampleProvider _provider = context.watch<SampleProvider>();
    return SampleViewScreen(
      itemCount: _provider.datas.length,
      itemBuilder: (context, index) => SampleViewTile(
        onTap: () {
          _provider.setSelectIndex(index);
          _provider.setDesData();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SampleListPage(),
            ),
          );
        },
        title: _provider.datas[index].title,
      ),
    );
  }
}

class SampleViewScreen extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const SampleViewScreen(
      {required this.itemCount, required this.itemBuilder, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: this.itemCount, // 데이터 필요
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}

class SampleViewTile extends StatelessWidget {
  final void Function() onTap;
  final String title;

  const SampleViewTile({required this.onTap, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class SampleListPage extends StatelessWidget {
  static const path = '/sample/list';
  const SampleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SampleProvider _provider = context.watch<SampleProvider>();
    return SampleListScreen(
      title: _provider.selectTitle ?? '',
      itemCount: _provider.sampleDesData?.length ?? 0,
      itemBuilder: (context, index) => ListTile(
        title: Text(_provider.sampleDesData?[index].title ?? ''),
        subtitle: Text(_provider.sampleDesData?[index].name ?? ''),
        onTap: () {
          _provider.setSelectDesIndex(index);
          _provider.setDesDataDetail();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SampleDetailPage(),
            ),
          );
        },
        leading: Text(
          index.toString(),
        ),
      ),
    );
  }
}

class SampleListScreen extends StatelessWidget {
  final int itemCount;
  final String title;
  final Widget Function(BuildContext, int) itemBuilder;

  const SampleListScreen(
      {required this.itemCount,
      required this.title,
      required this.itemBuilder,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class SampleDetailPage extends StatelessWidget {
  static const path = 'sample/list/detail';
  const SampleDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SampleProvider _provider = context.watch<SampleProvider>();
    return SampleDetailScreen(
      title: _provider.sampleDes?.title ?? '?',
      subtitle: _provider.sampleDes?.name ?? '',
      desc: _provider.sampleDes?.desc ?? '',
      img: _provider.sampleDes?.img ?? '',
    );
  }
}

class SampleDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String desc;
  final String img;
  const SampleDetailScreen({required this.img, required this.desc,required this.subtitle,required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: NetworkImage(img),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
