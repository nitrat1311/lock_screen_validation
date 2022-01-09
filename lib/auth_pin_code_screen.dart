import 'package:flutter/material.dart';
import 'package:lock_screen/create_pin_code_screen.dart';

class AuthPinCodeScreen extends StatefulWidget {
  const AuthPinCodeScreen({Key? key}) : super(key: key);

  @override
  _AuthPinCodeScreenState createState() => _AuthPinCodeScreenState();
}

class _AuthPinCodeScreenState extends State<AuthPinCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Validation'),
          centerTitle: true,
        ),
        body: const AuthPinCode());
  }
}

class AuthPinCode extends StatefulWidget {
  const AuthPinCode({Key? key}) : super(key: key);

  @override
  _AuthPinCodeState createState() => _AuthPinCodeState();
}

class _AuthPinCodeState extends State<AuthPinCode> {
  String strPin3 = '';

  final String _createPinText = 'Validate created PIN';

  int _pinIndex = 0;
  final List<String> _currentPin = ['', '', '', ''];
  final TextEditingController _pinOneController = TextEditingController();
  final TextEditingController _pinTwoController = TextEditingController();
  final TextEditingController _pinThreeController = TextEditingController();
  final TextEditingController _pinFourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: const Alignment(0, 0.5),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCreateTextMessege(),
                  const SizedBox(height: 40),
                  _buildPinRow(),
                ],
              ),
            ),
          ),
          _buildNumberPad(),
        ],
      ),
    );
  }

  _buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _KeyBoardNumber(
                      n: 1,
                      onPressed: () {
                        _pinIndexSetup('1');
                      }),
                  _KeyBoardNumber(
                      n: 2,
                      onPressed: () {
                        _pinIndexSetup('2');
                      }),
                  _KeyBoardNumber(
                      n: 3,
                      onPressed: () {
                        _pinIndexSetup('3');
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _KeyBoardNumber(
                      n: 4,
                      onPressed: () {
                        _pinIndexSetup('4');
                      }),
                  _KeyBoardNumber(
                      n: 5,
                      onPressed: () {
                        _pinIndexSetup('5');
                      }),
                  _KeyBoardNumber(
                      n: 6,
                      onPressed: () {
                        _pinIndexSetup('6');
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _KeyBoardNumber(
                      n: 7,
                      onPressed: () {
                        _pinIndexSetup('7');
                      }),
                  _KeyBoardNumber(
                      n: 8,
                      onPressed: () {
                        _pinIndexSetup('8');
                      }),
                  _KeyBoardNumber(
                      n: 9,
                      onPressed: () {
                        _pinIndexSetup('9');
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    width: 60,
                  ),
                  _KeyBoardNumber(
                      n: 0,
                      onPressed: () {
                        _pinIndexSetup('0');
                      }),
                  SizedBox(
                    width: 60,
                    child: MaterialButton(
                      onPressed: () {
                        _clearPin();
                      },
                      child: const Icon(Icons.backspace_outlined),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _pinIndexSetup(String text) async {
    if (_pinIndex == 0) {
      _pinIndex = 1;
    } else if (_pinIndex < 4) {
      _pinIndex++;
    }

    _setPin(_pinIndex, text);

    _currentPin[_pinIndex - 1] = text;
    String strPin3 = "";
    for (var element in _currentPin) {
      strPin3 += element;
    }

    if (_pinIndex == 4) {
      await Future.delayed(const Duration(milliseconds: 50), () {});
      setState(() {
        if (strPin3 == strPin2) {
          _showMyDialogSucsess(context);
        } else if (strPin3 != strPin2) {
          _showMyDialogFail(context);
        }
        _pinIndex = 0;
        _pinOneController.clear();
        _pinTwoController.clear();
        _pinThreeController.clear();
        _pinFourController.clear();
      });
    }
  }

  _clearPin() {
    if (_pinIndex == 0) {
      _pinIndex = 0;
    } else if (_pinIndex == 4) {
      _setPin(_pinIndex, '');
      _currentPin[_pinIndex - 1] = '';
      _pinIndex--;
    } else {
      _setPin(_pinIndex, '');
      _currentPin[_pinIndex - 1] = '';
      _pinIndex--;
    }
  }

  _setPin(int n, String text) {
    switch (n) {
      case 1:
        _pinOneController.text = text;
        break;
      case 2:
        _pinTwoController.text = text;
        break;
      case 3:
        _pinThreeController.text = text;
        break;
      case 4:
        _pinFourController.text = text;
        break;
    }
  }

  _buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _PinNumber(
          textEditingController: _pinOneController,
        ),
        _PinNumber(
          textEditingController: _pinTwoController,
        ),
        _PinNumber(
          textEditingController: _pinThreeController,
        ),
        _PinNumber(
          textEditingController: _pinFourController,
        ),
      ],
    );
  }

  _buildCreateTextMessege() {
    return Text(
      _createPinText,
      style: const TextStyle(
          color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
    );
  }
}

Future<void> _showMyDialogSucsess(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text("Your PIN code is valid"),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _showMyDialogFail(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text("Authentication failed"),
            ],
          ),
        ),
      );
    },
  );
}

class _KeyBoardNumber extends StatelessWidget {
  const _KeyBoardNumber({Key? key, required this.n, required this.onPressed})
      : super(key: key);
  final int n;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purpleAccent.withOpacity(0.1),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: const EdgeInsets.all(8.0),
        onPressed: onPressed,
        height: 90.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        child: Text(
          '$n',
          textAlign: TextAlign.center,
          style:
              TextStyle(fontSize: 24 * MediaQuery.of(context).textScaleFactor),
        ),
      ),
    );
  }
}

class _PinNumber extends StatelessWidget {
  const _PinNumber({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);
  final textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          filled: true,
          fillColor: Colors.white30,
        ),
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),
      ),
    );
  }
}
