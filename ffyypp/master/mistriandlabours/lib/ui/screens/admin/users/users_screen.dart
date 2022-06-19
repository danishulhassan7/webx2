import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/services/auth_service.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:mistriandlabours/ui/screens/admin/users/edit_user.dart';
import 'package:provider/provider.dart';

class AUsersScreen extends StatelessWidget {
  const AUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Ionicons.log_out_outline),
            onPressed: () {
              Provider.of<BaseAuth>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<AppUser>>(
          stream: context.read<UserService>().usersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _users = snapshot.data ?? [];

              if (_users.isEmpty) {
                return Center(
                  child: Text("No data found"),
                );
              }

              return ListView.builder(
                itemCount: _users.length,
                itemBuilder: ((context, index) {
                  final _user = _users[index];

                  return Card(
                    child: Slidable(
                      key: ValueKey(_user.id),
                      endActionPane: ActionPane(
                        extentRatio: 0.5,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => _edit(context, _user),
                            backgroundColor: AppColors.btnColor,
                            foregroundColor: Colors.white,
                            icon: Ionicons.create_outline,
                          ),
                          SlidableAction(
                            onPressed: (_) => _show(context, _user),
                            backgroundColor: AppColors.accentColor,
                            foregroundColor: Colors.white,
                            icon: Ionicons.eye_outline,
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: _user.photoUrl == null
                              ? Icon(Ionicons.business_outline)
                              : CachedNetworkImage(
                                  imageUrl: _user.photoUrl!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        title: Text(_user.displayName ?? ''),
                        subtitle: Text(
                          '${_user.email}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: AppColors.blackColor.withOpacity(0.8),
                              ),
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

  _show(BuildContext context, AppUser user) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => EditUserScreen(appUser: user, isViewOnly: true)),
    );
  }

  _edit(BuildContext context, AppUser user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditUserScreen(appUser: user)),
    );
  }

  _delete(BuildContext context, AppUser user) {}
}
