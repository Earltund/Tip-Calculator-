import 'package:calculator/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cal extends StatefulWidget {
  const Cal({super.key});

  @override
  State<Cal> createState() => _CalState();
}
class _CalState extends State<Cal> {
  int _tipPercentage= 0;
  int _personCounter=1;
  double _billAmount= 0.00;
  double _tipAmount= 0.00;
  Color _purple= HexColor("690ADC");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0 ),
              ),
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Per Person",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: _purple,
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _purple,
                        fontSize: 34.0,
                      ),),
                    ),
                  ],
                ),
              ),

            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(12.0)
              ),

              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color: _purple,
                    ),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount ",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value){
                     try{
                       _billAmount = double.parse(value);
                     }catch(exception){
                        _billAmount= 0.00;
                     }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",style: TextStyle(
                        color: Colors.grey.shade700,),),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(_personCounter>1){
                                  _personCounter--;
                                }else{
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text("-", style:
                                  TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),),
                              ),
                            ),
                          ),
                          Text("$_personCounter",
                          style: TextStyle(
                            color: _purple,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                child: Text("+", style:
                                  TextStyle(
                                    color: _purple,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,

                                  ),),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          child: Center(
                            child: Text("\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",style:
                              TextStyle(
                                color: _purple,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ),
                      )
                    ],
                  ),
                 //slider
                  Column(
                    children: [
                      Text("$_tipPercentage%",style: TextStyle(
                        color: _purple,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      Slider(min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,//optional
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue){
                        setState(() {
                          _tipPercentage= newValue.round();
                        });
                          }
                      )
                    ],
                  )
                ],
              ),
            )

          ],
        ),
      )
      ,
    );
  }
  calculateTotalPerPerson(double billAmount, int splitBy,int tipPercentage){
    var totalPerPerson= (calculateTotalTip(billAmount, splitBy, tipPercentage)+ billAmount)/splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip =0.00;

    if(billAmount <0 || billAmount.toString().isEmpty || billAmount == null){
      // no go!!
    }else{
      totalTip= (billAmount * tipPercentage)/100;
    }
    return totalTip;
  }

}
