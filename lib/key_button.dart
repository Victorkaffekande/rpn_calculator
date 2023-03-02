import 'package:flutter/material.dart';

enum KeyKind { number, operator }

class KeyButton extends StatelessWidget {

  const KeyButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind,
  });

  const KeyButton.number({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind = KeyKind.number,
  });

  const KeyButton.operator({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind = KeyKind.operator,
  });

  final VoidCallback onPressed;
  final String label;
  final KeyKind? kind;

  Color? backgroundColor(BuildContext context) {
    switch (kind) {
      case KeyKind.number:
        return Theme.of(context).focusColor;
      case KeyKind.operator:
        return Theme.of(context).hoverColor;
      default:
        return Theme.of(context).primaryColorDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor(context),
          ),
          onPressed: onPressed,
          child: Text(label, style: TextStyle(fontSize: 32)),
        ),
      ),
    );
  }
}
