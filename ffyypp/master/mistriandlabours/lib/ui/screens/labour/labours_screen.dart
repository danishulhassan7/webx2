import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/labour.dart';
import 'package:mistriandlabours/services/labour_service.dart';
import 'package:provider/provider.dart';

class LaboursScreen extends StatelessWidget {
  const LaboursScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Members')),
      body: StreamBuilder<List<Labour>>(
        stream: context.read<LabourService>().labourStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final labours = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: labours.length,
                itemBuilder: (context, index) {
                  final labour = labours[index];
                  return ListTile(
                    title: Text(labour.displayName ?? ''),
                    subtitle: Text(labour.about ?? ''),
                    trailing: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppColors.btnColor),
                      child: Text(
                        labour.member ?? '',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    leading: labour.photoUrl == null
                        ? Icon(Icons.person)
                        : CachedNetworkImage(
                            height: 40,
                            width: 40,
                            imageUrl: labour.photoUrl!,
                            fit: BoxFit.cover,
                          ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => LabourFormScreen(
                      //       labour: labour,
                      //     ),
                      //   ),
                      // );
                    },
                  );
                },
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
}
