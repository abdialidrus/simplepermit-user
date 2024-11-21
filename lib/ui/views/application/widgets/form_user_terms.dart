import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';

class UserTermsForm extends StatelessWidget {
  const UserTermsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildConsentItem(
            'CONSENT',
            '''By submitting this application through the Building Permit Portal, you, the applicant, hereby agree to the following terms:''',
          ),
          verticalSpaceSmall,
          _buildConsentItem(
            '1. Accuracy of Information:',
            '''
You confirm that all the information provided in the application form is accurate, complete, and up-to-date to the best of your knowledge.
You acknowledge that submitting false or misleading information may result in the rejection of your application or future legal action.
''',
          ),
          verticalSpaceSmall,
          _buildConsentItem(
            '2. Document Submission:',
            '''
You consent to the submission of all required documents, including but not limited to, architectural plans, licenses, and permits, which are necessary for processing your application.
You understand that all submitted documents will be reviewed by the assigned community, and further verification or additional documents may be requested.
''',
          ),
          verticalSpaceSmall,
          _buildConsentItem(
            '3. Communication Consent:',
            '''
You consent to receive electronic communications (via email) related to the status of your application, requests for additional documentation, or other matters necessary for the processing of your application.
You agree to the inclusion of your application summary in a confirmation email, which may include personal or project-specific information for tracking and transparency purposes.
''',
          ),
          verticalSpaceSmall,
          _buildConsentItem(
            '4. Data Usage and Privacy:',
            '''
You agree that the information provided in this application may be shared with authorized community officials and relevant stakeholders for the purpose of reviewing and processing the application.
Your personal data will be stored and handled in compliance with applicable data protection laws and will not be shared with third parties beyond those necessary for the application process.
''',
          ),
          verticalSpaceLarge,
          _buildConsentItem('DISCLAIMER', null),
          verticalSpaceSmall,
          _buildConsentItem(
            '1. No Guarantee of Approval:',
            '''
Submission of this application does not guarantee that your permit will be approved. Each application will be reviewed by the appropriate community, and approval is contingent upon meeting all legal, regulatory, and community-specific requirements.
''',
          ),
          verticalSpaceSmall,
          _buildConsentItem(
            '2. Processing Time:',
            '''
The processing time for applications may vary depending on the complexity of the project, the completeness of the submitted documents, and the workload of the reviewing community. The Building Permit Portal does not guarantee specific processing times.
''',
          ),
          verticalSpaceSmall,
          _buildConsentItem(
            '3. Document Responsibility:',
            '''
The applicant is solely responsible for ensuring that all required documents are submitted in the correct format and contain accurate information. The Building Permit Portal is not liable for errors, omissions, or delays caused by incomplete or inaccurate submissions.
''',
          ),
          verticalSpaceSmall,
          _buildConsentItem(
            '4. Rejection or Revocation:',
            '''
The community reserves the right to reject or revoke an application at any stage if it fails to meet the necessary requirements or if discrepancies are found in the submitted documents.
''',
          ),
          verticalSpaceSmall,
          _buildConsentItem(
            '5. Liability:',
            '''
The Building Permit Portal and its administrators are not liable for any damages, delays, or losses incurred as a result of using this portal or due to the rejection, revocation, or delay of an application.
''',
          ),
        ],
      ),
    );
  }

  Widget _buildConsentItem(String title, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: ktsLabelBold),
        if (content != null) ...[
          verticalSpaceSmall,
          Text(content, style: ktsLabelRegular),
        ],
      ],
    );
  }
}
