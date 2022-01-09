import 'package:flutter/material.dart';

import 'package:lock_screen/create_pin_code_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main menu'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => {Navigator.pushNamed(context, '/1')},
                child: const Text('Create PIN code'),
              ),
              TextButton(
                onPressed: () => {
                  if (strPin2.isNotEmpty)
                    {
                      Navigator.pushNamed(context, '/1/2'),
                    },
                },
                child: const Text('Authentication by PIN code'),
              )
            ],
          )
        ],
      ),
    );
  }
}
