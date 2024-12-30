import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/views/application/application_viewmodel.dart';
import 'package:permit_user_app/ui/views/application/widgets/address_form_fields.dart';
import 'package:permit_user_app/ui/views/application/widgets/file_upload.dart';
import 'package:permit_user_app/ui/views/application/widgets/form_subtitle.dart';
import 'package:permit_user_app/ui/views/application/widgets/input_text_field.dart';
import 'package:permit_user_app/ui/widgets/common/main_small_button/main_small_button.dart';

class ContractorForm extends ViewModelWidget<ApplicationViewModel> {
  const ContractorForm({super.key});

  @override
  Widget build(BuildContext context, ApplicationViewModel viewModel) {
    return SingleChildScrollView(
      child: Form(
        key: viewModel.contractorFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!viewModel.canShowContractorForm &&
                !viewModel.isEditingContractor) ...[
              FormSubtitle(
                  label: viewModel.contractors.length > 1
                      ? 'CONTRACTORS'
                      : 'CONTRACTOR'),
              if (viewModel.contractors.isEmpty) ...[
                verticalSpaceSmall,
                Text(
                  'No Contractors Added Yet',
                  style: ktsSmallRegular,
                ),
              ],
              if (viewModel.contractors.isNotEmpty) ...[
                verticalSpaceSmall,
                for (var contractor in viewModel.contractors) ...[
                  InputTextField(
                    controller: TextEditingController(),
                    validator: (p0) => null,
                    hint: contractor.individualName,
                    showSuffixArrow: true,
                    enabled: false,
                    onTap: () => viewModel.startEditingContractor(contractor),
                  ),
                  verticalSpaceSmall,
                ],
              ],
              verticalSpaceMedium,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: MainSmallButton(
                  label: 'Add Contractor',
                  onTap: viewModel.showContractorForm,
                  leadingIcon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              verticalSpaceLarge,
            ],

            //
            if (viewModel.canShowContractorForm ||
                viewModel.isEditingContractor) ...[
              FormSubtitle(
                label:
                    '${viewModel.isEditingContractor ? 'UPDATE' : 'ADD'} CONTRACTOR INFORMATION',
              ),
              verticalSpaceSmall,
              InputTextField(
                label: 'Company or Individual Name',
                controller:
                    viewModel.contractorCompanyOrIndividualNameController,
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
                keyboardType: TextInputType.emailAddress,
                errorText: viewModel.contractorEmailErrorText,
              ),
              verticalSpaceSmall,
              InputTextField(
                label: 'Phone Number',
                hint: 'ex. 0973276418423',
                controller: viewModel.contractorPhoneNumberController,
                validator: viewModel.validateContractorPhoneNumber,
                digitsOnly: true,
                keyboardType: TextInputType.number,
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
                onUploadButtonTap: () =>
                    viewModel.uploadContractorLicenseDocuments(
                  rebuildUIImmediately: true,
                ),
                onDocumentDeleteTap: (path) =>
                    viewModel.removeContractorDocument(path),
                areDocumentsUploaded:
                    viewModel.contractorLicenseDocumentIds.isNotEmpty,
              ),
            ],

            verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}
