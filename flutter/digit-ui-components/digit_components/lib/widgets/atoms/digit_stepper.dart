import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const CustomStepper({
    Key? key,
    required this.currentStep,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(steps.length, (index) {
          return _buildStep(index);
        }),
      ),
    );
  }

  Widget _buildStep(int index) {
    final bool isActive = index == currentStep;
    final bool isCompleted = index < currentStep;

    return Expanded(
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? Colors.green : (isActive ? Colors.blue : Colors.grey),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (index < steps.length - 1)
            Expanded(
              child: Divider(
                color: isCompleted ? Colors.green : (isActive ? Colors.blue : Colors.grey),
                thickness: 2.0,
              ),
            ),
        ],
      ),
    );
  }
}