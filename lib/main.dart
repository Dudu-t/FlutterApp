import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'components/transaction_form.dart';
import 'dart:math';

main() => runApp(MyFinance());

class MyFinance extends StatelessWidget {
  const MyFinance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        textTheme: tema.textTheme.copyWith(
          headline6: TextStyle(fontFamily: 'Quicksand'),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
      id: 't0',
      title: 'Boletos',
      value: 900,
      date: DateTime.now().subtract(
        Duration(days: 33),
      ),
    ),
    Transaction(
      id: 't1',
      title: 'Conta de Luz',
      value: 50.30,
      date: DateTime.now().subtract(
        Duration(days: 4),
      ),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Agua',
      value: 90.2,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de Internet',
      value: 250.50,
      date: DateTime.now().subtract(
        Duration(days: 2),
      ),
    ),
  ];
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
          actions: [
            IconButton(
                onPressed: () => _openTransactionFormModal(context),
                icon: Icon(Icons.add))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Chart(_recentTransactions),
                Column(
                  children: [
                    TransactionList(_transactions),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
