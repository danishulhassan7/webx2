import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/job.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/services/job_service.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class JobFormScreen extends StatefulWidget {
  const JobFormScreen({
    Key? key,
    this.job,
  }) : super(key: key);

  final Job? job;

  @override
  State<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends State<JobFormScreen> {
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();

  String? _title;
  String? _description;
  bool _isLoading = false;

  @override
  void initState() {
    _title = widget.job?.title;
    _description = widget.job?.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      height: _headerHeight,
                      child: HeaderWidget(
                          _headerHeight,
                          true,
                          Icons
                              .login_rounded), //let's create a common header widget
                    ),
                    Positioned.fill(
                      left: 10,
                      right: 10,
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Image(
                            image: AssetImage("asset/images/mh.png"),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      child: BackButton(color: AppColors.whiteColor),
                    ),
                  ],
                ),
              ],
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Job Form',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'Fill the form to create a job',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(height: 20.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              ContainerWithShadow(
                                child: TextFormField(
                                  initialValue: _title,
                                  onChanged: (val) => _title = val,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Title ',
                                    hintText: 'Enter your job title',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter job title';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              ContainerWithShadow(
                                child: TextFormField(
                                  initialValue: _description,
                                  onChanged: (val) => _description = val,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: 'Description',
                                    hintText: 'Enter your job description',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter job description';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                width: double.infinity,
                                child: PElevatedButton(
                                  isBusy: _isLoading,
                                  label: 'Post a Job',
                                  onPressed: () async => await _submit(),
                                ),
                              )
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });

        final _userID = await context.read<BaseAuth>().userId;
        final _user = await context.read<UserService>().getUserInfo(_userID);
        final _job = Job(
            id: widget.job?.id ?? DateTime.now().toIso8601String(),
            title: _title!,
            description: _description!,
            postedBy: widget.job?.postedBy ??
                JobPostedBy(
                  id: _userID,
                  name: _user?.displayName ?? '',
                  photoUrl: _user?.photoUrl,
                ));

        await context.read<JobService>().setJob(_job);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.job == null
                ? 'Job Posted Successfully'
                : 'Job Updated Successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: AppColors.greenColor,
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.redColor,
        ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
