import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:permit_user_app/ui/common/app_colors.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/views/application/application_viewmodel.dart';
import 'package:permit_user_app/ui/views/application/widgets/form_subtitle.dart';

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
            child: viewModel.communities.isEmpty
                ? const Text('No communities found')
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: viewModel.communities
                        .map(
                          (e) => ListTile(
                            title: Text(
                                '${e.name}, ${e.workEmail}, ${e.state} ${e.street}'),
                            titleTextStyle: ktsSmallRegular,
                            textColor: Colors.black,
                            leading: Radio(
                              value: e.communityRefId,
                              groupValue:
                                  viewModel.selectedCommunity!.communityRefId,
                              onChanged: (value) =>
                                  viewModel.onCommunitySelectionChanged(e),
                            ),
                            onTap: () =>
                                viewModel.onCommunitySelectionChanged(e),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
