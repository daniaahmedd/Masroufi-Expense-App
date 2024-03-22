import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:trial2/homepage.dart';
import './expense.dart';
import 'package:intl/intl.dart';
import './totAmount.dart';

class addExpense extends HookWidget {
  Expense expenseInput= Expense();
  int index = -1;
  bool rerender = false;

  addExpense(
    Expense x,
  ){
    this.expenseInput = x;
  }

  @override
  Widget build(BuildContext context) {
    final expenseList= useState<List<Expense>>([]);
    final removed = useState(false);
    final totamount = useState(0.0);
    useEffect(() {
      expenseList.value.add(expenseInput);
      expenseList.value.map((exp) {
      totamount.value += exp.amount;
      });
    }, [expenseList, expenseInput]);
    

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: (){
              if(removed.value){
                removed.value = false;
                double sum = 0;
                expenseList.value.map((exx) {
                  sum += exx.amount;
                }).toList();
                if(expenseList.value.length == 1){
                  sum = expenseList.value[0].amount;
                }else if(expenseList.value.length == 0){
                  sum = 0;
                }
                return totAmount(sum);
              }else{
                double sum = 0;
                expenseList.value.map((exx) {
                  sum += exx.amount;
                }).toList();
                if(expenseList.value.length == 1){
                  sum = expenseList.value[0].amount;
                }else if(expenseList.value.length == 0){
                  sum = 0;
                }
                return totAmount(sum);
              }
              
            }()
          ),
          SingleChildScrollView(
            child: Column(
              children: expenseList.value.map((ex) {
                return Card(
                  margin: EdgeInsets.all(10), 
                  elevation: 15, 
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ 
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5), 
                            decoration: BoxDecoration(
                              border: Border.all(), 
                            ),
                            padding: EdgeInsets.all(10), 
                            child: Center( 
                              child: 
                              Text(ex.amount.toString(), style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold,),),
                            ),
                          ),
                          Column( 
                            children: [
                              Text(ex.expensetitle, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold)),
                              Text(DateFormat('dd-MM-yyyy').format(ex.date), style: TextStyle(color: Colors.grey))
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0), 
                            child: IconButton(
                            iconSize: 60,
                            icon: const Icon(IconData(0xf697, fontFamily: 'MaterialIcons'), color: Colors.red,),
                            onPressed: () {
                              expenseList.value.remove(ex);
                              // editRemovedExAmount(ex);
                              removed.value = true;
                            },
                          ),
                          ),
                          
                      ],),
                      )
                  ],));
              }).toList(),
            ),
          ),
        ],
    ),
    
  );
    
    
  
  }
}