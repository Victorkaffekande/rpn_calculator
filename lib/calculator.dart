import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rpn_calculator/Command.dart';
import 'package:rpn_calculator/Stack.dart';

class RPNCalculator extends StatefulWidget {
  const RPNCalculator({Key? key}) : super(key: key);

  @override
  State<RPNCalculator> createState() => _RPNCalculatorState();
}

class _RPNCalculatorState extends State<RPNCalculator> {
  final Map<String, Command> _commandMap = {
    "+": PlusCommand(),
    "-": MinusCommand(),
    "*": MultiplyCommand(),
    "/": DivideCommand(),
    "C": ClearCommand(),
    "del": DeleteCommand(),
    // "Enter": EnterCommand(),
    //TODO ENTER COMMAND
    //CLEAR
    //backspace
  };

  final myStack _stack = myStack();
  String _input = "";

  bool resat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RPN calculator")),
      body: Column(
        children: [
          _buildStackScroll(context),
          //input btns
          _buildControls(context),
        ],
      ),
    );
  }

  _buildControls(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child:
                  GridView.count(
                      crossAxisCount: 3, children: _buildNumbers()),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: _buildCommands(),
            ),
          )
        ],
      ),
    );
  }

  _buildNumbers() {
    var list = List.generate(10, (index) {
      if (index == 0) {
        return const Divider();
      }
      return ElevatedButton(
        onPressed: () {
          _updateInput(index);
        },
        child: Text(
          index.toString(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    });
    list = list.reversed.toList();
    //list.add(Divider());
    list.add(ElevatedButton(
        onPressed: () {
          _updateInput(0);
        },
        child: const Text("0")));
    return list;
  }

  _updateInput(int s) {
    if (!resat) _stack.pop();
    resat = false;
    _input += s.toString();
    _stack.push(num.parse(_input));
    setState(() {});
  }

  _resetInput() {
    _stack.push(0);
    _input = "0";
  }
//TODO SPLIT COMMANDS I C,DEL ENTER FORPOP OG OPERATORS
  _buildCommands() {
    var list = List.generate(_commandMap.length, (index) {
      var key = _commandMap.keys.toList()[index];
      return ElevatedButton(
          onPressed: () {
            var command = _commandMap[key];
            command?.execute(_stack);
            _input = "0";
            resat = true;
            setState(() {});
          },
          child: Text(key, style: Theme.of(context).textTheme.headlineSmall));
    });
    list.add(ElevatedButton(
        onPressed: () {
          _resetInput();
          setState(() {});
        },
        child: const Text("Enter")));
    return list;
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
