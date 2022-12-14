import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '翻牌遊戲'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> values = [
    'sunny',
    'sunny',
    'rainy',
    'rainy',
    'snowy',
    'snowy',
    'moon',
    'moon'
  ];
  List<bool> isFlipped = List<bool>.generate(8, (index) => false);
  int countOfTap = 0;
  int firstTapIndex;
  @override
  void initState() {
    values.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = !isFlipped.contains(false);
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(
          children: [
            Spacer(),
            Container(
              height: 500,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: values.length + 1,
                  itemBuilder: (context, index) {
                    if (index < 8) {
                      return Card(
                          color: Colors.amber,
                          child: InkWell(
                              onTap: () {
                                print(isCompleted);
                                switch (countOfTap) {
                                  case 0:
                                    if (!isFlipped[index]) {
                                      setState(() {
                                        isFlipped[index] = true;
                                      });
                                      countOfTap += 1;
                                      firstTapIndex = index;
                                    }
                                    break;
                                  case 1:
                                    if (!isFlipped[index]) {
                                      countOfTap += 1;
                                      setState(() {
                                        isFlipped[index] = true;
                                        if (values[firstTapIndex] !=
                                            values[index]) {
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1000), () {
                                            setState(() {
                                              print('翻回去');
                                              isFlipped[index] = false;
                                              isFlipped[firstTapIndex] = false;
                                              countOfTap = 0;
                                            });
                                          });
                                        } else {
                                          countOfTap = 0;
                                        }
                                      });
                                    }
                                    break;
                                  default:
                                }
                              },
                              child: isFlipped[index]
                                  ? Image.asset(
                                      'lib/assets/${values[index]}.png')
                                  : Text('')));
                    } else {
                      return Card(
                          color: Colors.lime,
                          child: InkWell(
                              onTap: () {
                                countOfTap = 0;
                                values.shuffle();
                                setState(() {
                                  isFlipped =
                                      List<bool>.generate(8, (index) => false);
                                });

                                print(values);
                                print(isFlipped);
                              },
                              child: Center(child: Text('reset'))));
                    }
                  }),
            ),
            isCompleted ? Text('恭喜！') : Text(''),
            Spacer(),
          ],
        ));
  }
}
