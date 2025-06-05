import 'package:expense_app/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  // reference our box
  final _myBox = Hive.box("expense_database2");

  //write data
  void saveData(List<ExpenseItem> allExpense){

/*
 
hive can only store strings and datetime and not custom objects like ExpenseItem
So lets convert ExpenseItem objects into types that can be sored in our db

allExpense =

[

ExpenseItem(name / amount / dateTime)
..

]

->

[

[name, amount, dateTime],
..

]

*/
  List<List<dynamic>> allExpenseFormatted = [];

  for(var expense in allExpense){
    List<dynamic> expenseFormatted =[
      expense.name,
      expense.amount,
      expense.dateTime,
    ];
    allExpenseFormatted.add(expenseFormatted);
  }
  _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  //read data
  List<ExpenseItem> readData(){
    /*

      Data is stored in hive as alist of strings + dateTime
      so lets convert our saved data into ExpenseItem objects

      savedData =

      [
      
      [name, amount, dateTime],
      ..
      
      ]

      ->

      [
      
      ExpenseItem(name / amount / dateTime),
      ..
      
      ]

    */
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for(int i=0 ; i< savedExpenses.length ; i++){
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
        name: name, 
        amount: amount, 
        dateTime: dateTime
        );

        allExpenses.add(expense);
    }

    return allExpenses;

  }
}