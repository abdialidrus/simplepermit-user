import 'package:flutter/material.dart';
import 'package:simple_permit_user/questionnaire/widgets/form_title_large.dart';
import 'package:simple_permit_user/questionnaire/widgets/input_text_field.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class ApplicantForm extends StatefulWidget {
  const ApplicantForm({super.key});

  @override
  State<ApplicantForm> createState() => _ApplicantFormState();
}

class _ApplicantFormState extends State<ApplicantForm> {
  int _selectedValue = 1;

  void setUserIndicatorValue(int? value) {
    if (value == null) return;
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const FormTitleLarge(
            title: "APPLICANT'S INFORMATION",
            subtitle:
                // ignore: lines_longer_than_80_chars
                'This process is crucial for securing the necessary approvals to proceed with construction legally and responsibly',
          ),
          const SizedBox(height: 48),
          Text(
            "APPLICANT'S INFORMATION",
            style: ktsSmallMedium,
          ),
          const SizedBox(height: 24),
          const InputTextField(
            label: 'Name',
            hint: 'Ex. Jane Doe',
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
          const SizedBox(height: 30),
          Text(
            'INDICATE IF YOU ARE:',
            style: ktsSmallMedium,
          ),
          const SizedBox(height: 10),
          _buildUserIndicatorGroup(_selectedValue),
          const SizedBox(height: 28),
          Text(
            'ADD NOTES:',
            style: ktsSmallMedium,
          ),
          const SizedBox(height: 24),
          const InputTextField(
            hint: 'Your Notes Here',
            maxLines: 5,
          ),
          const SizedBox(height: 44),
        ],
      ),
    );
  }

  Widget _buildUserIndicatorGroup(int groupValue) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        RadioListTile(
          value: 1,
          groupValue: groupValue,
          dense: true,
          title: Text(
            'Owner',
            style: ktsSmallRegular,
          ),
          onChanged: setUserIndicatorValue,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
        RadioListTile(
          value: 2,
          groupValue: groupValue,
          dense: true,
          title: Text(
            'Contractor',
            style: ktsSmallRegular,
          ),
          onChanged: setUserIndicatorValue,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
        RadioListTile(
          value: 3,
          dense: true,
          groupValue: groupValue,
          title: Text(
            'Respresentative',
            style: ktsSmallRegular,
          ),
          onChanged: setUserIndicatorValue,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}
