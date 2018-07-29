import 'package:flutter/material.dart';

class CalculatorButtons extends StatelessWidget {

  final double keyboardWidth;
  final Function(int number) onNumberPressed;


  CalculatorButtons({this.keyboardWidth, this.onNumberPressed});

  Widget buildRow(int numberKeyCount, int startNumber,  int numberFlex, int operrationFlex){
    return new Expanded(child:
    Row(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: new List.from(buildNumberButtons(numberKeyCount,startNumber ,numberFlex))));
  }

  List<Widget>  buildNumberButtons( int count,int from, int flex) {
    return new Iterable.generate(count, (index) {
      return new Expanded(flex: flex,
        child: new Padding(padding: const EdgeInsets.all(4.0),
          child: RaisedButton(
            color: Colors.white,
            onPressed: (){
            onNumberPressed(from + index);
          }, child: Text("${from + index}", style: TextStyle(fontSize: 40.0),)),
        ),
      );
    }).toList();
  }

  Widget buildOperatorButton(String value, int flex){
    return Expanded(flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: RaisedButton(
          color: Colors.white,
          onPressed: (){
          value.contains("0") ? onNumberPressed(int.parse(value)) : null;
        },
            child: Text(value, style: TextStyle(fontSize: 40.0),)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: keyboardWidth,
      height: 300.0,
      //color: Colors.red[900],
      child: Column( crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          buildRow(3,1,1,1),
          buildRow(3,4,1,1),
          buildRow(3,7,1, 1),
          Expanded(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildOperatorButton("0", 1),
                  buildOperatorButton("ENTRAR", 2)
                ]
            ),
          ),
        ],
      ),
    );
  }
}
