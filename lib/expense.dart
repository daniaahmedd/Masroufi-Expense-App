import 'package:flutter/material.dart';

class Expense{
  String expensetitle;
  double amount;
  DateTime date;

  Expense({
    this.expensetitle = "",
    this.amount = 0.0,
    DateTime ? date,
  }) : this.date = date ?? DateTime.now();
}