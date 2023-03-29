import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider with ChangeNotifier {
  var expression = "";
  var result = "0";

  void addInput(String value) {
    if (value == "AC") {
      expression = "";
      result = "0";
    } else if (value == "⌫") {
      expression = expression.substring(0, expression.length - 1);
    } else if (value == "=") {
      if (expression.endsWith("+") ||
          expression.endsWith("-") ||
          expression.endsWith("x") ||
          expression.endsWith("÷")) {
        expression = expression.substring(0, expression.length - 1);
      }
    } else {
      expression += value;
    }

    if (expression.isNotEmpty &&
            !expression.endsWith("+") &&
            !expression.endsWith("-") &&
            !expression.endsWith("x") &&
            !expression.endsWith("÷") ||
        expression.endsWith("%")) {
      var expressions = expression
          .replaceAll("x", "*")
          .replaceAll("÷", "/")
          .replaceAll("%", "/100");
      Parser parser = Parser();
      Expression exp = parser.parse(expressions);
      result = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
      if (result.endsWith(".0")) {
        result = result.substring(0, result.length - 2);
      }
    }
    notifyListeners();
  }
}
