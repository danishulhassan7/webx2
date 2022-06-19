import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/labour.dart';
import 'package:mistriandlabours/services/labour_service.dart';
import 'package:mistriandlabours/ui/screens/labour/labour_form_screen.dart';
import 'package:provider/provider.dart';

class ALabourScreen extends StatelessWidget {
  const ALabourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Labours'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LabourFormScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<Labour>>(
          stream: context.read<LabourService>().labourStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _labours = snapshot.data ?? [];

              if (_labours.isEmpty) {
                return Center(
                  child: Text("No data found"),
                );
              }

              return ListView.builder(
                itemCount: _labours.length,
                itemBuilder: ((context, index) {
                  final _labour = _labours[index];

                  return Card(
                    child: Slidable(
                      key: ValueKey(_labour.id),
                      endActionPane: ActionPane(
                        extentRatio: 0.5,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => _show(context, _labour),
                            backgroundColor: AppColors.accentColor,
                            foregroundColor: Colors.white,
                            icon: Ionicons.eye_outline,
                          ),
                          SlidableAction(
                            onPressed: (_) => _edit(context, _labour),
                            backgroundColor: AppColors.btnColor,
                            foregroundColor: Colors.white,
                            icon: Ionicons.create_outline,
                          ),
                          SlidableAction(
                            onPressed: (_) => _delete(context, _labour),
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
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: _labour.photoUrl == null
                              ? Icon(Ionicons.business_outline)
                              : CachedNetworkImage(
                                  imageUrl: _labour.photoUrl!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        title: Row(
                          children: [
                            Text(_labour.displayName ?? ''),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: _labour.rating ?? 0,
                                  minRating: 1,
                                  itemPadding: EdgeInsets.zero,
                                  direction: Axis.horizontal,
                                  itemSize: 14,
                                  updateOnDrag: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => Icon(
                                    Ionicons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) async {
                                    await context
                                        .read<LabourService>()
                                        .setLabour(
                                            _labour.copyWith(rating: rating));
                                  },
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${_labour.rating ?? 0}",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                        subtitle: Text(
                          _labour.phoneNumber ?? 'No phone number',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  _edit(BuildContext context, Labour labour) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LabourFormScreen(
          labour: labour,
        ),
      ),
    );
  }

  _show(BuildContext context, Labour labour) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LabourFormScreen(
          viewOnly: true,
          labour: labour,
        ),
      ),
    );
  }

  _delete(BuildContext context, Labour labour) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete labour'),
          content: Text(
            'Are you sure you want to delete this labour?',
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                context.read<LabourService>().deleteLabour(labour.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Labour deleted successfully'),
                    duration: Duration(seconds: 2),
                    backgroundColor: AppColors.greenColor,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
