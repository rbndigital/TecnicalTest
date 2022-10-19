import 'evaluator.dart';
import 'illegal_operation_exception.dart';

main() {
  MyArray sA = MyArray("Hello world");
  MyArray sB = MyArray("2 + 10 / 2 - 20");
  MyArray sC = MyArray("(2 + 10) / 2 - 20");
  MyArray sD = MyArray("(2 + 10 / 2 - 20");

  sA.operation(true);
  sB.operation(true);
  sC.operation(true);
  sD.operation(true);

  print("-------------------------------");

  sA.compute();
  sB.compute();
  sC.compute();
  sD.compute();
}

class MyArray {
  late String _text;

  MyArray(String text) {
    this._text = text;
  }

  get text => this._text;

  bool operation(bool showMsj) {
    try {
      Evaluator.evaluar(_text);
      if (showMsj) print('true');
      return true;
    } on IllegalOperationException {
      if (showMsj) print('false');
      return false;
    }
  }

  bool compute() {
    if (operation(false)) {
      print(Evaluator.evaluar(_text));
      return true;
    } else {
      print('false');
      return false;
    }
  }
}
