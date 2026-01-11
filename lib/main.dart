import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A0E21),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        useMaterial3: true,
      ),
      home: const BMICalculatorPage(),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({super.key});

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  bool isMale = true;
  double height = 170;
  int weight = 70;
  int age = 25;
  double? bmiResult;
  String? bmiCategory;
  Color? bmiColor;

  void calculateBMI() {
    double heightInMeters = height / 100;
    double bmi = weight / pow(heightInMeters, 2);

    setState(() {
      bmiResult = bmi;
      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
        bmiColor = Colors.blue;
      } else if (bmi < 25) {
        bmiCategory = 'Normal';
        bmiColor = Colors.green;
      } else if (bmi < 30) {
        bmiCategory = 'Overweight';
        bmiColor = Colors.orange;
      } else {
        bmiCategory = 'Obese';
        bmiColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI CALCULATOR',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Gender Selection
            Row(
              children: [
                Expanded(
                  child: GenderCard(
                    icon: Icons.male,
                    label: 'MALE',
                    isSelected: isMale,
                    onTap: () => setState(() => isMale = true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GenderCard(
                    icon: Icons.female,
                    label: 'FEMALE',
                    isSelected: !isMale,
                    onTap: () => setState(() => isMale = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Height Slider
            CustomCard(
              child: Column(
                children: [
                  const Text(
                    'HEIGHT',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        ' cm',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                  Slider(
                    value: height,
                    min: 100,
                    max: 220,
                    activeColor: const Color(0xFFEB1555),
                    inactiveColor: Colors.grey.shade800,
                    onChanged: (value) => setState(() => height = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Weight and Age
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    child: Column(
                      children: [
                        const Text(
                          'WEIGHT',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$weight',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'kg',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: Icons.remove,
                              onPressed: () {
                                if (weight > 1) {
                                  setState(() => weight--);
                                }
                              },
                            ),
                            const SizedBox(width: 16),
                            RoundIconButton(
                              icon: Icons.add,
                              onPressed: () => setState(() => weight++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomCard(
                    child: Column(
                      children: [
                        const Text(
                          'AGE',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$age',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'years',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: Icons.remove,
                              onPressed: () {
                                if (age > 1) {
                                  setState(() => age--);
                                }
                              },
                            ),
                            const SizedBox(width: 16),
                            RoundIconButton(
                              icon: Icons.add,
                              onPressed: () => setState(() => age++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Calculate Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEB1555),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CALCULATE BMI',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),

            // Result Section
            if (bmiResult != null) ...[
              const SizedBox(height: 24),
              CustomCard(
                child: Column(
                  children: [
                    const Text(
                      'YOUR RESULT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      bmiCategory!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: bmiColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bmiResult!.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getBMIDescription(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getBMIDescription() {
    if (bmiResult! < 18.5) {
      return 'You have a lower than normal body weight. Consider consulting a nutritionist.';
    } else if (bmiResult! < 25) {
      return 'You have a normal body weight. Keep up the good work!';
    } else if (bmiResult! < 30) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else {
      return 'You have a much higher than normal body weight. Consider consulting a doctor.';
    }
  }
}

// Custom Card Widget
class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

// Gender Selection Card
class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D1E33) : const Color(0xFF111328),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: const Color(0xFFEB1555), width: 2)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 72,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Round Button for increment/decrement
class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      constraints: const BoxConstraints.tightFor(width: 48, height: 48),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      child: Icon(icon, color: Colors.white),
    );
  }
}
