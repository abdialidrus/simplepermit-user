import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_permit_user_app/app/app.locator.dart';
import 'package:stacked_permit_user_app/app/app.logger.dart';
import 'package:stacked_permit_user_app/app/app.router.dart';
import 'package:stacked_permit_user_app/models/applicant_model.dart';
import 'package:stacked_permit_user_app/models/application_model.dart';
import 'package:stacked_permit_user_app/models/contractor_model.dart';
import 'package:stacked_permit_user_app/models/location_model.dart';
import 'package:stacked_permit_user_app/services/application_service.dart';
import 'package:stacked_services/stacked_services.dart';

enum ApplicationStatus { collecting, loading, submitted }

extension ApplicationStatusX on ApplicationStatus {
  bool get isLoading => this == ApplicationStatus.loading;
}

class ApplicationViewModel extends BaseViewModel {
  final log = getLogger('ApplicationViewModel');
  final _applicationService = locator<ApplicationService>();
  final _navigationService = locator<NavigationService>();

  final applicantFormKey = GlobalKey<FormState>();
  final applicantNameController = TextEditingController();
  final applicantCountryController = TextEditingController();
  final applicantStateController = TextEditingController();
  final applicantCityController = TextEditingController();
  final applicantStreetController = TextEditingController();
  final applicantZipCodeController = TextEditingController();
  final applicantEmailController = TextEditingController();
  final applicantPhoneNumberController = TextEditingController();
  final applicantNotesController = TextEditingController();

  //
  final contractorCompanyOrIndividualNameController = TextEditingController();
  final contractorApplicableTradesController = TextEditingController();
  final contractorEmailController = TextEditingController();
  final contractorPhoneNumberController = TextEditingController();
  final contractorCountryController = TextEditingController();
  final contractorStateController = TextEditingController();
  final contractorCityController = TextEditingController();
  final contractorStreetController = TextEditingController();
  final contractorZipCodeController = TextEditingController();

  //
  final locationFormKey = GlobalKey<FormState>();
  final locationCountryController = TextEditingController();
  final locationStateController = TextEditingController();
  final locationCityController = TextEditingController();
  final locationStreetController = TextEditingController();
  final locationZipCodeController = TextEditingController();
  //
  final projectDescriptionController = TextEditingController();
  final projectCostOfConstructionController = TextEditingController();

  //
  int selectedCommunity = 1;
  int activeStep = 1;
  bool get isLastStep => activeStep == 5;
  ApplicationStatus status = ApplicationStatus.collecting;

  //
  List<File> contractorLicenseDocuments = [];
  List<File> constructionDocuments = [];
  List<int> contractorLicenseDocumentIds = [];
  List<int> constructionDocumentIds = [];

  //
  bool isShowAcknowledgement = false;
  bool isApplicationSubmitted = false;

  void onViewModelReady() {}

  bool canPopBack() {
    bool isOnFirstStep = activeStep == 1;
    bool isConfirming = isShowAcknowledgement;
    bool isFinished = isApplicationSubmitted;

    if (isFinished) {
      return true;
    }

    if (isConfirming) {
      isShowAcknowledgement = false;
      rebuildUi();
      return false;
    }

    if (!isOnFirstStep) {
      previousStep();
    }

    return isOnFirstStep;
  }

  void navigateBack() {
    _navigationService.back();
  }

  void onCommunitySelectionChanged(int? value) {
    selectedCommunity = value ?? 1;
    rebuildUi();
  }

  void nextStep() async {
    if (activeStep == 1) {
      if (!isApplicantFormValid()) {
        return;
      }
    }

    // if (activeStep == 2) {
    //   await uploadContractorLicenseDocuments();
    // }

    if (activeStep == 3) {
      if (!isLocationFormValid()) {
        return;
      }

      if (constructionDocuments.isEmpty) {
        SmartDialog.showNotify(
          msg: 'Please upload at least one construction documents',
          notifyType: NotifyType.alert,
        );
        return;
      }

      if (await uploadConstructionDocuments() == false) {
        SmartDialog.showNotify(
          msg: 'Failed to upload documents. Please try again',
          notifyType: NotifyType.error,
        );
        return;
      }
    }

    activeStep++;
    rebuildUi();
  }

  void previousStep() {
    activeStep--;
    rebuildUi();
  }

  void pickContractorLicenseDocuments() async {
    final List<File>? result = await _pickDocuments();

    if (result != null) {
      contractorLicenseDocumentIds.clear();
      contractorLicenseDocuments.clear();
      contractorLicenseDocuments.addAll(result);
      rebuildUi();
    }
  }

  void pickConstructionDocuments() async {
    final List<File>? result = await _pickDocuments();

    if (result != null) {
      constructionDocumentIds.clear();
      constructionDocuments.clear();
      constructionDocuments.addAll(result);
      rebuildUi();
    }
  }

