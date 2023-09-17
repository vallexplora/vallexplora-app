import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/text_strings.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class NotificationsDangerZone extends StatefulWidget {
  final Stream<bool> notificationsGlobal;
  final ValueSetter<bool> changeNotificationsGlobal;
  final Stream<bool> notificationsGeo;
  final ValueSetter<bool> changeNotificationsGeo;
  final Stream<int> deleteAccountStep;
  final ValueSetter<int> changeDeleteAccountStep;

  const NotificationsDangerZone({
    super.key,
    required this.notificationsGlobal,
    required this.changeNotificationsGlobal,
    required this.notificationsGeo,
    required this.changeNotificationsGeo,
    required this.deleteAccountStep,
    required this.changeDeleteAccountStep,
  });

  @override
  State<StatefulWidget> createState() => _NotificationsDangerZoneState();
}

class _NotificationsDangerZoneState extends State<NotificationsDangerZone> {
  late Stream<bool> notificationsGlobal;
  late ValueSetter<bool> changeNotificationsGlobal;
  late Stream<bool> notificationsGeo;
  late ValueSetter<bool> changeNotificationsGeo;
  late Stream<int> deleteAccountStep;
  late ValueSetter<int> changeDeleteAccountStep;

  @override
  void initState() {
    super.initState();
    notificationsGlobal = widget.notificationsGlobal;
    changeNotificationsGlobal = widget.changeNotificationsGlobal;
    notificationsGeo = widget.notificationsGeo;
    changeNotificationsGeo = widget.changeNotificationsGeo;
    deleteAccountStep = widget.deleteAccountStep;
    changeDeleteAccountStep = widget.changeDeleteAccountStep;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          StringResources.profileNotifications,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: SizeResources.smallHeight,
        ),
        StreamBuilder<bool>(
            stream: notificationsGlobal,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizeResources.smallHeight,
                    ),
                  ),
                  title: const Text(
                    StringResources.profileGlobalNotifications,
                  ),
                  secondary: Icon(
                    snapshot.data!
                        ? Icons.notifications_active
                        : Icons.notifications_off_outlined,
                    color: snapshot.data!
                        ? ColorResources.mayaBlue[600]
                        : ColorResources.twNeutral[500],
                  ),
                  value: snapshot.data!,
                  onChanged: (value) {
                    changeNotificationsGlobal(value);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        const SizedBox(
          height: SizeResources.smallHeight,
        ),
        StreamBuilder<bool>(
            stream: notificationsGeo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizeResources.smallHeight,
                    ),
                  ),
                  title: const Text(
                    StringResources.profileGeoNotifications,
                  ),
                  secondary: Icon(
                    snapshot.data!
                        ? Icons.notifications_active
                        : Icons.notifications_off_outlined,
                    color: snapshot.data!
                        ? ColorResources.mayaBlue[600]
                        : ColorResources.twNeutral[500],
                  ),
                  value: snapshot.data!,
                  onChanged: (value) {
                    changeNotificationsGeo(value);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        const SizedBox(height: 24),
        const Divider(
          height: SizeResources.defaultDividerHeight,
        ),
        Text(
          StringResources.profileDeleteAccount,
          style: Theme.of(context).textTheme.titleLarge!.merge(
                TextStyle(color: Colors.red.shade600),
              ),
        ),
        const SizedBox(
          height: SizeResources.smallHeight,
        ),
        Text(
          StringResources.profileDeleteAccountDisclaimer,
          style: TextStyle(
            color: Colors.red.shade400,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: SizeResources.smallHeight,
        ),
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.merge(
                ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 248, 243, 243)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent)),
              ),
          child: const Text(
            StringResources.profileDeleteAccountButton,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: SizeResources.buttonTextSize,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
