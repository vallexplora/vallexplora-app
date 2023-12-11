import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vallexplora/src/app.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TogglesAndDangerZone extends StatefulWidget {
  final Stream<bool> notificationsGlobal;
  final ValueSetter<bool> changeNotificationsGlobal;
  final Stream<bool> notificationsGeo;
  final ValueSetter<bool> changeNotificationsGeo;
  final Stream<int> deleteAccountStep;
  final ValueSetter<int> changeDeleteAccountStep;
  final ValueSetter<bool> changePasswordVisible;
  final ValueSetter<String> changePassword;
  final Stream<bool> passwordVisible;
  final Function logout;

  const TogglesAndDangerZone({
    super.key,
    required this.notificationsGlobal,
    required this.changeNotificationsGlobal,
    required this.notificationsGeo,
    required this.changeNotificationsGeo,
    required this.deleteAccountStep,
    required this.changeDeleteAccountStep,
    required this.changePassword,
    required this.changePasswordVisible,
    required this.passwordVisible,
    required this.logout,
  });

  @override
  State<StatefulWidget> createState() => _TogglesAndDangerZoneState();
}

class _TogglesAndDangerZoneState extends State<TogglesAndDangerZone> {
  late Stream<bool> notificationsGlobal;
  late ValueSetter<bool> changeNotificationsGlobal;
  late Stream<bool> notificationsGeo;
  late ValueSetter<bool> changeNotificationsGeo;
  late Stream<int> deleteAccountStep;
  late ValueSetter<int> changeDeleteAccountStep;
  late ValueSetter<bool> changePasswordVisible;
  late ValueSetter<String> changePassword;
  late Stream<bool> passwordVisible;
  late Function logout;

  @override
  void initState() {
    super.initState();
    notificationsGlobal = widget.notificationsGlobal;
    changeNotificationsGlobal = widget.changeNotificationsGlobal;
    notificationsGeo = widget.notificationsGeo;
    changeNotificationsGeo = widget.changeNotificationsGeo;
    deleteAccountStep = widget.deleteAccountStep;
    changeDeleteAccountStep = widget.changeDeleteAccountStep;
    changePasswordVisible = widget.changePasswordVisible;
    changePassword = widget.changePassword;
    passwordVisible = widget.passwordVisible;
    logout = widget.logout;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<Locale>(
          value: Localizations.localeOf(context),
          onChanged: (locale) {
            if (locale != null) {
              App.setLocale(context, locale);
            }
          },
          items: AppLocalizations.supportedLocales.map((locale) {
            return DropdownMenuItem(
              value: locale,
              child: Text(AppLocalizations.of(context)!
                  .sProfileLanguage(locale.languageCode)),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 16,
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
                      16,
                    ),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.sProfileNotificationsGlobal,
                  ),
                  secondary: Icon(
                    snapshot.data!
                        ? Icons.notifications_active
                        : Icons.notifications_off_outlined,
                    color: snapshot.data!
                        ? primaryRef.value50
                        : neutralRef.value50,
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
          height: 16,
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
                      12,
                    ),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.sProfileNotificationsGeo,
                  ),
                  secondary: Icon(
                    snapshot.data!
                        ? Icons.notifications_active
                        : Icons.notifications_off_outlined,
                    color: snapshot.data!
                        ? primaryRef.value50
                        : neutralRef.value50,
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
          height: 32,
        ),
        TextButton(
          onPressed: () {
            logout().then((value) {
              Navigator.popUntil(context, (route) => route.isFirst);
              return Fluttertoast.showToast(
                  msg: AppLocalizations.of(context)!.gBye,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
          },
          child: Text(
            AppLocalizations.of(context)!.sProfileLogout,
            style: Theme.of(context).textTheme.labelLarge!.merge(
                  TextStyle(color: Theme.of(context).colorScheme.error),
                ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.merge(
                ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onError,
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.error,
                    )),
              ),
          child: Text(
            AppLocalizations.of(context)!.sProfileDeleteAccountButton,
          ),
          onPressed: () {
            openDialog();
          },
        ),
      ],
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            icon: Icon(
              Icons.report_problem_outlined,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              AppLocalizations.of(context)!.sDeleteDialogTitle,
              style: Theme.of(context).textTheme.headlineSmall!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
            ),
            surfaceTintColor: errorRef.value98,
            content: SizedBox(
              height: 364,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sDeleteDialogBody,
                      style: Theme.of(context).textTheme.bodyMedium!.merge(
                            TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.sDeleteDialogPrompt,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                                TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        StreamBuilder<bool>(
                          stream: passwordVisible,
                          builder: (context, snapshot) {
                            return TextField(
                              autofillHints: const [
                                AutofillHints.password,
                              ],
                              obscureText: snapshot.data ?? true ? false : true,
                              keyboardType: TextInputType.visiblePassword,
                              scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom +
                                    Theme.of(context).buttonTheme.height * 8,
                              ),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                                label: Text(AppLocalizations.of(context)!
                                    .sLoginPassword),
                                focusColor: Theme.of(context).colorScheme.error,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    snapshot.data ?? true
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  onPressed: () {
                                    changePasswordVisible(!snapshot.data!);
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                changePassword(value);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.gCancelButton,
                  style: Theme.of(context).textTheme.labelLarge!.merge(
                        TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.gConfirmButton,
                  style: Theme.of(context).textTheme.labelLarge!.merge(
                        TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                ),
              ),
            ],
          );
        }),
      );
}
