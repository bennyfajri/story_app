import 'package:flutter/material.dart';

class ErrorEmptyPage extends StatelessWidget {
  const ErrorEmptyPage({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.error_outline,
    this.iconSize = 30,
    required this.messageButton,
    required this.onPressed,
  });

  final String title;
  final String message;
  final String messageButton;
  final IconData icon;
  final double iconSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(message),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(messageButton),
            ),
          )
        ],
      ),
    );
  }
}
