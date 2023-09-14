import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vallexplora/src/blocs/auth/login_bloc.dart';

import '../../constants/text_strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final _bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light),
      child: Scaffold(
        body: Column(
          children: [
            Text(StringResources.profileTitle),
            TextField(),
          ],
        ),
      ),
    );
  }
}
