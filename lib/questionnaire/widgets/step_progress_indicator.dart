import 'package:flutter/material.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({required this.currentStep, super.key});
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Line layer
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
        // Steps layer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStep(1, 'Applicant'),
            _buildStep(2, 'Contractor'),
            _buildStep(3, 'Location'),
            _buildStep(4, 'Consent'),
          ],
        ),
      ],
    );
  }

  Widget _buildStep(int step, String label) {
    final isActive = step == currentStep;
    final isCompleted = step < currentStep;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 32,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: isActive
                ? Colors.black
                : isCompleted
                    ? const Color(0xFF1A8449)
                    : Colors.grey[200],
            child: isCompleted
                ? const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.check,
                      color: Color(0xFF1A8449),
                      size: 15,
                    ),
                  )
                : Text(
                    step.toString(),
                    style: ktsMediumRegular.copyWith(
                      color: isActive ? Colors.white : Colors.black,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: ktsLabelRegular,
        ),
      ],
    );
  }
}