  Future<List<File>?> _pickDocuments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    }

    return null;
  }

  Future<bool> uploadContractorLicenseDocuments() async {
    if (contractorLicenseDocuments.isEmpty) {
      return false;
    }

    if (contractorLicenseDocumentIds.isNotEmpty) {
      return true;
    }

    try {
      SmartDialog.showLoading(
        msg: 'Uploading documents',
      );

      final List<int> documentIds =
          await _applicationService.uploadDocuments(contractorLicenseDocuments);

      SmartDialog.dismiss();

      contractorLicenseDocuments.clear();
      contractorLicenseDocumentIds.addAll(documentIds);

      return true;
    } catch (e) {
      SmartDialog.dismiss();
      log.e(e);

      return false;
    }
  }

  Future<bool> uploadConstructionDocuments() async {
    if (constructionDocuments.isEmpty) {
      return false;
    }

    if (constructionDocumentIds.isNotEmpty) {
      return true;
    }

    try {
      SmartDialog.showLoading(
        msg: 'Uploading documents',
      );

      final List<int> documentIds =
          await _applicationService.uploadDocuments(constructionDocuments);

      SmartDialog.dismiss();

      constructionDocumentIds.clear();
      constructionDocumentIds.addAll(documentIds);
      return true;
    } catch (e) {
      SmartDialog.dismiss();
      log.e(e);

      return false;
    }
  }

  void showAcknowledgement() {
    isShowAcknowledgement = true;
    rebuildUi();
  }

  void cancelAcknwoledgement() {
    isShowAcknowledgement = false;
    rebuildUi();
  }

  Future<void> submitApplication() async {
    try {
      final applicant = ApplicantModel(
        name: applicantNameController.text,
        country: applicantCountryController.text,
        state: applicantStateController.text,
        city: applicantCityController.text,
        street: applicantStreetController.text,
        zip: applicantZipCodeController.text,
        email: applicantEmailController.text,
        phoneNumber: applicantPhoneNumberController.text,
        notes: applicantNotesController.text,
      );
      final contractor = ContractorModel(
        individualName: contractorCompanyOrIndividualNameController.text,
        trade: contractorApplicableTradesController.text,
        email: contractorEmailController.text,
        phoneNumber: contractorPhoneNumberController.text,
        state: contractorCountryController.text,
        city: contractorStateController.text,
        country: contractorCityController.text,
        zip: contractorStreetController.text,
        street: contractorZipCodeController.text,
        licenseDocumentIds: contractorLicenseDocumentIds,
      );
      final location = LocationModel(
        state: locationCountryController.text,
        city: locationStateController.text,
        country: locationCityController.text,
        zip: locationStreetController.text,
        street: locationZipCodeController.text,
        description: projectDescriptionController.text,
        cost: double.parse(projectCostOfConstructionController.text),
        locationDocumentIds: constructionDocumentIds,
      );

      final application = ApplicationModel(
        applicant: applicant,
        contractors: [contractor],
        location: location,
      );

      SmartDialog.showLoading(msg: 'Submitting application');

      await _applicationService.submitApplication(application);

      SmartDialog.dismiss();

      log.i('Application submitted successfully');
      isApplicationSubmitted = true;
      rebuildUi();
    } catch (e) {
      log.e(e);
      SmartDialog.dismiss();
      SmartDialog.showNotify(
        msg: 'Failed to submit application',
        notifyType: NotifyType.error,
      );
    }
  }

  void navigateToHomeView() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }

  bool isApplicantFormValid() {
    return applicantFormKey.currentState!.validate();
  }

  bool isLocationFormValid() {
    return locationFormKey.currentState!.validate();
  }

  String? validateApplicantName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  String? validateApplicantCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required';
    }
    return null;
  }

  String? validateApplicantState(String? value) {
    if (value == null || value.isEmpty) {
      return 'State is required';
    }
    return null;
  }

  String? validateApplicantCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  String? validateApplicantStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'Street is required';
    }
    return null;
  }

  String? validateApplicantZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zip Code is required';
    }
    return null;
  }

  String? validateApplicantEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? validateApplicantPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }
    return null;
  }

  String? validateApplicantNotes(String? value) {
    // if (value == null || value.isEmpty) {
    //   return 'Notes is required';
    // }
    return null;
  }

  String? validateContractorCompanyOrIndividualName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company or Individual Name is required';
    }
    return null;
  }

  String? validateContractorApplicableTrades(String? value) {
    if (value == null || value.isEmpty) {
      return 'Applicable Trades is required';
    }
    return null;
  }

  String? validateContractorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? validateContractorPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }
    return null;
  }

  String? validateContractorCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required';
    }
    return null;
  }

  String? validateContractorState(String? value) {
    if (value == null || value.isEmpty) {
      return 'State is required';
    }
    return null;
  }

  String? validateContractorCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  String? validateContractorStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'Street is required';
    }
    return null;
  }

  String? validateContractorZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zip Code is required';
    }
    return null;
  }

  String? validateLocationCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required';
    }
    return null;
  }

  String? validateLocationState(String? value) {
    if (value == null || value.isEmpty) {
      return 'State is required';
    }
    return null;
  }

  String? validateLocationCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  String? validateLocationStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'Street is required';
    }
    return null;
  }

  String? validateLocationZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zip Code is required';
    }
    return null;
  }

  String? validateProjectDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  String? validateProjectCostOfConstruction(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cost of Construction is required';
    }
    return null;
  }
}