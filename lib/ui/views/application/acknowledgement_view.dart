import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/widgets/common/main_small_button/main_small_button.dart';

class AcknowledgementView extends StatelessWidget {
  const AcknowledgementView({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(child: _buildTermsAgreement()),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 10,
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildNoButton(),
                    ),
                    horizontalSpaceSmall,
                    Expanded(
                      child: _buildSubmitButton(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAgreement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        verticalSpaceMedium,
        Text(
          'Acknowledgement',
          style: ktsExtraLargeSemiBold.copyWith(
            color: const Color(0xFF54595E),
          ),
          textAlign: TextAlign.center,
        ),
        verticalSpaceMedium,
        Text(
          '''
1. DECLARE UNDER PENALTY OF PERJURY that all information in this application are true and correct based on my personal knowledge and authentic records submitted.

To:  I declare to the best of my knowledge that all information submitted is accurate, truthful, and in compliance with applicable regulations and laws.

2. Please change: Any false or misleading information supplied or production of fake/falsified documents shall be grounds for appropriate legal action against me and automatically revokes the permit    to:  Any falsified documents or misleading information provided are subject to applicable regulations and laws which may result in permit revocation or potential civil penalties.  

3. Please change: Are you sure you want to submit your application  to: Ready to submit your application?
''',
          style: ktsSmallRegular.copyWith(
            color: const Color(0xFF54595E),
          ),
        ),
        verticalSpaceTiny,
        const Divider(thickness: 0.5, color: Color(0xFFD8D8D8)),
        verticalSpaceTiny,
        Text(
          'Ready to submit your application?',
          style: ktsSmallRegular.copyWith(
            color: const Color(0xFF54595E),
          ),
        ),
        verticalSpaceMassive,
      ],
    );
  }

  Widget _buildNoButton() {
    return MainSmallButton(
      label: 'NO',
      onTap: onCancel,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return MainSmallButton(
      label: 'YES, SUBMIT',
      onTap: onSubmit,
      backgroundColor: const Color(0xFF14BA6D),
    );
  }
}
