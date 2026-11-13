// viewmodels/cruise_booking_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/cruise_destination.dart';

class CruiseBookingViewModel extends ChangeNotifier {
  final CruiseDestination destination = const CruiseDestination(
    name: 'Rajang River Express Cruise',
    location: 'Sibu Waterfront, Sarawak',
    description:
    'Experience the heart of Sibu along Malaysia\'s longest river, the Rajang. '
        'Cruise past historic temples, timber hubs, and waterfront settlements.',
    imagePath: 'images/2794371.webp',
    imageCaption: 'Sibu Esplanade Landmark',
    initialStars: 42,
  );

  final List<String> packages = const [
    'Private River Cruise',
    'Sunset Cruise',
    'Sunrise Cruise',
    'Rural Cruise',
    'SMI Park Cruise',
  ];

  late int _starCount = destination.initialStars;
  bool _isStarred = false;
  DateTime _visitDate = DateTime.now();
  String _selectedPackage = 'Private River Cruise';
  bool _isDarkMode = false;

  int get starCount => _starCount;
  bool get isStarred => _isStarred;
  DateTime get visitDate => _visitDate;
  String get selectedPackage => _selectedPackage;
  bool get isDarkMode => _isDarkMode;

  String get formattedDate =>
      '${_visitDate.day.toString().padLeft(2, '0')}/'
          '${_visitDate.month.toString().padLeft(2, '0')}/'
          '${_visitDate.year}';

  void toggleStar() {
    _isStarred = !_isStarred;
    _starCount += _isStarred ? 1 : -1;
    notifyListeners();            // 通知 View 刷新
  }

  void setVisitDate(DateTime d) {
    _visitDate = d;
    notifyListeners();
  }

  void setPackage(String p) {
    _selectedPackage = p;
    notifyListeners();
  }

  void setDarkMode(bool v) {
    _isDarkMode = v;
    notifyListeners();
  }
}