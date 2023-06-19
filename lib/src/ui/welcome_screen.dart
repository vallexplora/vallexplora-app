import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/constants/sizes.dart';
import 'package:vallexplora/src/constants/text_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(SizeResources.defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SizeResources.defaultSize,
                    ),
                    child: Text(
                      StringResources.welcomeTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SizeResources.defaultSize),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundColor: mayaBlue[50],
                      padding: const EdgeInsets.all(SizeResources.buttonHeight),
                      elevation: 0,
                    ),
                    child: const Text(
                      StringResources.register,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeResources.buttonTextSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: SizeResources.buttonHeight),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundColor: twNeutral[500],
                      padding: const EdgeInsets.all(SizeResources.buttonHeight),
                    ),
                    child: const Text(
                      StringResources.login,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeResources.buttonTextSize,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
