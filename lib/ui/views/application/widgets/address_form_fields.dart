import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/views/application/widgets/input_text_field.dart';

class AddressFormFields extends StatelessWidget {
  const AddressFormFields({
    super.key,
    required this.countryInputController,
    required this.stateInputController,
    required this.cityInputController,
    required this.streetInputController,
    required this.zipCodeInputController,
    required this.countryValidator,
    required this.stateValidator,
    required this.cityValidator,
    required this.streetValidator,
    required this.zipCodeValidator,
  });

  final TextEditingController countryInputController;
  final TextEditingController stateInputController;
  final TextEditingController cityInputController;
  final TextEditingController streetInputController;
  final TextEditingController zipCodeInputController;

  final String? Function(String?)? countryValidator;
  final String? Function(String?)? stateValidator;
  final String? Function(String?)? cityValidator;
  final String? Function(String?)? streetValidator;
  final String? Function(String?)? zipCodeValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTextField(
          label: 'Country',
          hint: 'Country',
          controller: countryInputController,
          validator: countryValidator,
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InputTextField(
                label: 'State',
                controller: stateInputController,
                validator: stateValidator,
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: InputTextField(
                label: 'City',
                controller: cityInputController,
                validator: cityValidator,
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        InputTextField(
          label: 'Street',
          hint: 'Street',
          controller: streetInputController,
          validator: streetValidator,
        ),
        verticalSpaceSmall,
        InputTextField(
          label: 'Zip Code',
          hint: 'Zip',
          controller: zipCodeInputController,
          validator: zipCodeValidator,
          digitsOnly: true,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
