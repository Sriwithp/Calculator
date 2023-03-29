import 'package:calculator/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorHome extends StatelessWidget {
  const CalculatorHome({super.key});

  @override
  Widget build(BuildContext context) {
    List padValue = [
      "AC",
      "!",
      "%",
      "⌫",
      "7",
      "8",
      "9",
      "÷",
      "4",
      "5",
      "6",
      "x",
      "1",
      "2",
      "3",
      "-",
      "0",
      ".",
      "=",
      "+",
    ];
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Calculator"),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/history");
                },
                child: const Icon(Icons.history)),
            const SizedBox(width: 10)
          ],
          backgroundColor: Colors.pink),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: mediaQuery.width,
            height: mediaQuery.height * .3,
            padding: EdgeInsets.symmetric(
              vertical: mediaQuery.width * 0.08,
              horizontal: mediaQuery.width * 0.06,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20.0,
                  child: Text(context.watch<CalculatorProvider>().expression,
                      style: const TextStyle(fontSize: 22)),
                ),
                const SizedBox(height: 10.0),
                const Divider(),
                const SizedBox(height: 10.0),
                Text(
                  context.watch<CalculatorProvider>().result,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.pink,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GridView.builder(
              primary: false,
              reverse: false,
              itemCount: padValue.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5.0,
                // childAspectRatio: 1.3,
                mainAxisSpacing: 5.0,
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: padValue[index] == "="
                          ? const MaterialStatePropertyAll(Colors.green)
                          : null),
                  onPressed: () {
                    context
                        .read<CalculatorProvider>()
                        .addInput(padValue[index]);
                  },
                  child: Text(padValue[index],
                      style: const TextStyle(
                          // color: padValue[index] == "=" ? Colors.pink : null,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
