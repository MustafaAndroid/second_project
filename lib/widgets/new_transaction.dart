import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleEditControler = TextEditingController();
  final _amountEditControler = TextEditingController();
  DateTime _selectDate;

  void _sumbitData() {
    if(_amountEditControler.text.isEmpty)
    {
      return;
    }
    final entertitle = _titleEditControler.text;
    final enteramount = double.parse(_amountEditControler.text);

    if (entertitle.isEmpty || enteramount <= 0 || _selectDate == null) {
      return;
    }
    widget.addTx(entertitle, enteramount,_selectDate);

    Navigator.of(context).pop();
  }

  void _presendDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'Title', hintStyle: TextStyle(color: Colors.blue)),
              onSubmitted: (_) => _sumbitData(),
              controller: _titleEditControler,
              // onChanged: (valtitle) => titleInput = valtitle,
            ),
            TextField(
                decoration: InputDecoration(
                    labelText: 'Amount',
                    hintStyle: TextStyle(color: Colors.blue)),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _sumbitData(),
                controller: _amountEditControler
                // onChanged: (valAmount) => amountInput = valAmount
                ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date ${DateFormat.yMd().format(_selectDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      ' Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presendDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _sumbitData,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
