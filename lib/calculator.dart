import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rpn_calculator/Command.dart';
import 'package:rpn_calculator/Stack.dart';
import 'package:rpn_calculator/key_button.dart';

class RPNCalculator extends StatefulWidget {
  const RPNCalculator({Key? key}) : super(key: key);

  @override
  State<RPNCalculator> createState() => _RPNCalculatorState();
}

class _RPNCalculatorState extends State<RPNCalculator> {
  final Map<String, Operator> _operatorMap = {
    "+": Plus(),
    "-": Minus(),
    "*": Multiply(),
    "/": Divide(),
  };

  final Map<String, Command> _commandMap = {
    "C": ClearCommand(),
    "Del": DeleteCommand(),
    "Enter": EnterCommand(),
    "Undo": UndoCommand(),//TODO FIX
    "Comma": CommaCommand(),//TODO FIX
    "Pop": PopCommand()

  };

  final myStack _stack = myStack();

  bool resat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RPN calculator")),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildStackScroll(context),
          _buildControls(context),
        ],
      ),
    );
  }

  _buildControls(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final str in ["C", "Del", "Undofix"])
                KeyButton.operator(
                    onPressed: () => _handleCommand(str), label: str),
                KeyButton.operator(onPressed:() => _handleOperator("/"), label: "/")
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final num in [7, 8, 9])
                  KeyButton.number(
                    onPressed: () => _updateInput(num),
                    label: num.toString(),
                  ),
                KeyButton.operator(
                    onPressed: () => _handleOperator("*"), label: "*")
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final num in [4, 5, 6])
                  KeyButton.number(
                    onPressed: () => _updateInput(num),
                    label: num.toString(),
                  ),
                KeyButton.operator(
                    onPressed: () => _handleOperator("+"), label: "+")
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final num in [1, 2, 3])
                  KeyButton.number(
                    onPressed: () => _updateInput(num),
                    label: num.toString(),
                  ),
                KeyButton.operator(
                    onPressed: () => _handleOperator("-"), label: "-")
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    KeyButton.number(
                        onPressed: () => _updateInput(0), label: "0"),
                    KeyButton.operator(
                        onPressed: () => _handleCommand("Pop"), label: "Pop"),
                  ],
                )),
                KeyButton(
                    onPressed: () => _handleCommand("Enter"), label: "Enter"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _handleCommand(String s) {
    var com = _commandMap[s];
    com?.execute(_stack);
    resat = false;
    setState(() {});
  }

  _handleOperator(String string) {
    var op = _operatorMap[string];
    if (op?.accept(_stack)) {
      op?.execute(_stack);
      resat = true;
    }
    setState(() {});
  }

  _updateInput(int s) {
    String val;
    if (!resat) {
      val = _stack.pop().toString();
      resat = false;
    } else {
      val = "";
    }
    val += s.toString();
    _stack.push(num.parse(val));
    setState(() {});
  }

  _buildStackScroll(BuildContext context) {
    return Expanded(
      child: ListView(
        reverse: true,
        scrollDirection: Axis.vertical,
        children: List.generate(_stack.length(), (index) {
          String string = _stack.getStack().toList()[index].toString();
          return Align(
            alignment: Alignment.centerRight,
            child: Text(
              string,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        }).reversed.toList(),
      ),
    );
  }

}
