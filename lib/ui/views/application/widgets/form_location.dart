import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/views/application/application_viewmodel.dart';
import 'package:permit_user_app/ui/views/application/widgets/address_form_fields.dart';
import 'package:permit_user_app/ui/views/application/widgets/file_upload.dart';
import 'package:permit_user_app/ui/views/application/widgets/form_subtitle.dart';
import 'package:permit_user_app/ui/views/application/widgets/input_text_field.dart';

class LocationForm extends ViewModelWidget<ApplicationViewModel> {
  const LocationForm({super.key});

  @override
  Widget build(BuildContext context, ApplicationViewModel viewModel) {
    return SingleChildScrollView(
      child: Form(
        key: viewModel.locationFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const FormSubtitle(label: 'CONSTRUCTION ADDRESS PROPOSAL'),
            verticalSpaceSmall,
            AddressFormFields(
              countryInputController: viewModel.locationCountryController,
              stateInputController: viewModel.locationStateController,
              cityInputController: viewModel.locationCityController,
              streetInputController: viewModel.locationStreetController,
              zipCodeInputController: viewModel.locationZipCodeController,
              countryValidator: viewModel.validateLocationCountry,
              stateValidator: viewModel.validateLocationState,
              cityValidator: viewModel.validateLocationCity,
              streetValidator: viewModel.validateLocationStreet,
              zipCodeValidator: viewModel.validateLocationZipCode,
            ),
            verticalSpaceSmall,

            //
            Text(
              'Permit Type',
              style: ktsLabelRegular,
            ),
            verticalSpaceExtraSmall,
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: viewModel.defaultPermitType,
                  items: permitTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type, style: ktsSmallRegular),
                    );
                  }).toList(),
                  style: ktsSmallRegular.copyWith(color: Colors.black),
                  isExpanded: true,
                  onChanged: viewModel.changePermitType,
                ),
              ),
            ),
            verticalSpaceLarge,

            //
            const FormSubtitle(label: 'PROJECT INFORMATION'),
            verticalSpaceSmall,
            InputTextField(
              label: 'Description',
              maxLines: 5,
              controller: viewModel.projectDescriptionController,
              validator: viewModel.validateProjectDescription,
            ),
            verticalSpaceSmall,
            InputTextField(
              label: 'Cost of Construction',
              controller: viewModel.projectCostOfConstructionController,
              validator: viewModel.validateProjectCostOfConstruction,
              digitsOnly: true,
              keyboardType: TextInputType.number,
            ),
            verticalSpaceLarge,

            //
            Text(
              'CONSTRUCTION DOCUMENTS, PLANS OR SPECIFICATIONS',
              style: ktsSmallMedium,
            ),
            verticalSpaceSmall,
            FileUpload(
              onPickDocuments: viewModel.pickConstructionDocuments,
              documentPaths:
                  viewModel.constructionDocuments.map((e) => e.path).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
