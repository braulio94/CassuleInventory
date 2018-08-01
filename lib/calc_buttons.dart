import 'package:flutter/material.dart';

class CalculatorButtons extends StatelessWidget {

  final double keyboardWidth;
  final Function(int number) onNumberPressed;
  final Function() onCalculateResult;
  CalculatorButtons({this.keyboardWidth, this.onNumberPressed, this.onCalculateResult});

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
          }, child: Text("${from + index}", style: TextStyle(fontSize: 40.0))),
        ),
      );
    }).toList();
  }

  Widget buildOperatorButton(String value, int flex){
    return Expanded(flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: RaisedButton(
          color: value == 'ENTRAR' ? Colors.red[700] : Colors.white,
          onPressed: (){
          if(value.contains("0")){
            onNumberPressed(0);
          } else if (value == 'C'){
            onNumberPressed(-1);
          } else if(value == 'ENTRAR'){
            onCalculateResult();
          }
        },
            child: Text(value, style: TextStyle(fontSize: 40.0, color: value == 'ENTRAR' ? Colors.white : Colors.black))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: keyboardWidth,
      height: 350.0,
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
                  buildOperatorButton("C", 2)
                ]
            ),
          ),
          Expanded(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildOperatorButton("ENTRAR", 3)
                ]
            ),
          ),
        ],
      ),
    );
  }
}
