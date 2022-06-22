import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final Map<String, dynamic> _insertedTransaction = {
    'title': TextEditingController(),
    'value': TextEditingController(),
    'selectedDate': DateTime.now(),
  };

  _submitForm() {
    final _title = _insertedTransaction['title']!.text;
    final _value = double.tryParse(_insertedTransaction['value']!.text) ?? 0.0;
    final _selectedDate = _insertedTransaction['selectedDate'];
    if (_title.isEmpty || _value <= 0) {
      return;
    }
    widget.onSubmit(_title, _value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _insertedTransaction['selectedDate'] = pickedDate;
        });

        print(_insertedTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _insertedTransaction['title'],
              decoration: InputDecoration(
                labelText: 'Título',
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: _insertedTransaction['value'],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Valor(R\$)'),
              onSubmitted: (_) => _submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_insertedTransaction['selectedDate'] == null
                        ? 'Nenhuma data selecionada!'
                        : 'Data selectionada: ${DateFormat('dd/MM/y ').format(_insertedTransaction['selectedDate'])}'),
                  ),
                  TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text('Nova Transação'),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
