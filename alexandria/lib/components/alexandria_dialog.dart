import 'package:flutter/material.dart';

class AlexandriaDialog extends StatelessWidget {
  const AlexandriaDialog({super.key, this.content, this.actions});
  final Widget? content;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      content: content,
      actions: actions,
    );
  }
}
