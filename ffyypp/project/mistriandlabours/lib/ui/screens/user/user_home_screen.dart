import 'package:flutter/material.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/labour.dart';
import 'package:mistriandlabours/services/labour_service.dart';
import 'package:mistriandlabours/widgets/p_widgets.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String? _query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blackColor),
        backgroundColor: AppColors.whiteColor,
        title: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(),
          ),
          child: TextField(
            onChanged: (val) => _query = val,
            style: TextStyle(color: Colors.black),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search by location",
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.blackColor),
            onPressed: () {
              FocusScope.of(context).unfocus();
              setState(() {});
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Labour>>(
        stream: context.read<LabourService>().labourStream(queryStr: _query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final _labours = snapshot.data ?? [];

            if (_labours.isEmpty) {
              return Center(
                child: Text("No data found"),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
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
                          'Are you looking to hire laborer\'s, find experienced laborer\'s profile.',
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  ..._labours.map(
                    (labour) => UserCard(
                      labour: labour,
                    ),
                  ),
                  // UserCard(),
                ],
              ),
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
    );
  }
}
