import 'package:flutter/material.dart';

class totAmount extends StatefulWidget {
  double totalAmountInput = 0.0;
  bool rerender = false;

  totAmount(double totInput){
    totalAmountInput += totInput;
    rerender = true;
  }

  @override
  State<totAmount> createState() => _totAmountState();
}

class _totAmountState extends State<totAmount> {
  double _totalAmountController = 0.0;

  void updateTotAmount(){
    setState(() {
      _totalAmountController = widget.totalAmountInput;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,// Some height
      child: 
      Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black12,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
          children: <Widget>[
          Container(
            child: () {
              if(widget.rerender){
                updateTotAmount();
                widget.rerender = false;
              }
            }()
          ),
          Container (child: 
            Center(
              child: 
              Padding(padding: const EdgeInsets.only(top: 40),
              child: Text('EGP ${widget.totalAmountInput.toStringAsFixed(2)}', style: TextStyle(fontSize: 36)))
            )
          ),
        ], ),
        ),
      ),
    );
    
  }
}