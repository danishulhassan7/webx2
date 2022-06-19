import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/labour.dart';
import 'package:mistriandlabours/services/labour_service.dart';
import 'package:mistriandlabours/ui/screens/labour/labour_profile_screen.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.labour}) : super(key: key);

  final Labour labour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Container(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: labour.photoUrl == null
                      ? Image.asset('asset/images/mh.png')
                      : CachedNetworkImage(
                          imageUrl: labour.photoUrl!,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        labour.displayName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.blackColor.withOpacity(0.8),
                            ),
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: labour.rating ?? 0,
                            minRating: 1,
                            itemPadding: EdgeInsets.zero,
                            direction: Axis.horizontal,
                            itemSize: 20,
                            updateOnDrag: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) async {
                              await context
                                  .read<LabourService>()
                                  .setLabour(labour.copyWith(rating: rating));
                            },
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${labour.rating ?? 0}",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Text(
                        'location:${labour.location}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style:
                          Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                    ),
                  ),
                  child: PElevatedButton(
                    label: 'View Profile',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LabourProfileScreen(
                            labour: labour,
                          ),
                        ),
                      );
                    },
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
