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
  final Map<String, Operator> _operatorMap = {
    "+": Plus(),
    "-": MinusCommand(),
    "*": Multiply(),
    "/": Divide(),
  };

  final Map<String, Command> _commandMap = {
    "C": ClearCommand(),
    "del": DeleteCommand(),
    "Enter": EnterCommand(),
    "UndoFix": UndoCommand(),
    //TODO MÅSKE FORCEPOP
  };

  final myStack _stack = myStack();

  bool resat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RPN calculator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
          Row(
            children: _buildCommands(),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.count(
                        crossAxisCount: 3, children: _buildNumbers()),
                  ),
                ),
                Column(
                  children: _buildOperators(),
                ),
              ],
            ),
          ),
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
    //if (!resat) _stack.pop();
    var val;
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

  _resetInput() {
    resat = false;
    _stack.push(0);
  }

//TODO SPLIT COMMANDS I C,DEL ENTER FORPOP OG OPERATORS
  _buildOperators() {
    return List.generate(_operatorMap.length, (index) {
      var key = _operatorMap.keys.toList()[index];
      return ElevatedButton(
          onPressed: () {
            var operator = _operatorMap[key];
            if (operator?.accept(_stack)) {
              operator?.execute(_stack);
              resat = true;
            }
            setState(() {});
          },
          child: Text(key, style: Theme.of(context).textTheme.headlineSmall));
    });
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

  _buildCommands() {
    return List.generate(_commandMap.length, (index) {
      var key = _commandMap.keys.toList()[index];
      return Expanded(
        child: ElevatedButton(
          onPressed: () {
            var command = _commandMap[key];
            command?.execute(_stack);
            setState(() {});
          },
          child: Text(key),
        ),
      );
    });
  }
}
