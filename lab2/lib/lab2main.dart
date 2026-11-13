import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  String _selectedHouse = 'Tourist';
  final List<String> _houses = ['Tourist', 'Researcher', 'Photographer', 'Local'];

  // 1) Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // 2) Cupertino Date Picker (底部弹出)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate,
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
          },
        ),
      ),
    );
  }

  // 4) Cupertino Wheel Picker (底部弹出)
  void _showCupertinoHousePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          scrollController: FixedExtentScrollController(
            initialItem: _houses.indexOf(_selectedHouse),
          ),
          onSelectedItemChanged: (int index) {
            setState(() => _selectedHouse = _houses[index]);
          },
          children: _houses.map((h) => Center(child: Text(h))).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pickers = PickerSection(
      selectedDate: _selectedDate,
      selectedHouse: _selectedHouse,
      houses: _houses,
      onMaterialDate: () => _selectMaterialDate(context),
      onCupertinoDate: () => _showCupertinoDatePicker(context),
      onCupertinoHouse: () => _showCupertinoHousePicker(context),
      // 3) Material DropdownButton 的回调
      onDropdownChanged: (String? v) {
        if (v != null) setState(() => _selectedHouse = v);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView(pickers)
              : _buildLandscapeView(pickers);
        },
      ),
    );
  }

  // 竖屏：全部垂直堆叠
  Widget _buildPortraitView(Widget pickers) {
    return ListView(
      children: [
        const StudentDetailsSection(),
        const TitleSection(
          name: 'Niah Caves National Park',
          location: 'Miri, Sarawak, Malaysia',
          starCount: 4.4,
        ),
        const ImageSection(imagePath: 'assets/images/hogwarts.jpg'),
        pickers,
      ],
    );
  }

  // 横屏：左右并排
  Widget _buildLandscapeView(Widget pickers) {
    return Row(
      children: [
        const Expanded(
          child: SingleChildScrollView(child: StudentDetailsSection()),
        ),
        Expanded(
          child: ListView(
            children: [
              const TitleSection(
                name: 'Niah Caves National Park',
                location: 'Miri, Sarawak, Malaysia',
                starCount: 4.4,
              ),
              const ImageSection(imagePath: 'assets/images/hogwarts.jpg'),
              pickers,
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------- 子 Widget 1：学生资料卡 ----------------
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(height: 12),
            Text(
              'WONG EN XI',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            Text('Student ID: BCS24020045'),
            Divider(height: 24),
            Text('Personal Life Goal / Quote:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(
              '"Teacher"', // ← 改成你自己的
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.indigo),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- 子 Widget 2：TitleSection（实验给的代码） ----------------
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final double starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(location, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}

// ---------------- 子 Widget 3：图片 ----------------
class ImageSection extends StatelessWidget {
  final String imagePath;
  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(imagePath, height: 220, fit: BoxFit.cover),
      ),
    );
  }
}

// ---------------- 子 Widget 4：四个 Picker ----------------
class PickerSection extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedHouse;
  final List<String> houses;
  final VoidCallback onMaterialDate;
  final VoidCallback onCupertinoDate;
  final VoidCallback onCupertinoHouse;
  final ValueChanged<String?> onDropdownChanged;

  const PickerSection({
    super.key,
    required this.selectedDate,
    required this.selectedHouse,
    required this.houses,
    required this.onMaterialDate,
    required this.onCupertinoDate,
    required this.onCupertinoHouse,
    required this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Interactive Pickers (Lab 2.2)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(),
            Text('Selected Date: ${selectedDate.toString().split(' ')[0]}'),
            Text('Selected Visitor: $selectedHouse',
                style: const TextStyle(color: Colors.indigo)),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onMaterialDate,
              icon: const Icon(Icons.calendar_today),
              label: const Text('Material Date Picker'),
            ),
            OutlinedButton.icon(
              onPressed: onCupertinoDate,
              icon: const Icon(CupertinoIcons.calendar),
              label: const Text('Cupertino Date Picker (Modal Sheet)'),
            ),
            Row(
              children: [
                const Text('Material Dropdown: '),
                DropdownButton<String>(
                  value: selectedHouse,
                  items: houses
                      .map((h) => DropdownMenuItem<String>(value: h, child: Text(h)))
                      .toList(),
                  onChanged: onDropdownChanged,
                ),
              ],
            ),
            OutlinedButton.icon(
              onPressed: onCupertinoHouse,
              icon: const Icon(Icons.sort),
              label: const Text('Cupertino Visitor Wheel Picker'),
            ),
          ],
        ),
      ),
    );
  }
}