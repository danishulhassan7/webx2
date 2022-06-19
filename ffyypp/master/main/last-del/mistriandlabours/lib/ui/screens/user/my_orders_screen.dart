import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/models/job_application.dart';
import 'package:mistriandlabours/services/job_application_service.dart';
import 'package:mistriandlabours/services/one_signal_service.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: StreamBuilder<List<JobApplication>>(
        stream: context.read<JobApplicationService>().jobApplicationsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final _orders = snapshot.data ?? [];
            final _pendingOrders = _orders
                .where((element) => element.status == 'pending')
                .toList();
            final _approvedOrders = _orders
                .where((element) => element.status == 'approved')
                .toList();
            final _rejectedOrders = _orders
                .where((element) => element.status == 'rejected')
                .toList();

            final _completedOrders = _orders
                .where((element) => element.status == 'completed')
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(vertical: 1),
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: AppColors.greyColor.withOpacity(0.05),
                      ),
                    ),
                    child: TabBar(
                      isScrollable: true,
                      controller: tabController,
                      tabs: [
                        PTab(
                          label: 'Pending',
                          count: _pendingOrders.length,
                        ),
                        PTab(
                          label: 'Approved',
                          count: _approvedOrders.length,
                        ),
                        PTab(
                          label: 'Completed',
                          count: _completedOrders.length,
                        ),
                        PTab(
                          label: 'Rejected',
                          count: _rejectedOrders.length,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        OrderList(
                          postiveLabel: 'Accept',
                          negativeLabel: 'Reject',
                          jobApplications: _pendingOrders,
                          onPositiveBtnClicked: (val) async {
                            await context
                                .read<JobApplicationService>()
                                .setJobApplication(
                                  val.copyWith(status: 'approved'),
                                );

                            final _user = context.read<AppUser>();

                            await _sendPushNotification(
                              content:
                                  'Your job application has been approved by ${_user.displayName}',
                              title: 'Order Approved',
                              context: context,
                              userId: val.userId,
                            );
                          },
                          onNegativeBtnClicked: (val) async {
                            await context
                                .read<JobApplicationService>()
                                .setJobApplication(
                                  val.copyWith(status: 'rejected'),
                                );
                            final _user = context.read<AppUser>();

                            await _sendPushNotification(
                              content:
                                  'Your job application has been rejected by ${_user.displayName}',
                              title: 'Order Rejected',
                              context: context,
                              userId: val.userId,
                            );
                          },
                        ),
                        OrderList(
                          postiveLabel: 'Mark as completed',
                          negativeLabel: 'Reject',
                          jobApplications: _approvedOrders,
                          onNegativeBtnClicked: (val) async {
                            await context
                                .read<JobApplicationService>()
                                .setJobApplication(
                                  val.copyWith(status: 'rejected'),
                                );
                            final _user = context.read<AppUser>();
                            await _sendPushNotification(
                              content:
                                  'Your job application has been completed by ${_user.displayName}',
                              title: 'Order Rejected',
                              context: context,
                              userId: val.userId,
                            );
                          },
                          onPositiveBtnClicked: (val) async {
                            await context
                                .read<JobApplicationService>()
                                .setJobApplication(
                                  val.copyWith(status: 'completed'),
                                );
                            final _user = context.read<AppUser>();
                            await _sendPushNotification(
                              content:
                                  'Your job application has been rejected by ${_user.displayName}',
                              title: 'Order Rejected',
                              context: context,
                              userId: val.userId,
                            );
                          },
                        ),
                        OrderList(
                          postiveLabel: '',
                          negativeLabel: '',
                          jobApplications: _completedOrders,
                        ),
                        OrderList(
                          postiveLabel: '',
                          negativeLabel: '',
                          jobApplications: _rejectedOrders,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
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
