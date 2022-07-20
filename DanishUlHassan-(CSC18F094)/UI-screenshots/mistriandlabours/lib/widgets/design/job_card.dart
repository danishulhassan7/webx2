import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/models/job.dart';
import 'package:mistriandlabours/ui/screens/labour/apply_job_screen.dart';
import 'package:mistriandlabours/widgets/buttons/p_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    Key? key,
    required this.job,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: RoundedContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
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
                          '${job.title}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor.withOpacity(0.7),
                              ),
                        ),
                        Text(
                          'Posted by ${job.postedBy?.name}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: AppColors.blackColor.withOpacity(0.8),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 0.5,
                color: AppColors.greyColor.withOpacity(0.4),
              ),
              SizedBox(height: 10),
              ReadMoreText(
                job.description,
                style: TextStyle(
                  color: AppColors.blackColor.withOpacity(0.8),
                  fontSize: 12,
                ),
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 10),
              Consumer<AppUser>(builder: (context, user, _) {
                return user.appliedJobs.contains(job.id)
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greyColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Ionicons.information_circle_sharp,
                              size: 16,
                              color: AppColors.accentColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Already applied to this job.',
                              style: TextStyle(
                                color: AppColors.accentColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: PElevatedButton(
                          height: 34,
                          label: 'Apply',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ApplyJobScreen(job: job)),
                            );
                          },
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
    );
  }
}
