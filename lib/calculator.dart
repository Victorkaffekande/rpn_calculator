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
    "CA": ClearCommand(),
    "<=": DeleteCommand(),
    "Enter": EnterCommand(),
    "Comma": CommaCommand(),
    "Pop": PopCommand()
  };

  final myStack _stack = myStack();
  String _input = "0"; // starting value
  bool newLine = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RPN calculator"),centerTitle: true,backgroundColor: Theme.of(context).primaryColor,),
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
                for (final str in ["CA", "<=", "Pop"])
                  KeyButton.operator(
                      onPressed: () => _handleCommand(str), label: str),
                KeyButton.operator(
                    onPressed: () => _handleOperator("/"), label: "/")
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final str in ['7', '8', '9'])
                  KeyButton.number(
                    onPressed: () => _updateInput(str),
                    label: str,
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
                for (final str in ['4', '5', '6'])
                  KeyButton.number(
                    onPressed: () => _updateInput(str),
                    label: str,
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
                for (final str in ['1', '2', '3'])
                  KeyButton.number(
                    onPressed: () => _updateInput(str),
                    label: str,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KeyButton.number(
                        onPressed: () => _updateInput("0"), label: "0"),
                    KeyButton.operator(
                        onPressed: () => _handleCommand("Comma"), label: "."),
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
    var val = com?.execute(_stack, _input);
    _input = val ?? "0";
    newLine = false;
    setState(() {});
  }

  _handleOperator(String string) {
    var op = _operatorMap[string];
    if (op?.accept(_stack)) {
      op?.execute(_stack, _input);
      newLine = true;
      _input = _stack.pop().toString();
    }
    setState(() {});
  }

  _updateInput(String s) {
    if (newLine) {
      _stack.push(num.parse(_input));
      _input = s;
      newLine = false;
    } else {
      if (_input == "0") {
        _input = "";
      }
      _input += s.toString();
    }
    setState(() {});
  }

  _buildStackScroll(BuildContext context) {
    var list = [
          Align(
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Text(_input, style: const TextStyle(fontSize: 60))),
          )
        ] +
        List.generate(_stack.length(), (index) {
          String string = _stack.getStack().toList()[index].toString();
          return Align(
            alignment: Alignment.centerRight,
            child: Text(
              string,
              style: const TextStyle(fontSize: 35),
            ),
          );
        }).reversed.toList();

    return Expanded(
      child: ListView(
        reverse: true,
        scrollDirection: Axis.vertical,
        children: list,
      ),
    );
  }
}
