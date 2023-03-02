import 'package:flutter/cupertino.dart';

import 'Stack.dart';

abstract class Command {
  execute(myStack stack, String input);
}

abstract class Operator extends Command {
  apply(num val1, num val2);

  accept(myStack stack) => stack.length() >= 1;

  @override
  execute(stack, input) {
    stack.push(num.parse(input));
    final val1 = stack.pop();
    final val2 = stack.pop();
    if (val1 == null || val2 == null) return null;
    stack.push(apply(val1, val2));
  }
}

class Plus extends Operator {
  @override
  apply(num val1, num val2) => val1 + val2;
}

class Minus extends Operator {
  @override
  apply(num val1, num val2) => val2 - val1;
}

class Multiply extends Operator {
  @override
  apply(num val1, num val2) => val1 * val2;
}

class Divide extends Operator {
  @override
  apply(num val1, num val2) => val2 / val1;
}

class ClearCommand implements Command {
  @override
  execute(myStack stack, input) {
    stack.clear();
  }
}

class DeleteCommand implements Command {
  @override
  execute(myStack stack, input) {
    String val = input.substring(0, input.length - 1);
    if (val.isEmpty) return "0";
    return input.substring(0, input.length - 1);
  }
}

class EnterCommand implements Command {
  @override
  execute(myStack stack, String input) {
    stack.push(num.parse(input));
  }
}

class PopCommand implements Command {
  @override
  execute(myStack stack, input) {
    if (stack.length()>0) {
      return stack.pop().toString();
    }
  }
}

class CommaCommand implements Command {
  @override
  execute(myStack stack, input) {
    if (input.contains(".")) return input;
    return "$input.";
  }
}
