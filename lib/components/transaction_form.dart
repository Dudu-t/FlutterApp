import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final Map<String, TextEditingController> insertedTransaction = {
    'title': TextEditingController(),
    'value': TextEditingController()
  };

  _submitForm() {
    final title = insertedTransaction['title']!.text;
    final value = double.tryParse(insertedTransaction['value']!.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value);
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
              controller: insertedTransaction['title'],
              decoration: InputDecoration(
                labelText: 'Título',
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: insertedTransaction['value'],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Valor(R\$)'),
              onSubmitted: (_) => _submitForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Nova Transação'),
                  style: TextButton.styleFrom(primary: Colors.purple),
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
