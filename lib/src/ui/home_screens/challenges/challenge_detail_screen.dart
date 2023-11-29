import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final String id;
  final String name;
  final String description;
  final int points;
  final String place;
  final DateTime expirationDate;
  final int type;
  final Stream<String> proofImage;
  final Function pickImageFromGallery;
  final ValueSetter<String> changeProofImage;
  final Function(String, int) markAsDone;

  const ChallengeDetailScreen({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.place,
    required this.type,
    required this.expirationDate,
    required this.proofImage,
    required this.pickImageFromGallery,
    required this.changeProofImage,
    required this.markAsDone,
  });

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  late String id;
  late String name;
  late String description;
  late int points;
  late String place;
  late DateTime expirationDate;
  late int type;
  late Stream<String> proofImage;
  late Function pickImageFromGallery;
  late ValueSetter<String> changeProofImage;
  late Function(String, int) markAsDone;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    name = widget.name;
    description = widget.description;
    points = widget.points;
    expirationDate = widget.expirationDate;
    place = widget.place;
    type = widget.type;
    proofImage = widget.proofImage;
    pickImageFromGallery = widget.pickImageFromGallery;
    changeProofImage = widget.changeProofImage;
    markAsDone = widget.markAsDone;
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
      child: DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(
            16,
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
                    height: 24,
                  ),
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .merge(TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "$points puntos",
                    style:
                        Theme.of(context).textTheme.titleLarge!.merge(TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        place,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            )),
                      ),
                      Text(
                        "${type == -1 ? "Venció el" : "Vence el"} ${DateFormat.yMd(Localizations.localeOf(context).languageCode).format(expirationDate)}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    description,
                    style:
                        Theme.of(context).textTheme.bodyLarge!.merge(TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            )),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder(
                    stream: proofImage,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError ||
                          snapshot.hasData && snapshot.data! == "") {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 172,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton.filled(
                                      icon: const Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        pickImageFromGallery();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Este desafío requiere que subas una foto en el lugar",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .merge(TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  )),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 172,
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
                                          .outline),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton.filled(
                                      icon: const Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        pickImageFromGallery();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Este desafío requiere que subas una foto en el lugar",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .merge(TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  )),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 64),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: type == 1
                                ? null
                                : () {
                                    changeProofImage("");
                                    markAsDone(id, points);
                                    Navigator.of(context).pop();
                                  },
                            child: type == 1
                                ? const Text("¡Hecho!")
                                : const Text("¡Completado!"),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              changeProofImage("");
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cerrar"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    changeProofImage("");
    super.dispose();
  }
}
