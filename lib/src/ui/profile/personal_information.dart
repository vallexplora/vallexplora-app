import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/text_strings.dart';

import '../../constants/sizes.dart';

class PersonalInformation extends StatefulWidget {
  final String username;
  final String email;
  final ValueSetter<String> changeUsername;
  final VoidCallback uploadUsername;
  final Stream<bool> newPasswordVisible;
  final ValueSetter<bool> changeNewPasswordVisible;
  final Stream<bool> confirmPasswordVisible;
  final ValueSetter<bool> changeConfirmPasswordVisible;
  final Stream<bool> passwordVisible;
  final ValueSetter<bool> changePasswordVisible;
  final ValueSetter<String> changeNewPassword;
  final ValueSetter<String> changeConfirmPassword;
  final ValueSetter<String> changePassword;
  final Function(String) uploadPassword;
  final ValueSetter<String> changeEmail;
  final Function(String) uploadEmail;

  final bool isGoogleAccount;

  const PersonalInformation({
    super.key,
    required this.username,
    required this.email,
    required this.changeUsername,
    required this.uploadUsername,
    required this.newPasswordVisible,
    required this.changeNewPasswordVisible,
    required this.confirmPasswordVisible,
    required this.changeConfirmPasswordVisible,
    required this.passwordVisible,
    required this.changePasswordVisible,
    required this.changeNewPassword,
    required this.changeConfirmPassword,
    required this.changePassword,
    required this.uploadPassword,
    required this.changeEmail,
    required this.uploadEmail,
    required this.isGoogleAccount,
  });

  @override
  State<StatefulWidget> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late String username;
  late String email;
  late ValueSetter<String> changeUsername;
  late VoidCallback uploadUsername;
  late Stream<bool> newPasswordVisible;
  late ValueSetter<bool> changeNewPasswordVisible;
  late Stream<bool> confirmPasswordVisible;
  late ValueSetter<bool> changeConfirmPasswordVisible;
  late Stream<bool> passwordVisible;
  late ValueSetter<bool> changePasswordVisible;
  late ValueSetter<String> changeNewPassword;
  late ValueSetter<String> changeConfirmPassword;
  late ValueSetter<String> changePassword;
  late Function(String) uploadPassword;
  late ValueSetter<String> changeEmail;
  late Function(String) uploadEmail;
  late bool isGoogleAccount;

  @override
  void initState() {
    super.initState();
    username = widget.username;
    email = widget.email;
    changeUsername = widget.changeUsername;
    uploadUsername = widget.uploadUsername;
    newPasswordVisible = widget.newPasswordVisible;
    changeNewPasswordVisible = widget.changeNewPasswordVisible;
    confirmPasswordVisible = widget.confirmPasswordVisible;
    changeConfirmPasswordVisible = widget.changeConfirmPasswordVisible;
    passwordVisible = widget.passwordVisible;
    changePasswordVisible = widget.changePasswordVisible;
    uploadPassword = widget.uploadPassword;
    changeEmail = widget.changeEmail;
    uploadEmail = widget.uploadEmail;
    isGoogleAccount = widget.isGoogleAccount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          StringResources.profilePersonalInfo,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: SizeResources.defaultHeight,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringResources.profileUsername,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: SizeResources.smallHeight,
            ),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    autofillHints: const [
                      AutofillHints.username,
                    ],
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          SizeResources.bottomScrollPadding,
                    ),
                    decoration: InputDecoration(
                      label: Text(username),
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                    ),
                    onChanged: (value) {
                      changeUsername(value);
                    },
                  ),
                  const SizedBox(
                    height: SizeResources.smallHeight,
                  ),
                  ElevatedButton(
                    child: const Text(
                      StringResources.profileConfirmUsernameButton,
                    ),
                    onPressed: () {
                      uploadUsername();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SizeResources.defaultHeight,
        ),
        if (!isGoogleAccount)
          Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      StringResources.profilePassword,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: SizeResources.smallHeight,
                    ),
                    StreamBuilder<bool>(
                      stream: newPasswordVisible,
                      builder: (context, snapshot) {
                        return TextField(
                          autofillHints: const [
                            AutofillHints.password,
                          ],
                          obscureText: snapshot.data ?? true ? false : true,
                          keyboardType: TextInputType.visiblePassword,
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.bottomScrollPadding,
                          ),
                          decoration: InputDecoration(
                            label: const Text(
                              StringResources.profileNewPassword,
                            ),
                            prefixIcon: const Icon(Icons.key_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(
                                snapshot.data ?? true
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                changeNewPasswordVisible(!snapshot.data!);
                              },
                            ),
                          ),
                          onChanged: (value) {
                            changeNewPassword(value);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: SizeResources.smallHeight,
                    ),
                    StreamBuilder<bool>(
                      stream: confirmPasswordVisible,
                      builder: (context, snapshot) {
                        return TextField(
                          autofillHints: const [
                            AutofillHints.password,
                          ],
                          obscureText: snapshot.data ?? true ? false : true,
                          keyboardType: TextInputType.visiblePassword,
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.bottomScrollPadding,
                          ),
                          decoration: InputDecoration(
                            label: const Text(
                              StringResources.profileConfirmPassword,
                            ),
                            prefixIcon: const Icon(Icons.key_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(
                                snapshot.data ?? true
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                changeConfirmPasswordVisible(!snapshot.data!);
                              },
                            ),
                          ),
                          onChanged: (value) {
                            changeConfirmPassword(value);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: SizeResources.defaultHeight,
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
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.bottomScrollPadding,
                          ),
                          decoration: InputDecoration(
                            label: const Text(
                              StringResources.profileCurrentPassword,
                            ),
                            prefixIcon: const Icon(Icons.key_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(
                                snapshot.data ?? true
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                    const SizedBox(height: 12),
                    ElevatedButton(
                      child: const Text(
                        StringResources.profileConfirmPasswordButton,
                      ),
                      onPressed: () {
                        uploadPassword(email);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SizeResources.defaultHeight,
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      StringResources.profileEmail,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: SizeResources.smallHeight,
                    ),
                    TextFormField(
                      autofillHints: const [
                        AutofillHints.email,
                      ],
                      keyboardType: TextInputType.emailAddress,
                      scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            SizeResources.bottomScrollPadding,
                      ),
                      decoration: InputDecoration(
                        label: Text(email),
                        prefixIcon: const Icon(Icons.alternate_email_rounded),
                      ),
                      onChanged: (value) {
                        changeEmail(value);
                      },
                    ),
                    const SizedBox(
                      height: SizeResources.defaultHeight,
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
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.bottomScrollPadding,
                          ),
                          decoration: InputDecoration(
                            label: const Text(
                                StringResources.profileCurrentPassword),
                            prefixIcon: const Icon(Icons.key_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(
                                snapshot.data ?? true
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                    const SizedBox(height: SizeResources.smallHeight),
                    ElevatedButton(
                      child: const Text(
                        StringResources.profileConfirmEmailButton,
                      ),
                      onPressed: () {
                        uploadEmail(email);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        const Divider(
          height: SizeResources.defaultDividerHeight,
        ),
      ],
    );
  }
}
