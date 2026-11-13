// views/cruise_booking_screen.dart
import 'package:flutter/material.dart';
import '../viewmodels/cruise_booking_viewmodel.dart';
import 'widgets/header_image_widget.dart';
import 'widgets/title_section_widget.dart';
import 'widgets/action_bar_widget.dart';
import 'widgets/description_widget.dart';
import 'widgets/booking_controls_widget.dart';

class CruiseBookingScreen extends StatelessWidget {
  final CruiseBookingViewModel vm;
  const CruiseBookingScreen({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final d = vm.destination;

    final image = HeaderImageWidget(imagePath: d.imagePath, caption: d.imageCaption);
    final details = [
      TitleSectionWidget(vm: vm),
      const ActionBarWidget(),
      DescriptionWidget(text: d.description),
      BookingControlsWidget(vm: vm),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sibu River Cruise & Heritage')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // Figure 1: Portrait Layout (Single column ListView)
            return ListView(children: [image, ...details]);
          }
          // Figure 2: Landscape Layout (Left Pane: Header Image; Right Pane: Details)
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: HeaderImageWidget(
                  imagePath: d.imagePath,
                  caption: d.imageCaption,
                  height: double.infinity,
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView(children: details),
              ),
            ],
          );
        },
      ),
    );
  }
}