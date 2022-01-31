import 'dart:math';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Color Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dynamic Flutter Bar Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int maxCount = 0;
  List<List<int>> newPositions=[];
  List<int> array1 = [10, 30, 60, 120, 240,480];
  int arrayPoint1 = 300;

  @override
  void initState() {
    initValue(arrayPoint1, array1);
    super.initState();
  }

  initValue(int arrayPoint, List<int> array){
    List<int> newValue=[];
    maxCount=0;
    newPositions=[];
    for (int i = 0; i < array.length; i++) {
      if(i!=array.length-1){
        int checkPoint=0;
        if (array[i] <= arrayPoint && array[i + 1] >= arrayPoint ) {
          checkPoint=arrayPoint;
        }
        newValue.add(((array[i+1]) - array[i]));
        newPositions.add([array[i],((array[i+1]) - array[i]),array[i+1],checkPoint]);
      }
    }
    // New data
    maxCount = newValue.sum;
  }

  List<Widget> getArrayListReturn(
      int arrayPoint, List<int> array, double width) {
    List<Widget> list = [];

    for(int i=0;i<newPositions.length;i++){
      Random random = Random();
      Color tempo = Color.fromRGBO(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        1,
      );
      list.add(
        Container(
          height: 40,
          width: (width * newPositions[i][1] / maxCount).toDouble(),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: tempo,
          ),
        ),
      );
    }
    return list;
  }

  List<Widget> getArrayTextReturn(
      int arrayPoint, List<int> array, double width) {
    List<Widget> list = [];
    for (int i = 0; i < array.length; i++) {
      if(i!=array.length-1) {
        list.add(
          SizedBox(
            height: 40,
            width: (width * newPositions[i][1] / maxCount).toDouble(),
            child: Text("${newPositions[i][0]}"),
          ),
        );
      }
      else {
        list.add(
          SizedBox(
            height: 40,
            child: Text("${array[i]}"),
          ),
        );
      }
    }
    return list;
  }

  List<Widget> getPointerReturn(
      int arrayPoint, List<int> array, double width) {
    List<Widget> list = [];
    double totalSum=0;
    for(int i=0;i<newPositions.length;i++){
      if(newPositions[i][3]!=0){
        totalSum=totalSum+ (width * (newPositions[i][3]-newPositions[i][0]) / maxCount).toDouble()-14;
        list.add(
          SizedBox(
            width: MediaQuery.of(context).size.width*0.85,
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: totalSum,
                ),
                Text("$arrayPoint"),
                Expanded(child: Container())
              ],
            ),
          ),
        );
        break;
      }
      else{
        totalSum=totalSum+ (width * newPositions[i][1] / maxCount).toDouble();
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Wrap(
                children: getPointerReturn(
                    arrayPoint1, array1, MediaQuery.of(context).size.width*0.85),
              ),
              Wrap(
                children: getArrayListReturn(
                    arrayPoint1, array1, MediaQuery.of(context).size.width*0.85),
              ),
              Wrap(
                children: getArrayTextReturn(
                    arrayPoint1, array1, MediaQuery.of(context).size.width*0.85),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
