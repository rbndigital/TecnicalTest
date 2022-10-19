import 'dart:math';
import 'stack.dart';

class Evaluator {
  static double evaluar(String infija) {
    List<String> posfija = _convertir(infija);
    return _evaluarPosfija(posfija);
  }

  static List<String> _convertir(String infija) {
    List<String> posfija = [];
    String letra = "";

    Stack<String> pila = Stack();
    List<String> list = [];

    for (int i = 0; i < infija.length; i++) {
      String letraUnic = "" + infija[i];

      if (letraUnic.codeUnitAt(0) >= 48 && letraUnic.codeUnitAt(0) <= 57) {
        letra += letraUnic;
      } else if (_esOperador(letraUnic)) {
        list.add(letra);
        list.add(letraUnic);
        letra = "";
      }
    }

    list.add(letra);

    for (int i = 0; i < list.length; i++) {
      letra = list[i];

      if (_esOperador(letra)) {
        if (pila.isEmpty) {
          pila.push(letra);
        } else {
          int pe = _prioridadEnExpresion(letra);
          int pp = _prioridadEnPila(pila.top());

          if (pe > pp) {
            pila.push(letra);
          } else {
            if (letra == ")") {
              while (pila.top() != "(") {
                posfija.add(pila.pop());
              }
              pila.pop();
            } else {
              posfija.add(pila.pop());
              pila.push(letra);
            }
          }
        }
      } else {
        posfija.add(letra);
      }
    }

    while (pila.isNotEmpty) {
      posfija.add(pila.pop());
    }
    return posfija;
  }

  static double _evaluarPosfija(List<String> posfija) {
    Stack<dynamic> pila = Stack();

    for (int i = 0; i < posfija.length; i++) {
      if (posfija[i] != "") {
        String letra = "" + posfija[i];
        if (!_esOperador(letra)) {
          double num = double.parse(letra + "");
          pila.push(num);
        } else {
          double num2 = pila.pop() as double;
          double num1 = pila.pop() as double;
          double num3 = _operacion(letra, num1, num2);

          pila.push(num3);
        }
      }
    }

    return pila.top() as double;
  }

  static bool _esOperador(String letra) {
    if (letra == "*" ||
        letra == "/" ||
        letra == "+" ||
        letra == "-" ||
        letra == "(" ||
        letra == ")" ||
        letra == "^") {
      return true;
    } else {
      return false;
    }
  }

  static int _prioridadEnExpresion(String operador) {
    if (operador == "^") {
      return 4;
    }
    if (operador == "*" || operador == "/") {
      return 2;
    }
    if (operador == "+" || operador == "-") {
      return 1;
    }
    if (operador == "(") {
      return 5;
    }
    return 0;
  }

  static int _prioridadEnPila(String operador) {
    if (operador == "^") {
      return 3;
    }
    if (operador == "*" || operador == "/") {
      return 2;
    }
    if (operador == "+" || operador == "-") {
      return 1;
    }
    if (operador == "(") {
      return 0;
    }
    return 0;
  }

  static double _operacion(String letra, double num1, double num2) {
    if (letra == "*") {
      return num1 * num2;
    }
    if (letra == "/") {
      return num1 / num2;
    }
    if (letra == "+") {
      return num1 + num2;
    }
    if (letra == "-") {
      return num1 - num2;
    }
    if (letra == "^") {
      return double.parse(pow(num1, num2).toString());
    }

    return 0;
  }
}
