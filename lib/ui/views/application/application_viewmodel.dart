import 'dart:async';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:permit_user_app/models/attachment_model.dart';
import 'package:permit_user_app/models/community_model.dart';
import 'package:permit_user_app/services/location_service.dart';
import 'package:permit_user_app/ui/views/home/widgets/user_type_menu_item.dart';
import 'package:permit_user_app/utils/dialog.dart';
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

const permitTypes = ['Residential', 'Commercial'];

extension ApplicationStatusX on ApplicationStatus {
  bool get isLoading => this == ApplicationStatus.loading;
}

class ApplicationViewModel extends BaseViewModel {
  final log = getLogger('ApplicationViewModel');
  final _applicationService = locator<ApplicationService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _locationService = locator<LocationService>();

  final applicantFormKey = GlobalKey<FormState>();
  final applicantFirstNameController = TextEditingController();
  final applicantLastNameController = TextEditingController();
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

  Timer? _debounce;
  String? applicantEmailErrorText;
  String? contractorEmailErrorText;

  String? selectedRole;

  //
  LocationModel? locationModel;

  //
  int activeStep = 1;
  bool get isLastStep => activeStep == 5;
  ApplicationStatus status = ApplicationStatus.collecting;

  //
  List<ContractorModel> contractors = [];
  bool canShowContractorForm = false;
  bool isEditingContractor = false;
  int? editingContractorIndex;
  List<AttachmentModel> contractorLicenseAttachments = [];

  List<AttachmentModel> constructionAttachments = [];
  String defaultPermitType = permitTypes[0];

  //
  List<CommunityModel> communities = [];
  CommunityModel? selectedCommunity;

  //
  bool isShowAcknowledgement = false;
  bool isApplicationSubmitted = false;

  final errorToastsController = SmartDialogController();

  void onViewModelReady(UserType userType) {
    selectedRole = userType.name;
    getUserCurrentCompleteAddress();
    listenToEmailFieldsTextChanges();
  }

