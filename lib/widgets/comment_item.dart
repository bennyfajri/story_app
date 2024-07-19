import 'package:flutter/material.dart';

import '../my_app.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.name,
    required this.description,
    required this.time,
  });
  final String name, description, time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(
            name.substring(0, 1),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge,
                    children: [
                      TextSpan(
                          text:
                          "$name "),
                      TextSpan(
                        text:
                        description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                    ]),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    time,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    appLocale.reply,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border,
            size: 16,
          ),
        ),
      ],
    );
  }
}