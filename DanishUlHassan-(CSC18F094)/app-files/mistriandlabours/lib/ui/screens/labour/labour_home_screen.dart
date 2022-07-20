import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/job.dart';
import 'package:mistriandlabours/services/job_service.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class LabourHomeScreen extends StatelessWidget {
  const LabourHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Theme(data: Theme.of(context).copyWith(), child: AppDrawer()),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blackColor),
        title: Text(
          "jobs",
          style: TextStyle(color: AppColors.blackColor),
        ),
        backgroundColor: AppColors.whiteColor,
      ),
      body: StreamBuilder<List<Job>>(
          stream: context.read<JobService>().JobsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _jobs = snapshot.data ?? [];

              if (_jobs.isEmpty) {
                return Center(
                  child: Text("No data found"),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8, bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Image.asset('asset/images/mh_logo.png'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Apply on these recent jobs and \nstart working',
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _jobs.length,
                      itemBuilder: (context, index) {
                        return JobCard(job: _jobs[index]);
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
