import 'package:flutter/material.dart';

class HeaderImageWidget extends StatelessWidget {
  final String imagePath;
  final String caption;
  final double? height;

  const HeaderImageWidget({
    super.key,
    required this.imagePath,
    required this.caption,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.blueGrey,
                child: const Center(
                  child: Icon(Icons.image, size: 60, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.black54,
            child: Text(caption, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}