import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class DigitTimeline extends StatelessWidget {
  final TimelineStepState currentStep;

  const DigitTimeline({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 312,
          decoration: const BoxDecoration(
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              currentStep == TimelineStepState.completed ? Container(
          width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const DigitColors().lightTextDisabled,
              borderRadius: BorderRadius.circular(50),
            ),
                child:  Icon(Icons.check_circle, color: const DigitColors().lightPrimaryOrange,),
          ): Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const DigitColors().lightTextDisabled,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const SizedBox(width: 16,),
               Column(
                children: [
                  const Text('Completed'),
                  const Text('18/02/2024'),
                  Container(height: 1, color: const DigitColors().lightGenericDivider, width: 40,),
                ],
              )
            ],
          )
        ),
        const SizedBox(height: 8,),
        Container(
          padding: const EdgeInsets.only(left: 40,),
          child: const Text('View Details'),
        )
      ],
    );
  }
}

enum TimelineStepState { completed, present, future }
