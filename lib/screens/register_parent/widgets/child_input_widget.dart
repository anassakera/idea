import 'package:flutter/material.dart';

class ChildInputWidget extends StatefulWidget {
  final Function(String) onAdd;

  const ChildInputWidget({super.key, required this.onAdd});

  @override
  State<ChildInputWidget> createState() => _ChildInputWidgetState();
}

class _ChildInputWidgetState extends State<ChildInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Child Email or Code',
              prefixIcon: const Icon(Icons.child_care),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            widget.onAdd(_controller.text);
            _controller.clear();
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
