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
/*
class EnterCommand implements Command{

  @override
  execute(myStack stack) {
    stack.push(1);
  }
}
*/