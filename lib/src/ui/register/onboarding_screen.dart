import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vallexplora/src/constants/asset_uris.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/ui/home_container_screen.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';

import '../../blocs/auth/onboarding_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _bloc = OnboardingBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 86),
        child: PageView(
          controller: _bloc.controller,
          onPageChanged: (index) => _bloc.changePage(index),
          children: [
            buildOnBoardingPage(
              color: Theme.of(context).primaryColor,
              imageURI: AssetURIResources.onboarding1,
              title: AppLocalizations.of(context)!.sOnboarding1Title,
              copy: AppLocalizations.of(context)!.sOnboarding1Copy,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            buildOnBoardingPage(
              color: Theme.of(context).colorScheme.surface,
              imageURI: AssetURIResources.onboarding2,
              title: AppLocalizations.of(context)!.sOnboarding2Title,
              copy: AppLocalizations.of(context)!.sOnboarding2Copy,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
            buildOnBoardingPage(
              color: lightScheme.primaryFixed,
              imageURI: AssetURIResources.vallexploraLogo,
              title: AppLocalizations.of(context)!.sOnboarding3Title,
              copy: AppLocalizations.of(context)!.sOnboarding3Copy,
              foregroundColor: lightScheme.onPrimaryFixed,
            ),
          ],
        ),
      ),
      bottomSheet: StreamBuilder<int>(
          stream: _bloc.page,
          builder: (context, snapshot) {
            return Container(
              height: 96,
              color: _bloc.colors(context)[snapshot.data ?? 0],
              padding: const EdgeInsets.only(bottom: 16, left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: _bloc.controller,
                      count: 3,
                      effect: SlideEffect(
                        type: SlideType.slideUnder,
                        spacing: 8,
                        dotHeight: 10,
                        dotWidth: 10,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 2,
                        dotColor:
                            _bloc.foregrounds(context)[snapshot.data ?? 0]!,
                        activeDotColor:
                            _bloc.foregrounds(context)[snapshot.data ?? 0]!,
                      ),
                      onDotClicked: (index) => _bloc.controller.animateToPage(
                        index,
                        curve: Curves.decelerate,
                        duration: const Duration(
                          milliseconds: 200, /* 2 measures at 124 bpm */
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _bloc.controller.jumpToPage(2);
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(
                              _bloc.foregrounds(context)[snapshot.data ?? 0]!,
                            ),
                            side: MaterialStatePropertyAll(
                              BorderSide(
                                color: _bloc
                                    .foregrounds(context)[snapshot.data ?? 0]!,
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.gSkipButton,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: FilledButton.tonal(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              _bloc.tonals(context)[snapshot.data ?? 0]!,
                            ),
                            foregroundColor: MaterialStatePropertyAll(
                              _bloc.tonalForegrounds(
                                  context)[snapshot.data ?? 0]!,
                            ),
                          ),
                          onPressed: () {
                            if ((snapshot.data ?? 0) == 2) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HomeContainerScreen()),
                              );
                            } else {
                              _bloc.controller.nextPage(
                                curve: Curves.decelerate,
                                duration: const Duration(
                                  milliseconds: 200, /* 2 measures at 124 bpm */
                                ),
                              );
                            }
                          },
                          child: Text(
                            (snapshot.data ?? 0) == 2
                                ? AppLocalizations.of(context)!.gFinishButton
                                : AppLocalizations.of(context)!.gNextButton,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget buildOnBoardingPage({
    required Color color,
    required String imageURI,
    required String title,
    required String copy,
    required Color foregroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        top: 64,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.merge(
                      TextStyle(
                        color: foregroundColor,
                      ),
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              Image(
                image: AssetImage(imageURI),
                height: 256,
                width: 256,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                copy,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.merge(
                      TextStyle(
                        color: foregroundColor,
                      ),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