  void listenToEmailFieldsTextChanges() {
    applicantEmailController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        bool isUpdated = false;
        final error = validateApplicantEmail(applicantEmailController.text);
        if (error != applicantEmailErrorText) {
          isUpdated = true;
        }
        applicantEmailErrorText = error;
        if (isUpdated) rebuildUi();
      });
    });
    contractorEmailController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        bool isUpdated = false;
        final error = validateContractorEmail(contractorEmailController.text);
        if (error != contractorEmailErrorText) {
          isUpdated = true;
        }
        contractorEmailErrorText = error;
        if (isUpdated) rebuildUi();
      });
    });
  }

  void getUserCurrentCompleteAddress() async {
    try {
      final placemark = await _locationService.getAddressFromUserPosition();
      applicantCountryController.text = placemark.country ?? '';
      applicantStreetController.text = placemark.thoroughfare ?? '';
      applicantCityController.text = placemark.locality ?? '';
      applicantStateController.text = placemark.administrativeArea ?? '';
      applicantZipCodeController.text = placemark.postalCode ?? '';
      rebuildUi();
    } catch (e) {
      log.e(e);
    }
  }

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

    if (contractorLicenseAttachments.isEmpty) {
      DialogUtils.showBottomToast(
          'Please upload at least one contractor license document');

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
      zip: int.parse(contractorZipCodeController.text),
      street: contractorStreetController.text,
      licenseDocuments: List.from(contractorLicenseAttachments),
    );

    if (editingContractorIndex != null) {
      contractors[editingContractorIndex!] = contractorModel;
    } else {
      contractors.add(contractorModel);
    }

    hideContractorForm();
  }

  void resetContractorForm() {
    contractorFormKey.currentState?.reset();
    contractorCompanyOrIndividualNameController.text = '';
    contractorApplicableTradesController.text = '';
    contractorEmailController.text = '';
    contractorPhoneNumberController.text = '';
    contractorCountryController.text = '';
    contractorStateController.text = '';
    contractorCityController.text = '';
    contractorStreetController.text = '';
    contractorZipCodeController.text = '';
    contractorLicenseAttachments.clear();
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
        DialogUtils.showBottomToast('Please add at least one contractor');
        return;
      }
      final res = await uploadAllContractorAttachments();
      if (!res) {
        DialogUtils.showBottomToast(
            'Failed to upload documents. Please try again');
        return;
      }
    }

    if (activeStep == 3) {
      if (!isLocationFormValid()) {
        return;
      }

      if (constructionAttachments.isEmpty) {
        DialogUtils.showBottomToast(
            'Please upload at least one construction documents');
        return;
      }
      final res = await uploadConstructionDocuments();
      if (!res) {
        DialogUtils.showBottomToast(
            'Failed to upload documents. Please try again');
        return;
      }

      saveLocationData();

      // get nearby communities
      await getNearbyCommunities();
    }

    if (activeStep == 4) {
      if (selectedCommunity == null) {
        DialogUtils.showBottomToast('Please select a community');
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

  void saveLocationData() {
    locationModel = LocationModel(
      state: locationCountryController.text,
      city: locationStateController.text,
      country: locationCityController.text,
      zip: int.parse(locationZipCodeController.text),
      street: locationStreetController.text,
      description: projectDescriptionController.text,
      cost: double.parse(projectCostOfConstructionController.text),
      locationAttachments: List.from(constructionAttachments),
      permitType: defaultPermitType,
    );
  }

  Future<void> getNearbyCommunities() async {
    if (locationModel == null) {
      previousStep();
      return;
    }

    try {
      SmartDialog.showLoading(msg: 'Loading nearby communities');

      final communities =
          await _applicationService.getNearbyCommunities(locationModel!);

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
    contractorZipCodeController.text = contractor.zip.toString();
    contractorLicenseAttachments.clear();
    contractorLicenseAttachments.addAll(contractor.licenseDocuments);

    rebuildUi();
  }

  void pickContractorLicenseDocuments() async {
    final List<File>? result = await _pickDocuments();

    if (result != null) {
      contractorLicenseAttachments.clear();
      contractorLicenseAttachments
          .addAll(result.map((e) => AttachmentModel(file: e)));
      rebuildUi();
    }
  }

  void pickConstructionDocuments() async {
    final List<File>? result = await _pickDocuments();

    if (result != null) {
      constructionAttachments.clear();
      constructionAttachments
          .addAll(result.map((e) => AttachmentModel(file: e)));
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

  Future<void> uploadAttachment(AttachmentModel attachment) async {
    try {
      attachment.isUploading = true;
      rebuildUi();

      final List<int> documentIds =
          await _applicationService.uploadDocuments(attachment.file);
      attachment.id = documentIds.first;
      attachment.isUploading = false;
      attachment.isUploadFailed = false;
      rebuildUi();
    } catch (e) {
      attachment.isUploading = false;
      attachment.isUploadFailed = true;
      rebuildUi();
      DialogUtils.showBottomToast('Failed to upload document');

      rethrow;
    }
  }

  Future<bool> uploadContractorLicenseDocuments(
      {bool rebuildUIImmediately = false}) async {
    if (contractorLicenseAttachments.isEmpty) {
      return false;
    }

    try {
      SmartDialog.showLoading(
        msg: 'Uploading documents',
      );

      for (var attachment in contractorLicenseAttachments) {
        if (attachment.id == null) {
          await uploadAttachment(attachment);
        }
      }

      SmartDialog.dismiss();

      if (rebuildUIImmediately) {
        rebuildUi();
      }

      return true;
    } catch (e) {
      SmartDialog.dismiss();
      log.e(e);

      return false;
    }
  }

  Future<bool> uploadConstructionDocuments(
      {bool rebuildUIImmediately = false}) async {
    if (constructionAttachments.isEmpty) {
      return false;
    }

    if (constructionAttachments.every((e) => e.isUploaded)) {
      return true;
    }

    try {
      SmartDialog.showLoading(
        msg: 'Uploading documents',
      );

      for (var attachment in constructionAttachments) {
        if (attachment.id == null) {
          await uploadAttachment(attachment);
        }
      }

      await SmartDialog.dismiss();

      if (rebuildUIImmediately) {
        rebuildUi();
      }
    } catch (e) {
      await SmartDialog.dismiss();
      log.e(e);
    }

    return constructionAttachments
        .every((construction) => construction.isUploaded);
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
      if (locationModel == null) {
        DialogUtils.showBottomToast('Location data not valid');

        return;
      }

      if (selectedRole == null) {
        DialogUtils.showBottomToast('Role not selected');

        return;
      }

      final applicant = ApplicantModel(
        firstName: applicantFirstNameController.text,
        lastName: applicantLastNameController.text,
        country: applicantCountryController.text,
        state: applicantStateController.text,
        city: applicantCityController.text,
        street: applicantStreetController.text,
        zip: int.parse(applicantZipCodeController.text),
        email: applicantEmailController.text,
        phoneNumber: applicantPhoneNumberController.text,
        notes: applicantNotesController.text,
        role: selectedRole!,
      );

      final application = ApplicationModel(
        applicant: applicant,
        contractors: contractors,
        location: locationModel!,
        community: selectedCommunity!.communityRefId,
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

  String? validateApplicantFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }

    return null;
  }

  String? validateApplicantLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
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
    if (!EmailValidator.validate(value)) {
      return 'Invalid email address';
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
      DialogUtils.showBottomToast('Company or Individual Name is required');
      return 'Company or Individual Name is required';
    }
    return null;
  }

  String? validateContractorApplicableTrades(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Applicable Trades is required');
      return 'Applicable Trades is required';
    }
    return null;
  }

  String? validateContractorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validateContractorPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Phone Number is required');
      return 'Phone Number is required';
    }
    return null;
  }

  String? validateContractorCountry(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Country is required');
      return 'Country is required';
    }
    return null;
  }

  String? validateContractorState(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('State is required');
      return 'State is required';
    }
    return null;
  }

  String? validateContractorCity(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('City is required');
      return 'City is required';
    }
    return null;
  }

  String? validateContractorStreet(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Street is required');
      return 'Street is required';
    }
    return null;
  }

  String? validateContractorZipCode(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Zip Code is required');
      return 'Zip Code is required';
    }
    return null;
  }

  String? validateLocationCountry(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Country is required');
      return 'Country is required';
    }
    return null;
  }

  String? validateLocationState(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('State is required');
      return 'State is required';
    }
    return null;
  }

  String? validateLocationCity(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('City is required');
      return 'City is required';
    }
    return null;
  }

  String? validateLocationStreet(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Street is required');
      return 'Street is required';
    }
    return null;
  }

  String? validateLocationZipCode(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Zip Code is required');
      return 'Zip Code is required';
    }
    return null;
  }

  String? validateProjectDescription(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Description is required');
      return 'Description is required';
    }
    return null;
  }

  String? validateProjectCostOfConstruction(String? value) {
    if (value == null || value.isEmpty) {
      DialogUtils.showBottomToast('Cost of Construction is required');
      return 'Cost of Construction is required';
    }
    return null;
  }

  void changePermitType(String? value) {
    if (value == null) return;

    defaultPermitType = value;
    rebuildUi();
  }

  void removeContractorDocument(String path) {
    contractorLicenseAttachments.removeWhere((e) => e.file.path == path);

    rebuildUi();
  }

  void removeContructionsDocument(String path) {
    constructionAttachments.removeWhere((e) => e.file.path == path);

    rebuildUi();
  }

  bool areAllConstructionAttachmentsUploaded() {
    return constructionAttachments.every((e) => e.isUploaded);
  }

  bool areAllContractorAttachmentsUploaded() {
    return contractorLicenseAttachments.every((e) => e.isUploaded);
  }

  bool isAnyContractorAttachmentUploading() {
    return contractorLicenseAttachments.any((e) => e.isUploading);
  }

  Future<bool> uploadAllContractorAttachments() async {
    try {
      SmartDialog.showLoading(msg: 'Uploading contractors documents');
      for (var contractor in contractors) {
        for (var attachment in contractor.licenseDocuments) {
          if (attachment.id == null) {
            await uploadAttachment(attachment);
          }
        }
      }
    } catch (e) {
      log.e(e);
    }

    SmartDialog.dismiss();
    return contractors
        .every((contractor) => areContractorAttachmentsUploaded(contractor));
  }

  int getUploadedContractorDocumentsCount(ContractorModel contractor) {
    return contractor.licenseDocuments.where((doc) => doc.id != null).length;
  }

  bool areContractorAttachmentsUploaded(ContractorModel contractor) {
    return contractor.licenseDocuments.every((doc) => doc.isUploaded);
  }

  bool areContractorAttachmentsUploading(ContractorModel contractor) {
    return contractor.licenseDocuments.any((doc) => doc.isUploading);
  }

  void removeContractor(ContractorModel contractor) async {
    final res = await _dialogService.showConfirmationDialog(
      title: 'Remove Contractor',
      description: 'Are you sure you want to remove this contractor?',
    );

    if (res != null && res.confirmed) {
      contractors.remove(contractor);
      rebuildUi();

      DialogUtils.showBottomToast('Contractor removed');
    }
  }
}
