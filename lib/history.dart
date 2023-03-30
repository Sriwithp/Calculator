import 'package:calculator/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final history = Hive.box("History");

  List<Map<String, dynamic>> historyItems = [];

  @override
  void initState() {
    super.initState();
    historyItems = context.read<CalculatorProvider>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
          actions: [
            InkWell(
              onTap: () {
                history.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("All items are deleted")));
              },
              child: const Icon(Icons.delete_forever_sharp),
            ),
            const SizedBox(width: 20)
          ],
        ),
        body: historyItems.isEmpty
            ? const Center(child: Text("No Data"))
            : ListView.builder(
                itemCount: historyItems.length,
                itemBuilder: ((context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(historyItems[index]["result"]),
                    subtitle: Text(historyItems[index]["ex"],
                        style: const TextStyle(color: Colors.pink)),
                    trailing: InkWell(
                        onTap: () async {
                          await history.delete(historyItems[index]["key"]);

                          setState(() {
                            historyItems =
                                context.read<CalculatorProvider>().getHistory();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Item Deleted")));
                          });
                        },
                        child: Icon(Icons.delete)),
                  ));
                })));
  }
}
