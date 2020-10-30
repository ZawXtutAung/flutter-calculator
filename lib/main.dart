import 'package:flutter/material.dart';
import 'package:flutter_calculator/btn_layout.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Material App Bar'),
        // ),
        body: Center(
          child: Container(
            child: MainActivity(),
          ),
        ),
      ),
    );
  }
}

class MainActivity extends StatefulWidget {
  MainActivity({Key key}) : super(key: key);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  var userQues = '';
  var userAns = '';
  final List<String> btns = [
    'C',
    '⫷ del',
    '%',
    '+',
    '1',
    '2',
    '3',
    '⁻',
    '4',
    '5',
    '6',
    '×',
    '7',
    '8',
    '9',
    '÷',
    '=',
    '0',
    '00',
    '.',
  ];
  bool btn_opt(String opt) {
    if (opt == '×' ||
        opt == '⁻' ||
        opt == '+' ||
        opt == '÷' ||
        opt == '=' ||
        opt == '.' ||
        opt == '%') {
      return true;
    }
    return false;
  }

  bool btn_del(String btn_d) {
    if (btn_d == 'del') {
      return true;
    }
  }

  void equ_btn() {
    setState(() {
      String userStr = userQues;
      userStr = userStr.replaceAll('×', '*');
      userStr = userStr.replaceAll('÷', '/');
      Parser ps = Parser();
      Expression exp = ps.parse(userStr);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      userAns = eval.toString();
      //equ_btn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.blueGrey[200],
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(8, 30, 8, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(
                        userQues,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        userAns,
                        style: TextStyle(fontSize: 45),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                //padding: EdgeInsets.all(3),
                child: GridView.builder(
                  itemCount: btns.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    ///////////////DeleteBtn
                    if (index == 1) {
                      return Btn_layout(
                          btn_clck: () {
                            setState(() {
                              userQues =
                                  userQues.substring(0, userQues.length - 1);
                            });
                          },
                          btntxt: btns[index],
                          color: Colors.red,
                          txtcolor: Colors.white);
                      //////////CelBtn
                    } else if (index == 0) {
                      return Btn_layout(
                        btn_clck: () {
                          setState(() {
                            userAns = '';
                            userQues = '';
                          });
                        },
                        btntxt: btns[index],
                        color: Colors.purple,
                        txtcolor: Colors.white,
                      );
                      /////EquBtn
                    } else if (index == 16) {
                      return Btn_layout(
                        btn_clck: () {
                          equ_btn();
                        },
                        btntxt: btns[index],
                        color: Colors.green[500],
                        txtcolor: Colors.black,
                      );
                    } else {
                      return Btn_layout(
                        btn_clck: () {
                          setState(() {
                            userQues += btns[index];
                          });
                        },
                        btntxt: btns[index],
                        color: btn_opt(btns[index])
                            ? Colors.blueGrey
                            : Colors.white,
                        txtcolor:
                            btn_opt(btns[index]) ? Colors.white : Colors.red,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
