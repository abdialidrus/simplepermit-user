import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_permit_user_app/ui/common/app_colors.dart';
import 'package:stacked_permit_user_app/ui/common/app_typography.dart';
import 'package:stacked_permit_user_app/ui/common/ui_helpers.dart';
import 'package:stacked_permit_user_app/ui/views/application/application_viewmodel.dart';
import 'package:stacked_permit_user_app/ui/views/application/widgets/form_subtitle.dart';

class CommunityForm extends ViewModelWidget<ApplicationViewModel> {
  const CommunityForm({super.key});

  @override
  Widget build(BuildContext context, ApplicationViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const FormSubtitle(
            label: 'Select the community closest to your project location:',
          ),
          verticalSpaceSmall,

          //
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: kcLightGrey),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    '''Beirut Community , 3 km , beirut@municipality.lb, Beirut Central District, Beirut''',
                  ),
                  titleTextStyle: ktsSmallRegular,
                  textColor: Colors.black,
                  leading: Radio(
                    value: 1,
                    groupValue: viewModel.selectedCommunity,
                    onChanged: viewModel.onCommunitySelectionChanged,
                  ),
                  onTap: () => viewModel.onCommunitySelectionChanged(1),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                ),
                ListTile(
                  title: const Text(
                    '''Jdeideh Community, 7 km, jdeideh@municipality.lb, Jdeideh Main Street, Jdeideh''',
                  ),
                  titleTextStyle: ktsSmallRegular,
                  textColor: Colors.black,
                  leading: Radio(
                    value: 2,
                    groupValue: viewModel.selectedCommunity,
                    onChanged: viewModel.onCommunitySelectionChanged,
                  ),
                  onTap: () => viewModel.onCommunitySelectionChanged(2),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                ),
                ListTile(
                  title: const Text(
                    '''Baabda Community, 10 km, baabda@municipality.lb, Baabda City Center, Baabda''',
                  ),
                  titleTextStyle: ktsSmallRegular,
                  textColor: Colors.black,
                  leading: Radio(
                    value: 3,
                    groupValue: viewModel.selectedCommunity,
                    onChanged: viewModel.onCommunitySelectionChanged,
                  ),
                  onTap: () => viewModel.onCommunitySelectionChanged(3),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                ),
                ListTile(
                  title: const Text(
                    '''Sin el Fil Community, 12 km, sinelfil@municipality.lb, Sin el Fil Road, Sin el Fil''',
                  ),
                  titleTextStyle: ktsSmallRegular,
                  textColor: Colors.black,
                  leading: Radio(
                    value: 4,
                    groupValue: viewModel.selectedCommunity,
                    onChanged: viewModel.onCommunitySelectionChanged,
                  ),
                  onTap: () => viewModel.onCommunitySelectionChanged(4),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
