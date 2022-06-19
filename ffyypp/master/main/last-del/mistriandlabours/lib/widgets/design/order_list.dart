import 'package:flutter/material.dart';
import 'package:mistriandlabours/models/job_application.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    Key? key,
    required this.jobApplications,
    required this.postiveLabel,
    required this.negativeLabel,
    this.onPositiveBtnClicked,
    this.onNegativeBtnClicked,
  }) : super(key: key);

  final List<JobApplication> jobApplications;
  final Function(JobApplication)? onPositiveBtnClicked;
  final Function(JobApplication)? onNegativeBtnClicked;
  final String postiveLabel;
  final String negativeLabel;

  @override
  Widget build(BuildContext context) {
    if (jobApplications.isEmpty) {
      return Center(
        child: Text('No data found.'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: jobApplications.length,
      itemBuilder: (context, index) {
        final _application = jobApplications[index];
        return OrderCard(
          application: _application,
          onNegativeBtnClicked: onNegativeBtnClicked,
          onPositiveBtnClicked: onPositiveBtnClicked,
          negativeLabel: negativeLabel,
          postiveLabel: postiveLabel,
        );
      },
    );
  }
}
