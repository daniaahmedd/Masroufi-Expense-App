
import 'package:flutter/material.dart';
import './expense.dart';
import './addExpense.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './totAmount.dart';

class HomePage extends StatefulWidget {
  TextEditingController exTitleController = TextEditingController();
  TextEditingController exAmountController = TextEditingController();
  TextEditingController exDateController = TextEditingController();
  Expense expenseobject = Expense();

  HomePage({super.key}){
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  double _totalAmountController = 0.0;
  List<Expense> expenseList = [];
  // String exTitle = exTitleController.text();
  // double exAmount = exAmountController.text();
  // String exTitle = exTitleController.text();

  void _showModal(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * .60,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                          child: TextField(
                          decoration: const InputDecoration(
                          labelText: 'Expense title',
                          ),
                          controller: widget.exTitleController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Amount in EGP',
                        ),
                        controller: widget.exAmountController,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.exDateController.text.toString(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                widget.exDateController.text = pickedDate.toString();
                              });
                            }
                          },
                          child: const Text('Choose Date'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          widget.expenseobject = Expense(
                              expensetitle: widget.exTitleController.text,
                              amount: double.parse(widget.exAmountController.text),
                              date: DateTime.parse(widget.exDateController.text)
                              );
                  
                              updateTotalAmount(widget.expenseobject.amount);
                              Navigator.pop(context);
                        },
                        child: Text('submit')
                    )
                  ],
                ),
              ),
            );
          },
        );
      } 
    );
  
  }

  void updateTotalAmount(double newvalue){
    setState(() {
      _totalAmountController += newvalue; 
      widget.exAmountController.text = _totalAmountController.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Masroufi App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.playlist_add_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              _showModal();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Container(
            child: SingleChildScrollView(
            child: () {
                if(widget.expenseobject.amount != 0){
                  return addExpense(widget.expenseobject);
                }
            }()
          ),
          ),
          ]
        ),
      ),
        floatingActionButton: FloatingActionButton(onPressed:(){ _showModal();}, tooltip: 'AddExpense',
        child: const Icon(Icons.add)
        )
    );
  }
}