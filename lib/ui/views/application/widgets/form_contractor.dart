import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_permit_user_app/ui/common/ui_helpers.dart';
import 'package:stacked_permit_user_app/ui/views/application/application_viewmodel.dart';
import 'package:stacked_permit_user_app/ui/views/application/widgets/address_form_fields.dart';
import 'package:stacked_permit_user_app/ui/views/application/widgets/file_upload.dart';
import 'package:stacked_permit_user_app/ui/views/application/widgets/form_subtitle.dart';
import 'package:stacked_permit_user_app/ui/views/application/widgets/input_text_field.dart';
import 'package:stacked_permit_user_app/ui/widgets/common/main_small_button/main_small_button.dart';

class ContractorForm extends ViewModelWidget<ApplicationViewModel> {
  const ContractorForm({super.key});

  @override
  Widget build(BuildContext context, ApplicationViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const FormSubtitle(label: 'CONTRACTOR'),
          // verticalSpaceSmall,
          // const InputTextField(
          //   hint: 'Jake Doe',
          //   showSuffixArrow: true,
          // ),
          // verticalSpaceSmall,
          // const InputTextField(
          //   hint: 'Mark Dela Cruz',
          //   showSuffixArrow: true,
          // ),
          verticalSpaceMedium,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: MainSmallButton(
              label: 'Add Contractor',
              onTap: () {},
              leadingIcon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          verticalSpaceLarge,

          //
          const FormSubtitle(label: 'CONTRACTOR INFORMATION'),
          verticalSpaceSmall,
          InputTextField(
            label: 'Company or Individual Name',
            controller: viewModel.contractorCompanyOrIndividualNameController,
            validator: viewModel.validateContractorCompanyOrIndividualName,
          ),
          verticalSpaceSmall,
          InputTextField(
            label: 'Applicable Trade(s)',
            controller: viewModel.contractorApplicableTradesController,
            validator: viewModel.validateContractorApplicableTrades,
          ),
          verticalSpaceSmall,
          InputTextField(
            label: 'Email',
            hint: 'ex. janedoe@gmail.com',
            controller: viewModel.contractorEmailController,
            validator: viewModel.validateContractorEmail,
          ),
          verticalSpaceSmall,
          InputTextField(
            label: 'Phone Number',
            hint: 'ex. 0973276418423',
            controller: viewModel.contractorPhoneNumberController,
            validator: viewModel.validateContractorPhoneNumber,
          ),
          verticalSpaceLarge,

          //
          const FormSubtitle(label: 'CONTRACTOR ADDRESS'),
          verticalSpaceSmall,
          AddressFormFields(
            countryInputController: viewModel.contractorCountryController,
            stateInputController: viewModel.contractorStateController,
            cityInputController: viewModel.contractorCityController,
            streetInputController: viewModel.contractorStreetController,
            zipCodeInputController: viewModel.contractorZipCodeController,
            countryValidator: viewModel.validateContractorCountry,
            stateValidator: viewModel.validateContractorState,
            cityValidator: viewModel.validateContractorCity,
            streetValidator: viewModel.validateContractorStreet,
            zipCodeValidator: viewModel.validateContractorZipCode,
          ),
          verticalSpaceLarge,

          //
          const FormSubtitle(label: 'CONTRACTOR LICENSE'),
          verticalSpaceSmall,
          FileUpload(
            onPickDocuments: viewModel.pickContractorLicenseDocuments,
            documentPaths: viewModel.contractorLicenseDocuments
                .map((e) => e.path)
                .toList(),
          ),
          verticalSpaceLarge,
        ],
      ),
    );
  }
}