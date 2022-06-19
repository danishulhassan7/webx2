import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/models/app_roles.dart';
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
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text('Do you want to logout?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () async {
                          await context.read<BaseAuth>().signOut();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
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
                          if (context.read<AppUser>().role == AppRoles.admin &&
                              _user.id != context.read<AppUser>().id)
                            SlidableAction(
                              onPressed: (_) => _lock(context, _user),
                              backgroundColor: AppColors.redColor,
                              foregroundColor: Colors.white,
                              icon: _user.isActive
                                  ? Ionicons.lock_closed_outline
                                  : Ionicons.lock_open_outline,
                            ),
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
                        trailing: _user.role == AppRoles.admin
                            ? null
                            : _user.isActive
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.greenColor,
                                    ),
                                    child: Text(
                                      'Active',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                              color: AppColors.whiteColor),
                                    ),
                                  )
                                : Container(
                                    child: Text(
                                      'Disabled',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                              color: AppColors.whiteColor),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.btnColor,
                                    ),
                                  ),
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

  _lock(BuildContext context, AppUser user) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text(
              'Do you want to ${user.isActive ? 'disable' : 'enable'} this user?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await context.read<UserService>().updateUser(
                      user.copyWith(isActive: !user.isActive),
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
