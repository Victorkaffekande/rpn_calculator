import 'package:flutter/cupertino.dart';

import 'Stack.dart';

abstract class Command {
  execute(myStack stack);
}

class PlusCommand implements Command {
  @override
  execute(stack) {
    var a = stack.pop();
    var b = stack.pop();
    var result = a + b;
    stack.push(result);
  }
}

class MinusCommand implements Command {
  @override
  execute(stack) {
    var a = stack.pop();
    var b = stack.pop();
    var result = b - a;
    stack.push(result);
  }
}

class MultiplyCommand implements Command {
  @override
  execute(stack) {
    var a = stack.pop();
    var b = stack.pop();
    var result = a * b;
    stack.push(result);
  }
}

class DivideCommand implements Command {
  @override
  execute(stack) {
    var a = stack.pop();
    var b = stack.pop();
    var result = b / a;
    stack.push(result);
  }
}

class ClearCommand implements Command {
  @override
  execute(myStack stack) {
    stack.clear();
    stack.push(0);
  }
}

class DeleteCommand implements Command {
  @override
  execute(myStack stack) {
    String val = stack.pop().toString();
    String stringVal = val.substring(0, val.length - 1);
    if (stringVal.isEmpty) {
      stack.push(0);
    } else {
      stack.push(num.parse(stringVal));
    }
  }
}
/*
class EnterCommand implements Command{

  @override
  execute(myStack stack) {
    stack.push(1);
  }
}
*/
