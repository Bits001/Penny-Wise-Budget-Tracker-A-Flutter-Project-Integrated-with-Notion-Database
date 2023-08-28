import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pennywise/models/itemsModel.dart';
import 'package:pennywise/models/model.dart';
import 'package:pennywise/repositories/repository.dart';
import 'package:pennywise/screens/spendingChart.dart';
import 'package:pennywise/utils/utils.dart';

class BudgetScreen extends StatefulWidget {
  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late Future<List<Items>> _futureItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureItems = BudgetRepository().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'PennyWise - Budget Tracker',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _futureItems = BudgetRepository().getItems();
          setState(() {});
        },
        child: FutureBuilder<List<Items>>(
          future: _futureItems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) return SpendingChart(items: items);

                  final item = items[index - 1];
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: getCategoryColor(item.category),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 2),
                        ),
                      ], 
                    ),
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text(
                        '${item.category} | ${DateFormat.yMd().format(item.date)}',
                      ),
                      trailing: Text(
                        '₱${item.price.toStringAsFixed(2)}',
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              final error = snapshot.error as Failure;
              return Center(
                child: Text(error.message),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
