import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mistriandlabours/models/job.dart';
import 'package:mistriandlabours/models/job_application.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/services/job_application_service.dart';
import 'package:mistriandlabours/services/one_signal_service.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class ApplyJobScreen extends StatefulWidget {
  const ApplyJobScreen({
    Key? key,
    required this.job,
  }) : super(key: key);

  final Job job;

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _date;
  String? _time;
  String? _payment;
  String? _location;
  String? _additionalInfo;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      enabled: false,
                      initialValue: widget.job.title,
                      decoration: InputDecoration(
                        labelText: 'Job Title',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: false,
                      initialValue: widget.job.description,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Job Description',
                      ),
                    ),
                    SizedBox(height: 20),
                    FormField<bool>(
                      builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InputDecorator(
                              child: GestureDetector(
                                child: Text(
                                    _date != null ? _date! : 'Select Date'),
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 1),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                  );
                                  if (date != null) {
                                    setState(() {
                                      _date =
                                          DateFormat('dd/MM/yyyy').format(date);
                                    });
                                  }
                                },
                              ),
                              decoration: InputDecoration(
                                labelText: 'Date',
                                hintText: 'Enter a date',
                                errorText: state.errorText,
                              ),
                            ),
                          ],
                        );
                      },
                      validator: (value) {
                        if (_date == null) {
                          return 'Please select a date';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    FormField(
                      builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InputDecorator(
                              child: GestureDetector(
                                child: Text(
                                    _time != null ? _time! : 'Select Time'),
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    setState(() {
                                      _time = time.format(context);
                                    });
                                  }
                                },
                              ),
                              decoration: InputDecoration(
                                labelText: 'Time',
                                hintText: 'Enter time in 24 hour format',
                                errorText: state.errorText,
                              ),
                            ),
                          ],
                        );
                      },
                      validator: (value) {
                        if (_time == null) {
                          return 'Please select a time';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) => _payment = val,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a payment';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Payment',
                        hintText: 'Enter payment',
                        prefixText: 'Rs.',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onChanged: (val) => _location = val,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Location',
                        hintText: 'Enter your location',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onChanged: (val) => _additionalInfo = val,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Additional Info',
                        alignLabelWithHint: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: PElevatedButton(
                        isBusy: _isLoading,
                        label: 'Apply',
                        onPressed: () async => await _submit(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() => _isLoading = true);
        final _uid = context.read<BaseAuth>().userId;
        final _applyJob = JobApplication(
          id: DateTime.now().toIso8601String(),
          title: widget.job.title,
          description: widget.job.description,
          date: _date!,
          time: _time!,
          payment: _payment!,
          location: _location!,
          jobId: widget.job.id,
          userId: _uid,
          createdAt: DateTime.now().toString(),
          additionalInfo: _additionalInfo,
        );

        await context
            .read<JobApplicationService>()
            .setJobApplication(_applyJob);

        final _user = await context.read<UserService>().getUserInfo(_uid);

        if (_user != null) {
          await _sendPushNotification(
            content:
                '${_user.displayName ?? ''} has applied for ${widget.job.title} job. Please check your dashboard.',
            title: 'New Job Application',
            context: context,
            userId: widget.job.postedBy!.id,
          );
        }

        await context.read<UserService>().updateUser(_user!
            .copyWith(appliedJobs: [..._user.appliedJobs, widget.job.id]));
        Navigator.pop(context);
      } catch (e) {
        print(e);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _sendPushNotification({
    required BuildContext context,
    required String content,
    required String title,
    required String userId,
  }) async {
    final _appUser = await context.read<UserService>().getUserInfo(userId);
    if (_appUser?.token != null)
      await context.read<OneSignalService>().sendNotification(
        tokenIdList: [_appUser!.token!],
        contents: content,
        heading: title,
      );
  }
}
