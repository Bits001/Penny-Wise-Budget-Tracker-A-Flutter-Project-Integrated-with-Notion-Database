import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pennywise/utils/utils.dart';
import '../models/itemsModel.dart';

class SpendingChart extends StatelessWidget {
  final List<Items> items;
  const SpendingChart({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final spending = <String, double>{};

    items.forEach(
      (item) => spending.update(
        item.category,
        (value) => value + item.price,
        ifAbsent: () => item.price,
      ),
    );
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 360.0,
        child: Column(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: spending
                      .map((category, amountSpent) => MapEntry(
                            category,
                            PieChartSectionData(
                              color: getCategoryColor(category),
                              radius: 100.0,
                              title: '\₱${amountSpent.toStringAsFixed(2)}',
                              value: amountSpent,
                            ),
                          ))
                      .values
                      .toList(),
                  sectionsSpace: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: spending.keys
                  .map((category) => _Indicator(
                        color: getCategoryColor(category),
                        text: category,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const _Indicator({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 16.0,
          width: 16.0,
          color: color,
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
