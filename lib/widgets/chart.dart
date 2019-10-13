import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_project/Model/transaction.dart';
import 'package:second_project/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recenttransaction;

  Chart(this.recenttransaction);

  List<Map<String, Object>> get groupTransActionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recenttransaction.length; i++) {
        if (recenttransaction[i].date.day == weekDay.day &&
            recenttransaction[i].date.month == weekDay.month &&
            recenttransaction[i].date.year == weekDay.year) {
          totalSum += recenttransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupTransActionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransActionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                maxSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
