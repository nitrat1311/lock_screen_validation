import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

String strPin2 = '';

class CreatePinCodeScreen extends StatefulWidget {
  const CreatePinCodeScreen({Key? key}) : super(key: key);

  @override
  _CreatePinCodeScreenState createState() => _CreatePinCodeScreenState();
}

class _CreatePinCodeScreenState extends State<CreatePinCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup PIN'),
        centerTitle: true,
      ),
      body: const PinCodeScreen(),
    );
  }
}

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String createPinText = 'Create PIN';
  String reEnterPinText = 'Re-enter your PIN';

  int pinIndex = 0;
  List<String> currentPin = ['', '', '', ''];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.transparent),
  );

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
                  buildCreateTextMessege(),
                  const SizedBox(height: 40),
                  buildPinRow(),
                ],
              ),
            ),
          ),
          buildNumberPad(),
        ],
      ),
    );
  }

  buildNumberPad() {
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
                        pinIndexSetup('1');
                      }),
                  _KeyBoardNumber(
                      n: 2,
                      onPressed: () {
                        pinIndexSetup('2');
                      }),
                  _KeyBoardNumber(
                      n: 3,
                      onPressed: () {
                        pinIndexSetup('3');
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _KeyBoardNumber(
                      n: 4,
                      onPressed: () {
                        pinIndexSetup('4');
                      }),
                  _KeyBoardNumber(
                      n: 5,
                      onPressed: () {
                        pinIndexSetup('5');
                      }),
                  _KeyBoardNumber(
                      n: 6,
                      onPressed: () {
                        pinIndexSetup('6');
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _KeyBoardNumber(
                      n: 7,
                      onPressed: () {
                        pinIndexSetup('7');
                      }),
                  _KeyBoardNumber(
                      n: 8,
                      onPressed: () {
                        pinIndexSetup('8');
                      }),
                  _KeyBoardNumber(
                      n: 9,
                      onPressed: () {
                        pinIndexSetup('9');
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
                        pinIndexSetup('0');
                      }),
                  SizedBox(
                    width: 60,
                    child: MaterialButton(
                      onPressed: () {
                        clearPin();
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

  pinIndexSetup(String text) async {
    if (pinIndex == 0) {
      pinIndex = 1;
    } else if (pinIndex < 4) {
      pinIndex++;
    }

    setPin(pinIndex, text);

    currentPin[pinIndex - 1] = text;
    String strPin1 = "";
    for (var element in currentPin) {
      strPin1 += element;
    }

    if (pinIndex == 4) {
      print(strPin1);
      await Future.delayed(const Duration(milliseconds: 50), () {});
      setState(() {
        // print(strPin1);

        createPinText = reEnterPinText;
        if (strPin2.isEmpty) {
          strPin2 = strPin1;
        } else if (strPin1 == strPin2 && strPin2.isNotEmpty) {
          _showMyDialogSucsess(context);
        } else if (strPin1 != strPin2 && strPin2.isNotEmpty) {
          _showMyDialogFail(context);
        }

        pinIndex = 0;
        pinOneController.clear();
        pinTwoController.clear();
        pinThreeController.clear();
        pinFourController.clear();
      });
    }
  }

  clearPin() {
    if (pinIndex == 0) {
      pinIndex = 0;
    } else if (pinIndex == 4) {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    } else {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _PinNumber(
          textEditingController: pinOneController,
        ),
        _PinNumber(
          textEditingController: pinTwoController,
        ),
        _PinNumber(
          textEditingController: pinThreeController,
        ),
        _PinNumber(
          textEditingController: pinFourController,
        ),
      ],
    );
  }

  buildCreateTextMessege() {
    return Text(
      createPinText,
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
              Text("Your PIN code is successfully created"),
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
              Text("Your PIN  is not the same"),
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
