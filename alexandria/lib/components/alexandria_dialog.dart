import 'package:flutter/material.dart';

class AlexandriaDialog extends StatelessWidget {
  const AlexandriaDialog({super.key, this.content, this.actions, this.title});
  final Widget? content;
  final List<Widget>? actions;
  final Widget? title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      content: content,
      actions: actions,
      title: title,
    );
  }
}
