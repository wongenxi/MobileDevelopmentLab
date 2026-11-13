import 'package:flutter/material.dart';
import '../../viewmodels/cruise_booking_viewmodel.dart';

class BookingControlsWidget extends StatelessWidget {
  final CruiseBookingViewModel vm;
  const BookingControlsWidget({super.key, required this.vm});

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: vm.visitDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) vm.setVisitDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          const ListTile(
            title: Text('Trip Preferences',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Visit Date'),
            trailing: Text(vm.formattedDate),
            onTap: () => _pickDate(context),
          ),
          ListTile(
            leading: const Icon(Icons.directions_boat),
            title: const Text('Cruise Package'),
            trailing: DropdownButton<String>(
              value: vm.selectedPackage,
              items: vm.packages
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) {
                if (v != null) vm.setPackage(v);
              },
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            value: vm.isDarkMode,
            onChanged: vm.setDarkMode,
          ),
        ],
      ),
    );
  }
}