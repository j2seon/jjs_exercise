import 'package:flutter/foundation.dart';
import 'package:jjs_exercise/sample/sample_model.dart';

//{
//         'img': '',
//         'title': 'EDM',
//         'des': [
//           {
//             'img': 'https://ssl.pstatic.net/melona/libs/1432/1432722/103266b5bfd9770b419c_20230120150040883.jpg',
//             'name': '가수1',
//             'title': 'first',
//             'desc': '정보...',
//           },
//         ],
//       },
class SampleProvider with ChangeNotifier {
  //  1.List<Sample<SampleDes>> 상태
  List<Sample<SampleDes>> _data = [
    Sample.json(
      {
        'img': '',
        'title': 'EDM',
        'des': [
          {
            'img':
                'https://ssl.pstatic.net/melona/libs/1432/1432722/103266b5bfd9770b419c_20230120150040883.jpg',
            'name': '가수1',
            'title': 'first',
            'desc': '정보...',
          },
        ],
      },
      (p0) => p0.map<SampleDes>((e) => SampleDes.json(e)).toList(),
    ),
  ];

  // 2.List<Sample<SampleDes>> getter
  List<Sample<SampleDes>> get datas => [..._data];

  setData() {}

  //3. 선택된 List<Sample<SampleDes>>를 알기위해 index저장
  int? selectSample;
  // index를 저장하고 바뀐걸 알아야하니까 notify
  void setSelectIndex(int index){
    if(selectSample != null) return;
    selectSample = index;
    notifyListeners();
  }

  String? get selectTitle{
    if(this.selectSample==null)return null;
    return datas[selectSample!].title;
  }

  //선택된 List<Sample<SampleDes>>의 SampleDes의 데이터 필요
  List<SampleDes>? sampleDesData;

  void setDesData(){
    if(sampleDesData != null ) return;
    sampleDesData = datas[selectSample!].des;
    notifyListeners();
  }

  int? sampleDesDataIndex;
  //선택된 SampleDesData 의 index 값

  void setSelectDesIndex(int index){
    if(sampleDesDataIndex != null) return;
    sampleDesDataIndex = index;
    notifyListeners();
  }

  //세부내용
  SampleDes? sampleDes;

  void setDesDataDetail() {
    if(this.sampleDes != null) return;
    sampleDes = this.sampleDesData![sampleDesDataIndex!];
    notifyListeners();

}



}
