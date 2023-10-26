import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/ui/register/onboarding_screen.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';

import 'package:vallexplora/src/blocs/auth/register_part_2_bloc.dart';
import 'package:vallexplora/src/utils/theme/extended.dart';

class RegisterPart2Screen extends StatefulWidget {
  const RegisterPart2Screen({super.key});

  @override
  State<RegisterPart2Screen> createState() => _RegisterPart2ScreenState();
}

class _RegisterPart2ScreenState extends State<RegisterPart2Screen> {
  final _bloc = RegisterPart2Bloc();

  @override
  void initState() {
    super.initState();
    _bloc.initialize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.initializeOriginDropDown(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.sRegister2Title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.sRegister2Subtitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder<String>(
                        stream: _bloc.selectedImage,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError ||
                              snapshot.hasData && snapshot.data! == "") {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                color: lightScheme.surfaceContainerHigh,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant),
                                  borderRadius: BorderRadius.circular(52),
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_rounded,
                                  size: 24,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {},
                              ),
                            );
                          } else {
                            if (snapshot.data!.contains("http")) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data!),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outlineVariant),
                                    borderRadius: BorderRadius.circular(52),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    size: 24,
                                    color: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    _bloc.pickImageFromGallery();
                                  },
                                ),
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(snapshot.data!),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outlineVariant),
                                    borderRadius: BorderRadius.circular(52),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    size: 24,
                                    color: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    _bloc.pickImageFromGallery();
                                  },
                                ),
                              );
                            }
                          }
                        }),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          AppLocalizations.of(context)!.sRegister2PhotoPick,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .merge(TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                StreamBuilder<String>(
                    stream: _bloc.selectedOrigin,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty &&
                          _bloc.originEntries.length == 45) {
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            label: Text(
                              AppLocalizations.of(context)!.sRegister2Origin,
                            ),
                          ),
                          value: snapshot.data,
                          items: _bloc.originEntries,
                          onChanged: (String? value) {
                            _bloc.changeSelectedOrigin(value!);
                          },
                        );
                      } else {
                        return DropdownButtonFormField(
                          decoration: InputDecoration(
                            label: Text(
                              AppLocalizations.of(context)!.sRegister2Origin,
                            ),
                          ),
                          value:
                              AppLocalizations.of(context)!.sRegister2SelectOne,
                          items: [
                            DropdownMenuItem(
                                value: AppLocalizations.of(context)!
                                    .sRegister2SelectOne,
                                child: Text(AppLocalizations.of(context)!
                                    .sRegister2SelectOne)),
                          ],
                          onChanged: (dynamic val) {},
                        );
                      }
                    }),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.sRegister2Interests,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                StreamBuilder<List<String>>(
                  stream: _bloc.categoryFilters,
                  builder: (context, categorySnapshot) {
                    if (categorySnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Wrap(
                        spacing: 8,
                        children: [
                          InputChip(
                            showCheckmark: false,
                            avatar: Icon(
                              Icons.sports_soccer_outlined,
                              color: (Theme.of(context)
                                      .extensions
                                      .entries
                                      .last
                                      .value as ExtendedColors)
                                  .categorySport
                                  .sys
                                  .color,
                            ),
                            label: Text(
                                AppLocalizations.of(context)!.gSportsCategory),
                            selected: categorySnapshot.data!.contains(
                                AppLocalizations.of(context)!.gSportsCategory),
                            onSelected: (value) {
                              setState(() {});
                              _bloc.modifyCategoryFilters(
                                  AppLocalizations.of(context)!
                                      .gSportsCategory);
                            },
                            selectedColor: (Theme.of(context)
                                    .extensions
                                    .entries
                                    .last
                                    .value as ExtendedColors)
                                .categorySport
                                .sys
                                .colorContainer,
                          ),
                          InputChip(
                            showCheckmark: false,
                            avatar: Icon(
                              Icons.eco_outlined,
                              color: (Theme.of(context)
                                      .extensions
                                      .entries
                                      .last
                                      .value as ExtendedColors)
                                  .categoryEco
                                  .sys
                                  .color,
                            ),
                            label: Text(
                                AppLocalizations.of(context)!.gEcoCategory),
                            selected: categorySnapshot.data!.contains(
                                AppLocalizations.of(context)!.gEcoCategory),
                            onSelected: (value) {
                              setState(() {});
                              _bloc.modifyCategoryFilters(
                                  AppLocalizations.of(context)!.gEcoCategory);
                            },
                            selectedColor: (Theme.of(context)
                                    .extensions
                                    .entries
                                    .last
                                    .value as ExtendedColors)
                                .categoryEco
                                .sys
                                .colorContainer,
                          ),
                          InputChip(
                            showCheckmark: false,
                            avatar: Icon(
                              Icons.palette_outlined,
                              color: (Theme.of(context)
                                      .extensions
                                      .entries
                                      .last
                                      .value as ExtendedColors)
                                  .categoryArt
                                  .sys
                                  .color,
                            ),
                            label: Text(
                                AppLocalizations.of(context)!.gArtCategory),
                            selected: categorySnapshot.data!.contains(
                                AppLocalizations.of(context)!.gArtCategory),
                            onSelected: (value) {
                              setState(() {});
                              _bloc.modifyCategoryFilters(
                                  AppLocalizations.of(context)!.gArtCategory);
                            },
                            selectedColor: (Theme.of(context)
                                    .extensions
                                    .entries
                                    .last
                                    .value as ExtendedColors)
                                .categoryArt
                                .sys
                                .colorContainer,
                          ),
                          InputChip(
                            showCheckmark: false,
                            avatar: Icon(
                              Icons.soup_kitchen_outlined,
                              color: (Theme.of(context)
                                      .extensions
                                      .entries
                                      .last
                                      .value as ExtendedColors)
                                  .categoryFood
                                  .sys
                                  .color,
                            ),
                            label: Text(
                                AppLocalizations.of(context)!.gGastroCategory),
                            selected: categorySnapshot.data!.contains(
                                AppLocalizations.of(context)!.gGastroCategory),
                            onSelected: (value) {
                              setState(() {});
                              _bloc.modifyCategoryFilters(
                                  AppLocalizations.of(context)!
                                      .gGastroCategory);
                            },
                            selectedColor: (Theme.of(context)
                                    .extensions
                                    .entries
                                    .last
                                    .value as ExtendedColors)
                                .categoryFood
                                .sys
                                .colorContainer,
                          ),
                          InputChip(
                            showCheckmark: false,
                            avatar: Icon(
                              Icons.church_outlined,
                              color: (Theme.of(context)
                                      .extensions
                                      .entries
                                      .last
                                      .value as ExtendedColors)
                                  .categoryArch
                                  .sys
                                  .color,
                            ),
                            label: Text(
                                AppLocalizations.of(context)!.gHistoryCategory),
                            selected: categorySnapshot.data!.contains(
                                AppLocalizations.of(context)!.gHistoryCategory),
                            onSelected: (value) {
                              setState(() {});
                              _bloc.modifyCategoryFilters(
                                  AppLocalizations.of(context)!
                                      .gHistoryCategory);
                            },
                            selectedColor: (Theme.of(context)
                                    .extensions
                                    .entries
                                    .last
                                    .value as ExtendedColors)
                                .categoryArch
                                .sys
                                .colorContainer,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      _bloc.finishRegistration();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnboardingScreen()),
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.gConfirmButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
