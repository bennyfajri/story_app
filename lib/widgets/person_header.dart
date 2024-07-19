import 'package:flutter/material.dart';

class PersonHeader extends StatelessWidget {
  const PersonHeader({
    super.key,
    required this.creatorName,
    this.isTrailing = false,
  });

  final String creatorName;
  final bool isTrailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(
            creatorName.substring(0, 1),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          creatorName,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        if (isTrailing) const Spacer(),
        if (isTrailing)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
      ],
    );
  }
}
