import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:permit_user_app/models/community_model.dart';
import 'package:stacked/stacked.dart';
import 'package:permit_user_app/app/app.locator.dart';
import 'package:permit_user_app/app/app.logger.dart';
import 'package:permit_user_app/app/app.router.dart';
import 'package:permit_user_app/models/applicant_model.dart';
import 'package:permit_user_app/models/application_model.dart';
import 'package:permit_user_app/models/contractor_model.dart';
import 'package:permit_user_app/models/location_model.dart';
import 'package:permit_user_app/services/application_service.dart';
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
  final contractorFormKey = GlobalKey<FormState>();
  final contractorCompanyOrIndividualNameController = TextEditingController();
  final contractorApplicableTradesController = TextEditingController();
  final contractorEmailController = TextEditingController();
  final contractorPhoneNumberController = TextEditingController();
  final contractorCountryController = TextEditingController();
  final contractorStateController = TextEditingController();
  final contractorCityController = TextEditingController();
  final contractorStreetController = TextEditingController();
  final contractorZipCodeController = TextEditingController();
  List<ContractorModel> contractors = [];
  bool canShowContractorForm = false;
  bool isEditingContractor = false;
  int? editingContractorIndex;

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
  int activeStep = 1;
  bool get isLastStep => activeStep == 5;
  ApplicationStatus status = ApplicationStatus.collecting;

  //
  List<File> contractorLicenseDocuments = [];
  List<File> constructionDocuments = [];
  List<int> contractorLicenseDocumentIds = [];
  List<int> constructionDocumentIds = [];

  //
  List<CommunityModel> communities = [];
  CommunityModel? selectedCommunity;

  //
  bool isShowAcknowledgement = false;
  bool isApplicationSubmitted = false;

  void onViewModelReady() {}

  void showContractorForm() {
    canShowContractorForm = true;
    rebuildUi();
  }

  void hideContractorForm() {
    canShowContractorForm = false;
    resetContractorForm();
    cancelEditingContractor();
    rebuildUi();
  }

  void cancelEditingContractor() {
    isEditingContractor = false;
    editingContractorIndex = null;
  }

  void addContractor() async {
    if (!isContractorFormValid()) return;

    if (contractorLicenseDocuments.isEmpty) {
      SmartDialog.showNotify(
        msg: 'Please upload at least one contractor license document',
        notifyType: NotifyType.alert,
      );
      return;
    }

    final uploadResult = await uploadContractorLicenseDocuments();

    if (uploadResult == false) {
      SmartDialog.showNotify(
        msg: 'Failed to upload documents. Please try again',
        notifyType: NotifyType.error,
      );
      return;
    }

    final contractorModel = ContractorModel(
      individualName: contractorCompanyOrIndividualNameController.text,
      trade: contractorApplicableTradesController.text,
      email: contractorEmailController.text,
      phoneNumber: contractorPhoneNumberController.text,
      state: contractorCountryController.text,
      city: contractorStateController.text,
      country: contractorCityController.text,
      zip: contractorStreetController.text,
      street: contractorZipCodeController.text,
      licenseDocumentIds: contractorLicenseDocumentIds.toList(),
      licenseDocuments: contractorLicenseDocuments.toList(),
    );

    if (editingContractorIndex != null) {
      contractors[editingContractorIndex!] = contractorModel;
    } else {
      contractors.add(contractorModel);
    }

    hideContractorForm();
  }

  void resetContractorForm() {
    contractorCompanyOrIndividualNameController.text = '';
    contractorApplicableTradesController.text = '';
    contractorEmailController.text = '';
    contractorPhoneNumberController.text = '';
    contractorCountryController.text = '';
    contractorStateController.text = '';
    contractorCityController.text = '';
    contractorStreetController.text = '';
    contractorZipCodeController.text = '';
    contractorLicenseDocumentIds.clear();
    contractorLicenseDocuments.clear();
  }

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
      if (activeStep == 2) {
        if (canShowContractorForm || isEditingContractor) {
          hideContractorForm();
          rebuildUi();
          return false;
        }
      }

      previousStep();
    }

    return isOnFirstStep;
  }

  void navigateBack() {
    _navigationService.back();
  }

  void onCommunitySelectionChanged(CommunityModel? value) {
    selectedCommunity = value;
    rebuildUi();
  }

  void nextStep() async {
    if (activeStep == 1) {
      if (!isApplicantFormValid()) {
        return;
      }
    }

    if (activeStep == 2) {
      if (contractors.isEmpty) {
        SmartDialog.showNotify(
          msg: 'Please add at least one contractor',
          notifyType: NotifyType.alert,
        );
        return;
      }
      // await uploadContractorLicenseDocuments();
    }

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

      // get nearby communities
      await getNearbyCommunities();
    }

    if (activeStep == 4) {
      if (selectedCommunity == null) {
        SmartDialog.showNotify(
          msg: 'Please select a community',
          notifyType: NotifyType.alert,
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

  Future<void> getNearbyCommunities() async {
    try {
      int page = 1;
      const filter = 'New York';

      SmartDialog.showLoading(msg: 'Loading nearby communities');

      await Future.delayed(const Duration(seconds: 3));

      final communities =
          await _applicationService.getNearbyCommunities(page, filter);

      this.communities.clear();
      this.communities.addAll(communities);
      if (this.communities.isNotEmpty) {
        selectedCommunity = this.communities.first;
      }

      SmartDialog.dismiss();

      log.i(communities);
    } catch (e) {
      log.e(e);
      SmartDialog.dismiss();
    }
  }

  void startEditingContractor(ContractorModel contractor) {
    isEditingContractor = true;
    editingContractorIndex = contractors.indexOf(contractor);

    contractorCompanyOrIndividualNameController.text =
        contractor.individualName;
    contractorApplicableTradesController.text = contractor.trade;
    contractorEmailController.text = contractor.email;
    contractorPhoneNumberController.text = contractor.phoneNumber;
    contractorCountryController.text = contractor.country;
    contractorStateController.text = contractor.state;
    contractorCityController.text = contractor.city;
    contractorStreetController.text = contractor.street;
    contractorZipCodeController.text = contractor.zip;
    contractorLicenseDocumentIds.clear();
    contractorLicenseDocumentIds.addAll(contractor.licenseDocumentIds);
    contractorLicenseDocuments.clear();
    if (contractor.licenseDocuments != null) {
      contractorLicenseDocuments.addAll(contractor.licenseDocuments!);
    }

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

    try {
      SmartDialog.showLoading(
        msg: 'Uploading documents',
      );

      final List<int> documentIds =
          await _applicationService.uploadDocuments(contractorLicenseDocuments);

      SmartDialog.dismiss();

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

      await SmartDialog.dismiss();

      constructionDocumentIds.clear();
      constructionDocumentIds.addAll(documentIds);
      return true;
    } catch (e) {
      await SmartDialog.dismiss();
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
        contractors: contractors,
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

  bool isContractorFormValid() {
    return contractorFormKey.currentState!.validate();
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
