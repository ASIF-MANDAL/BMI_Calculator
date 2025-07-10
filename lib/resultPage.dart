

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  final double heightCm;
  final double weightKg;
  final String gender;

  const ResultPage({
    Key? key,
    required this.bmi,
    required this.heightCm,
    required this.weightKg,
    required this.gender,
  }) : super(key: key);

  /// Simple BMI interpretation
  String get bmiCategory {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25)   return 'Normal';
    if (bmi < 30)   return 'Overweight';
    return 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE14434),
        title: const Text(
          'BMI Result',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _infoTile('Gender', gender),
            _infoTile('Height', '${heightCm.toStringAsFixed(1)} cm'
                ' (${(heightCm / 100).toStringAsFixed(2)} m)'),
            _infoTile('Weight', '${weightKg.toStringAsFixed(1)} kg'),
            SizedBox(height: 24.sp),
            _resultCard(),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // go back
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE14434),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Re‑Calculate',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Helpers ---------------------------------------------------

  Widget _infoTile(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ),
  );

  Widget _resultCard() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          blurRadius: 6,
          offset: const Offset(0, 3),
          color: Colors.black12,
        )
      ],
    ),
    child: Column(
      children: [
        Text(
          bmi.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          bmiCategory,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: _categoryColor(),
          ),
        ),
      ],
    ),
  );

  Color _categoryColor() {
    switch (bmiCategory) {
      case 'Underweight':
        return Colors.orange;
      case 'Normal':
        return Colors.green;
      case 'Overweight':
        return Colors.deepOrange;
      default: // Obese
        return Colors.red;
    }
  }
}
