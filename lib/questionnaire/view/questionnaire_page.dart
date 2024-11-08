import 'package:flutter/material.dart';
import 'package:simple_permit_user/questionnaire/widgets/form_applicant.dart';
import 'package:simple_permit_user/questionnaire/widgets/form_consent.dart';
import 'package:simple_permit_user/questionnaire/widgets/form_contractor.dart';
import 'package:simple_permit_user/questionnaire/widgets/form_location.dart';
import 'package:simple_permit_user/questionnaire/widgets/next_button.dart';
import 'package:simple_permit_user/questionnaire/widgets/previous_button.dart';
import 'package:simple_permit_user/questionnaire/widgets/step_progress_indicator.dart';
import 'package:simple_permit_user/questionnaire/widgets/submit_button.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _currentStep = 1;

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    setState(() {
      _currentStep--;
    });
  }

  bool _isLastStep() {
    return _currentStep == 4;
  }

  Widget _getCurrentForm() {
    switch (_currentStep) {
      case 1:
        return const ApplicantForm();
      case 2:
        return const ContractorForm();
      case 3:
        return const LocationForm();
      case 4:
        return const ConsentForm();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Applicant/Owner',
          style: ktsMediumSemiBold,
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: StepProgressIndicator(currentStep: _currentStep),
          ),
          const SizedBox(height: 38),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _getCurrentForm(),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: SafeArea(
                child: Row(
                  children: [
                    if (_currentStep > 1) ...[
                      Expanded(
                        child: PreviousButton(
                          enabled: true,
                          onTap: _previousStep,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: _isLastStep()
                          ? SubmitButton(
                              enabled: true,
                              onTap: () {},
                            )
                          : NextButton(
                              enabled: true,
                              onTap: _nextStep,
                            ),
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
}
