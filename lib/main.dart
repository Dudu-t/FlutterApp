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
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't1', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't13', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't14', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't15', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't17', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't14', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't1123', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't11123', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 'ts1', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't123d1', title: 'Teste 1', value: 199.90, date: DateTime.now()),
    Transaction(
        id: 't1a', title: 'Teste 1', value: 199.90, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
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
    final AppBar appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: [
        IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add))
      ],
    );
    final avaibleHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Center(
      child: Scaffold(
        appBar: appBar,
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
                Container(
                  height: avaibleHeight * 0.3,
                  child: Chart(_recentTransactions),
                ),
                Column(
                  children: [
                    Container(
                      height: avaibleHeight * 0.7,
                      child: TransactionList(_transactions, _removeTransaction),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
