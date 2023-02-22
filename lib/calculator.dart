import 'package:flutter/material.dart';
import 'package:rpn_calculator/valueButton.dart';

class RPNCalculator extends StatefulWidget {
  const RPNCalculator({Key? key}) : super(key: key);

  @override
  State<RPNCalculator> createState() => _RPNCalculatorState();
}

class _RPNCalculatorState extends State<RPNCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RPN calculator")),
      body: Column(
        children: [
          //show stack scroll
          //input btns
          _buildControls(context),
        ],
      ),
    );
  }

  _buildControls(BuildContext context) {
    return Expanded(
      child: GridView.count(
        reverse: true,
        crossAxisCount: 3, children:
        _buildNumbers()
      ),
    );
  }

  _buildOperators() {
    return Center(
      child: Text("asdad"),
    );
  }

  _buildNumbers() {
    return List.generate(10, (index) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            print(index);
          },
          child: Text(
            index.toString(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      );
    });
  }
}
