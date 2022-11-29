import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPress;

  const ActionButton({super.key, this.child, this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
          key: const Key("loginBtn"), onPressed: onPress, child: child),
    );
  }
}
