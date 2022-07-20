import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/models/job.dart';
import 'package:mistriandlabours/models/job_application.dart';
import 'package:mistriandlabours/services/job_application_service.dart';
import 'package:mistriandlabours/services/job_service.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:mistriandlabours/ui/screens/user/job_form_screen.dart';
import 'package:provider/provider.dart';

class AJobsScrren extends StatelessWidget {
  const AJobsScrren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: [
          IconButton(
            icon: Icon(Ionicons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobFormScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Job>>(
          stream: context.read<JobService>().JobsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _jobs = snapshot.data ?? [];
              return _jobs.isEmpty
                  ? Center(child: Text('No jobs added.'))
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _jobs.length,
                      itemBuilder: (context, index) {
                        final Job _job = _jobs[index];

                        return Card(
                          child: Slidable(
                            key: ValueKey(_job.id),
                            endActionPane: ActionPane(
                              extentRatio: 0.5,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => _edit(context, _job),
                                  backgroundColor: AppColors.btnColor,
                                  foregroundColor: Colors.white,
                                  icon: Ionicons.create_outline,
                                ),
                                SlidableAction(
                                  onPressed: (_) => _showJob(context, _job),
                                  backgroundColor: AppColors.accentColor,
                                  foregroundColor: Colors.white,
                                  icon: Ionicons.eye_outline,
                                ),
                                SlidableAction(
                                  onPressed: (_) => _deleteJob(context, _job),
                                  backgroundColor: AppColors.redColor,
                                  foregroundColor: Colors.white,
                                  icon: Ionicons.trash_outline,
                                ),
                              ],
                            ),

                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: ListTile(
                              leading: Container(
                                height: 40,
                                width: 40,
                                clipBehavior: Clip.antiAlias,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: _job.postedBy?.photoUrl == null
                                    ? Icon(Ionicons.business_outline)
                                    : CachedNetworkImage(
                                        imageUrl: _job.postedBy!.photoUrl!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              title: Text(_job.title),
                              subtitle: Text(
                                'by ${_job.postedBy?.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color:
                                          AppColors.blackColor.withOpacity(0.8),
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> _deleteJob(BuildContext context, Job _job) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Job'),
          content: Text(
            'Are you sure you want to delete this job?',
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                context.read<JobService>().deleteJob(_job.id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showJob(BuildContext context, Job job) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return JobDetail(job: job);
    }));
  }

  _edit(BuildContext context, Job job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobFormScreen(job: job),
      ),
    );
  }
}

class JobDetail extends StatelessWidget {
  const JobDetail({
    Key? key,
    required this.job,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: job.postedBy?.photoUrl == null
                                  ? Icon(Ionicons.business_outline)
                                  : CachedNetworkImage(
                                      imageUrl: job.postedBy!.photoUrl!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.title,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    'Posted by ${job.postedBy?.name}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: AppColors.blackColor
                                              .withOpacity(0.8),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          job.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: StreamBuilder<List<JobApplication>>(
                      stream: context
                          .read<JobApplicationService>()
                          .jobApplicationsStream(jobID: job.id),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          final _applications = snap.data ?? [];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Job Applications'),
                              Divider(),
                              if (_applications.isEmpty)
                                Text('No job applications'),
                              ..._applications.map((application) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamBuilder<AppUser?>(
                                      stream: context
                                          .read<UserService>()
                                          .getUser(application.userId),
                                      builder: ((context, snapshot) {
                                        final _user = snapshot.data;
                                        return Text('${_user?.displayName}');
                                      }),
                                    ),
                                    Text(
                                      '${application.date} ${application.time}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      application.location,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                );
                              }).toList()
                            ],
                          );
                        } else if (snap.hasError) {
                          return Text(snap.error.toString());
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
