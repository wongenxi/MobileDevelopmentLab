import 'package:flutter/material.dart';

class ActionBarWidget extends StatelessWidget {
  const ActionBarWidget({super.key});

  Widget _btn(BuildContext c, IconData icon, String label) {
    final color = Theme.of(c).colorScheme.primary;
    return InkWell(
      onTap: () => ScaffoldMessenger.of(c)
          .showSnackBar(SnackBar(content: Text('$label pressed'))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _btn(context, Icons.call, 'CALL'),
          _btn(context, Icons.near_me, 'ROUTE'),
          _btn(context, Icons.share, 'SHARE'),
        ],
      ),
    );
  }
}