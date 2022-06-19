import 'package:flutter/material.dart';
import 'package:mistriandlabours/models/job.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/services/job_service.dart';
import 'package:mistriandlabours/ui/screens/user/job_form_screen.dart';
import 'package:provider/provider.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userID = context.watch<BaseAuth>().userId;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Jobs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<List<Job>>(
              stream: context.read<JobService>().JobsStream(userID: _userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final _jobs = snapshot.data ?? [];
                  return _jobs.isEmpty
                      ? Center(child: Text('No jobs added.'))
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _jobs.length,
                          separatorBuilder: (context, i) => const Divider(),
                          itemBuilder: (context, index) {
                            final Job _job = _jobs[index];
                            return ListTile(
                              title: Text(_job.title),
                              subtitle: Text(
                                _job.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: FittedBox(
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return JobFormScreen(
                                            job: _job,
                                          );
                                        }));
                                      },
                                      child: Text('Edit'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        context
                                            .read<JobService>()
                                            .deleteJob(_job.id);
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
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
        ),
      ),
    );
  }
}
