import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/views/application/acknowledgement_view.dart';
import 'package:permit_user_app/ui/views/application/submission_complete_view.dart';
import 'package:permit_user_app/ui/views/application/widgets/form_applicant.dart';
import 'package:permit_user_app/ui/views/application/widgets/form_community.dart';
import 'package:permit_user_app/ui/views/application/widgets/form_contractor.dart';
import 'package:permit_user_app/ui/views/application/widgets/form_location.dart';
import 'package:permit_user_app/ui/views/application/widgets/form_user_terms.dart';
import 'package:permit_user_app/ui/views/application/widgets/next_button.dart';
import 'package:permit_user_app/ui/views/application/widgets/previous_button.dart';
import 'package:permit_user_app/ui/views/application/widgets/step_progress_indicator.dart';
import 'package:permit_user_app/ui/views/application/widgets/submit_button.dart';
import 'package:permit_user_app/ui/views/home/widgets/user_type_menu_item.dart';
import 'package:permit_user_app/ui/widgets/common/main_small_button/main_small_button.dart';

import 'application_viewmodel.dart';

class ApplicationView extends StackedView<ApplicationViewModel> {
  const ApplicationView({Key? key, required this.userType}) : super(key: key);

  final UserType userType;

  Widget _getForm(int step) {
    switch (step) {
      case 1:
        return const ApplicantForm();
      case 2:
        return const ContractorForm();
      case 3:
        return const LocationForm();
      case 4:
        return const CommunityForm();
      case 5:
        return const UserTermsForm();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget builder(
    BuildContext context,
    ApplicationViewModel viewModel,
    Widget? child,
  ) {
    final activeStep = viewModel.activeStep;
    final isLastStep = viewModel.isLastStep;
    final status = viewModel.status;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        if (context.mounted && viewModel.canPopBack()) {
          viewModel.navigateBack();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            userType.name,
            style: ktsMediumSemiBold,
          ),
          centerTitle: false,
        ),
        body: viewModel.isApplicationSubmitted
            ? SubmissionCompleteView(
                onBackHome: () => viewModel.navigateToHomeView())
            : viewModel.isShowAcknowledgement
                ? AcknowledgementView(
                    onSubmit: () => viewModel.submitApplication(),
                    onCancel: () => viewModel.cancelAcknwoledgement(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        child: StepProgressIndicator(currentStep: activeStep),
                      ),
                      const SizedBox(height: 38),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _getForm(activeStep),
                        ),
                      ),
                      Material(
                        elevation: 1,
                        shadowColor: Colors.black,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              left: 24,
                              right: 24,
                              bottom: 10,
                            ),
                            child: SafeArea(
                              child: viewModel.canShowContractorForm
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: MainSmallButton(
                                            label: 'Add',
                                            onTap: () =>
                                                viewModel.addContractor(),
                                            leadingIcon: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        horizontalSpaceSmall,
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () =>
                                                viewModel.hideContractorForm(),
                                            child: Text(
                                              'Cancel',
                                              style: ktsSmallMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : viewModel.isEditingContractor
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: MainSmallButton(
                                                label: 'Save',
                                                onTap: () =>
                                                    viewModel.addContractor(),
                                                leadingIcon: const Icon(
                                                  Icons.save,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            horizontalSpaceSmall,
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () => viewModel
                                                    .hideContractorForm(),
                                                child: Text(
                                                  'Cancel',
                                                  style: ktsSmallMedium,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            if (activeStep > 1) ...[
                                              Expanded(
                                                child: PreviousButton(
                                                  enabled: true,
                                                  onTap: status.isLoading
                                                      ? () {}
                                                      : () => viewModel
                                                          .previousStep(),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                            ],
                                            Expanded(
                                              child: isLastStep
                                                  ? SubmitButton(
                                                      enabled: true,
                                                      onTap: () => viewModel
                                                          .showAcknowledgement(),
                                                    )
                                                  : NextButton(
                                                      enabled: true,
                                                      onTap: status.isLoading
                                                          ? () {}
                                                          : () => viewModel
                                                              .nextStep(),
                                                    ),
                                            ),
                                          ],
                                        ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  @override
  ApplicationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ApplicationViewModel();

  @override
  void onViewModelReady(ApplicationViewModel viewModel) {
    super.onViewModelReady(viewModel);

    viewModel.onViewModelReady(userType);
  }
}
