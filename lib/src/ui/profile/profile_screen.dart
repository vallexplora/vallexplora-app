import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/profile/profile_bloc.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/constants/sizes.dart';
import 'package:vallexplora/src/ui/profile/heading_section.dart';
import 'package:vallexplora/src/ui/profile/notifications_danger_zone.dart';
import 'package:vallexplora/src/ui/profile/personal_information.dart';

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
    Widget makeDismissable({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );

    return makeDismissable(
      child: FutureBuilder<Stream<UserModel>>(
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
              return DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.5,
                builder: (_, controller) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top:
                            Radius.circular(SizeResources.defaultBorderRadius)),
                  ),
                  padding: const EdgeInsets.all(
                    SizeResources.defaultPadding,
                  ),
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: ListView(
                        physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast,
                        ),
                        controller: controller,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: Container(
                                  height: 4,
                                  width: 56,
                                  color: ColorResources.twNeutral[300]!,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 56,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadingSection(
                                username: userSnapshot.data!.displayName,
                                profilePictureURL:
                                    _bloc.getProfilePictureDownloadURL(
                                        userSnapshot.data!.pictureURL),
                                googlePictureURL: _bloc.getDownloadedPicURL(),
                                municipalitiesVisited:
                                    userSnapshot.data!.municipalitiesVisited,
                                origin: userSnapshot.data!.origin,
                              ),
                              PersonalInformation(
                                username: userSnapshot.data!.displayName,
                                email: userSnapshot.data!.email,
                                changeUsername: _bloc.changeUsername,
                                uploadUsername: _bloc.uploadUsername,
                                newPasswordVisible: _bloc.newPasswordVisible,
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
                                notificationsGlobal: _bloc.notificationsGlobal,
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
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
