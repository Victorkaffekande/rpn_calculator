import 'package:flutter/cupertino.dart';

import 'Stack.dart';

abstract class Command {
  execute(myStack stack);
}

abstract class Operator extends Command {
  apply(num val1, num val2);

  accept(myStack stack) => stack.length() > 1;

  @override
  execute(stack) {
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

class EnterCommand implements Command {
  @override
  execute(myStack stack) {
    stack.push(0);
  }
}

class UndoCommand implements Command {
  @override
  execute(myStack stack) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}

class PopCommand implements Command {
  @override
  execute(myStack stack) {
    stack.pop();
    if (stack.length() < 1) {
      stack.push(0);
    }
  }
}

class CommaCommand implements Command {
  @override
  execute(myStack stack) {
    var val = stack.peek().toString();
    if (val.contains(".")) return null;
    var valString = "$val.";
    stack.pop();
    stack.push(num.parse(valString));
  }
}
