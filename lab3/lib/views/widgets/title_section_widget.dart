import 'package:flutter/material.dart';
import '../../viewmodels/cruise_booking_viewmodel.dart';

class TitleSectionWidget extends StatelessWidget {
  final CruiseBookingViewModel vm;
  const TitleSectionWidget({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final d = vm.destination;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(d.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(d.location, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          InkWell(
            onTap: vm.toggleStar,
            child: Row(
              children: [
                Icon(vm.isStarred ? Icons.star : Icons.star_border,
                    color: Colors.amber),
                const SizedBox(width: 4),
                Text('${vm.starCount}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}