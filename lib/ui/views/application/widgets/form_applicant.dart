import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_permit_user_app/ui/common/ui_helpers.dart';
import 'package:stacked_permit_user_app/ui/views/application/application_viewmodel.dart';
import 'package:stacked_permit_user_app/ui/views/application/widgets/address_form_fields.dart';
import 'package:stacked_permit_user_app/ui/views/application/widgets/form_subtitle.dart';
import 'package:stacked_permit_user_app/ui/views/application/widgets/input_text_field.dart';

class ApplicantForm extends ViewModelWidget<ApplicationViewModel> {
  const ApplicantForm({super.key});

  @override
  Widget build(BuildContext context, ApplicationViewModel viewModel) {
    return SingleChildScrollView(
      child: Form(
        key: viewModel.applicantFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const FormSubtitle(label: 'PERMIT APPLICANT INFORMATION'),
            verticalSpaceSmall,
            InputTextField(
              label: 'Name',
              hint: 'Ex. Jane Doe',
              controller: viewModel.applicantNameController,
              validator: viewModel.validateApplicantName,
            ),

            verticalSpaceLarge,
            const FormSubtitle(label: 'ADDRESS'),
            verticalSpaceSmall,
            AddressFormFields(
              countryInputController: viewModel.applicantCountryController,
              stateInputController: viewModel.applicantStateController,
              cityInputController: viewModel.applicantCityController,
              streetInputController: viewModel.applicantStreetController,
              zipCodeInputController: viewModel.applicantZipCodeController,
              countryValidator: viewModel.validateApplicantCountry,
              stateValidator: viewModel.validateApplicantState,
              cityValidator: viewModel.validateApplicantCity,
              streetValidator: viewModel.validateApplicantStreet,
              zipCodeValidator: viewModel.validateApplicantZipCode,
            ),

            //
            verticalSpaceMedium,
            InputTextField(
              label: 'Email',
              hint: 'ex. janedoe@gmail.com',
              controller: viewModel.applicantEmailController,
              validator: viewModel.validateApplicantEmail,
            ),
            verticalSpaceSmall,
            InputTextField(
              label: 'Phone Number',
              hint: 'ex. 0973276418423',
              controller: viewModel.applicantPhoneNumberController,
              validator: viewModel.validateApplicantPhoneNumber,
            ),
            verticalSpaceLarge,

            //
            const FormSubtitle(label: 'INFORMATION:'),
            verticalSpaceSmall,
            InputTextField(
              hint: 'Add Notes',
              maxLines: 5,
              controller: viewModel.applicantNotesController,
              validator: viewModel.validateApplicantNotes,
            ),
            verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}