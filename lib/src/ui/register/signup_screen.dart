import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/sizes.dart';
import 'package:vallexplora/src/constants/text_strings.dart';
import 'package:vallexplora/src/ui/register/signup_form_widget.dart';
import 'package:vallexplora/src/ui/welcome_screen.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var bloc = BlocProvider.of<SignUpBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crea tu cuenta"),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          child: Container(
            padding: const EdgeInsets.all(SizeResources.defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  StringResources.signUpTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SignUpFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
