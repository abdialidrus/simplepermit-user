import 'package:flutter/material.dart';
import 'package:simple_permit_user/questionnaire/widgets/form_title_large.dart';
import 'package:simple_permit_user/questionnaire/widgets/input_text_field.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class ContractorForm extends StatelessWidget {
  const ContractorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const FormTitleLarge(
            title: 'CONTRACTOR’S INFORMATION',
            subtitle:
                // ignore: lines_longer_than_80_chars
                'This process is crucial for securing the necessary approvals to proceed with construction legally and responsibly',
          ),
          const SizedBox(height: 48),
          Text(
            'CONTRACTOR’S INFORMATION',
            style: ktsSmallMedium,
          ),
          const SizedBox(height: 24),
          const InputTextField(
            label: 'Trade',
          ),
          const SizedBox(height: 24),
          const InputTextField(
            label: 'Name',
            hint: 'ex. Jane Doe',
          ),
          const SizedBox(height: 24),
          const InputTextField(
            label: 'Email',
            hint: 'ex. janedoe@gmail.com',
          ),
          const SizedBox(height: 24),
          const InputTextField(
            label: 'Phone Number',
            hint: 'ex. 0973276418423',
          ),
          const SizedBox(height: 30),
          Text(
            'CONTRACTOR’S ADDRESS',
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
                  hint: 'Zip',
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: InputTextField(
                  label: 'Street',
                  hint: 'Street',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
