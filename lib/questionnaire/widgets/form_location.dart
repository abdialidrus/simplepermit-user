import 'package:flutter/material.dart';
import 'package:simple_permit_user/questionnaire/widgets/input_text_field.dart';
import 'package:simple_permit_user/questionnaire/widgets/upload_document_button.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class LocationForm extends StatelessWidget {
  const LocationForm({super.key});

  String _getRequirementsLabel(int index) {
    switch (index) {
      case 0:
        return 'REQUIREMENTS';
      case 1:
        return 'Floor Plans:';
      case 2:
        return 'Elevations:';
      case 3:
        return 'Sections:';
      case 4:
        return 'Roof Plan:';
      case 5:
        return 'Reflected Ceiling Plan:';
      case 6:
        return 'Schedule:';
      case 7:
        return 'Site Plan:';
      default:
        return 'Requirement ${index + 1}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'CONSTRUCTION ADDRESS PROPOSAL',
            style: ktsSmallMedium,
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InputTextField(
                  label: 'State',
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: InputTextField(
                  label: 'City',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const InputTextField(
            label: 'Country',
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InputTextField(
                  label: 'Zip Code',
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: InputTextField(
                  label: 'Street',
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'CONSTRUCTION INFORMATION',
            style: ktsSmallMedium,
          ),
          const SizedBox(height: 24),
          const InputTextField(
            label: 'Description',
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          const InputTextField(
            label: 'Total Estimated Cost',
          ),
          const SizedBox(height: 30),
          ColoredBox(
            color: const Color(0xFFFCFCFD),
            child: ListView.separated(
              itemCount: 8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      _getRequirementsLabel(index),
                      style: index == 0
                          ? ktsLabelMedium.copyWith(
                              color: const Color(0xFF667085),
                            )
                          : ktsSmallRegular.copyWith(
                              color: const Color(0xFF667085),
                            ),
                    ),
                  ),
                  Expanded(
                    child: index == 0
                        ? Text(
                            'DOCUMENTS',
                            style: ktsLabelMedium.copyWith(
                              color: const Color(0xFF667085),
                            ),
                            textAlign: TextAlign.center,
                          )
                        : const UploadDocumentButton(),
                  ),
                ],
              ),
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xFFEAECF0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
