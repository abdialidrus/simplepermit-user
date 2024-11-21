import 'package:flutter/material.dart';
import 'package:stacked_permit_user_app/ui/common/app_typography.dart';

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
                  color: const Color(0xFFE2E8F0),
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
            _buildStep(4, 'Community'),
            _buildStep(5, 'User Terms'),
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
                    ? const Color(0xFFEBFFF4)
                    : const Color(0xFFE2E8F0),
            child: isCompleted
                ? CircleAvatar(
                    radius: 14,
                    backgroundColor: const Color(0xFF1A8449),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: const Color(0xFFEBFFF4),
                      child: Image.asset(
                        'assets/icons/check.png',
                        height: 12,
                        width: 12,
                      ),
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
