import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vallexplora/src/blocs/profile/profile_bloc.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/ui/profile/heading_section.dart';
import 'package:vallexplora/src/ui/profile/notifications_danger_zone.dart';
import 'package:vallexplora/src/ui/profile/personal_information.dart';

import '../../constants/text_strings.dart';
import '../../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final _bloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _bloc.changeNotificationsGeo(false);
    _bloc.changeNotificationsGlobal(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("ProfileScreen"),
      body: FutureBuilder<Stream<UserModel>>(
        future: _bloc.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Text("Error: ${snapshot.error}");
          }
          Stream<UserModel> userInfo = snapshot.data!;
          return StreamBuilder<UserModel>(
            stream: userInfo,
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Text("Error: ${snapshot.error}");
              }
              _bloc.changeNotificationsGeo(userSnapshot.data!.geoNotifications);
              _bloc.changeNotificationsGlobal(
                  userSnapshot.data!.globalNotifications);
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarColor: ColorResources.mayaBlue[600],
                    statusBarBrightness: Brightness.light),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      stretch: true,
                      onStretchTrigger: () {
                        return Future<void>.value();
                      },
                      expandedHeight: 160.0,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const [StretchMode.fadeTitle],
                        titlePadding: const EdgeInsets.all(16),
                        title: Text(
                          StringResources.profileTitle,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      backgroundColor: ColorResources.twNeutral[50],
                      surfaceTintColor: ColorResources.mayaBlue[600],
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Listener(
                            behavior: HitTestBehavior.opaque,
                            onPointerDown: (_) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16, top: 32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeadingSection(
                                    username: userSnapshot.data!.displayName,
                                    profilePictureURL:
                                        _bloc.getProfilePictureDownloadURL(
                                            userSnapshot.data!.pictureURL),
                                    googlePictureURL:
                                        _bloc.getDownloadedPicURL(),
                                    municipalitiesVisited: userSnapshot
                                        .data!.municipalitiesVisited,
                                    origin: userSnapshot.data!.origin,
                                  ),
                                  PersonalInformation(
                                    username: userSnapshot.data!.displayName,
                                    email: userSnapshot.data!.email,
                                    changeUsername: _bloc.changeUsername,
                                    uploadUsername: _bloc.uploadUsername,
                                    newPasswordVisible:
                                        _bloc.newPasswordVisible,
                                    changeNewPasswordVisible:
                                        _bloc.changeNewPasswordVisible,
                                    confirmPasswordVisible:
                                        _bloc.confirmPasswordVisible,
                                    changeConfirmPasswordVisible:
                                        _bloc.changeConfirmPasswordVisible,
                                    passwordVisible: _bloc.passwordVisible,
                                    changePasswordVisible:
                                        _bloc.changePasswordVisible,
                                    changeNewPassword: _bloc.changeNewPassword,
                                    changeConfirmPassword:
                                        _bloc.changeConfirmPassword,
                                    changePassword: _bloc.changePassword,
                                    uploadPassword: _bloc.uploadPassword,
                                    changeEmail: _bloc.changeEmail,
                                    uploadEmail: _bloc.uploadEmail,
                                    isGoogleAccount: _bloc.isGoogleAccount(),
                                  ),
                                  NotificationsDangerZone(
                                    notificationsGlobal:
                                        _bloc.notificationsGlobal,
                                    changeNotificationsGlobal:
                                        _bloc.updateNotificationsGlobal,
                                    notificationsGeo: _bloc.notificationsGeo,
                                    changeNotificationsGeo:
                                        _bloc.updateNotificationsGeo,
                                    deleteAccountStep: _bloc.deleteAccountStep,
                                    changeDeleteAccountStep:
                                        _bloc.changeDeleteAccountStep,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
