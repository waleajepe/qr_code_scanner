import 'package:flutter/material.dart';
class TabView extends StatelessWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  ElevatedButton(
          onPressed: () {
            print("Button clicked");
            SnackBar(
              content: const Text('Yay! A SnackBar!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
          },
          child: Text('Hey Joe')),

    );
  }
}
