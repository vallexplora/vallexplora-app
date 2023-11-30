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
  }

  @override
  void dispose() {
    _bloc.uploadStreams();
    super.dispose();
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
              } else if (userSnapshot.hasError ||
                  !userSnapshot.hasData ||
                  userSnapshot.data == null) {
                return Center(
                    child: Text(
                  "Error: ${userSnapshot.error}",
                  textAlign: TextAlign.center,
                ));
              }
              _bloc.changeNotificationsGeo(userSnapshot.data!.geoNotifications);
              _bloc.changeNotificationsGlobal(
                  userSnapshot.data!.globalNotifications);
              _bloc.changeCategories(userSnapshot.data!.interests.cast());
              _bloc.changeUsername(userSnapshot.data!.displayName);
              _bloc.changeMunicipalities(
                  userSnapshot.data!.municipalitiesVisited);
              _bloc.changeOriginPlace(userSnapshot.data!.origin);
              return DraggableScrollableSheet(
                initialChildSize: 0.85,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
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
                                  color: neutralRef.value70,
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
                                changeUsername: _bloc.changeUsername,
                                profilePictureURL:
                                    _bloc.getProfilePictureDownloadURL(
                                        userSnapshot.data!.pictureURL),
                                googlePictureURL: _bloc.getDownloadedPicURL(),
                                municipalitiesVisited:
                                    userSnapshot.data?.municipalitiesVisited ??
                                        0,
                                origin: userSnapshot.data!.origin,
                                isGoogleAccount: _bloc.isGoogleAccount(),
                                editingUsername: _bloc.editingUsername,
                                changeEditingUsername:
                                    _bloc.changeEditingUsername,
                                pointsTotal:
                                    userSnapshot.data?.pointsTotal ?? 0,
                              ),
                              PersonalInformation(
                                categories: _bloc.categories,
                                modifyCategoryFilters:
                                    _bloc.modifyCategoryFilters,
                              ),
                              TogglesAndDangerZone(
                                notificationsGlobal: _bloc.notificationsGlobal,
                                changeNotificationsGlobal:
                                    _bloc.changeNotificationsGlobal,
                                notificationsGeo: _bloc.notificationsGeo,
                                changeNotificationsGeo:
                                    _bloc.changeNotificationsGeo,
                                deleteAccountStep: _bloc.deleteAccountStep,
                                changeDeleteAccountStep:
                                    _bloc.changeDeleteAccountStep,
                                changePassword: _bloc.changePassword,
                                changePasswordVisible:
                                    _bloc.changePasswordVisible,
                                passwordVisible: _bloc.passwordVisible,
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
