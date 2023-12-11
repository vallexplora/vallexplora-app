import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants/asset_uris.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class HeadingSection extends StatefulWidget {
  final String username;
  final ValueSetter<String> changeUsername;
  final Future<String> profilePictureURL;
  final String googlePictureURL;
  final int municipalitiesVisited;
  final String origin;
  final bool isGoogleAccount;
  final Stream<bool> editingUsername;
  final ValueSetter<bool> changeEditingUsername;
  final int pointsTotal;

  const HeadingSection({
    super.key,
    required this.username,
    required this.changeUsername,
    required this.profilePictureURL,
    required this.googlePictureURL,
    required this.municipalitiesVisited,
    required this.origin,
    required this.isGoogleAccount,
    required this.editingUsername,
    required this.changeEditingUsername,
    required this.pointsTotal,
  });

  @override
  State<StatefulWidget> createState() => _HeadingSectionState();
}

class _HeadingSectionState extends State<HeadingSection> {
  late String username;
  late ValueSetter<String> changeUsername;
  late Future<String> profilePictureURL;
  late String googlePictureURL;
  late int municipalitiesVisited;
  late String origin;
  late bool isGoogleAccount;
  late Stream<bool> editingUsername;
  late ValueSetter<bool> changeEditingUsername;
  late int pointsTotal;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    username = widget.username;
    changeUsername = widget.changeUsername;
    profilePictureURL = widget.profilePictureURL;
    googlePictureURL = widget.googlePictureURL;
    municipalitiesVisited = widget.municipalitiesVisited;
    origin = widget.origin;
    isGoogleAccount = widget.isGoogleAccount;
    editingUsername = widget.editingUsername;
    changeEditingUsername = widget.changeEditingUsername;
    pointsTotal = widget.pointsTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: profilePictureURL,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return CircleAvatar(
                    backgroundColor: neutralRef.value92,
                    radius: SizeResources.avatarRadiusOuter,
                    child: CircleAvatar(
                      radius: SizeResources.avatarRadiusInner,
                      backgroundColor: neutralRef.value96,
                      backgroundImage: const AssetImage(
                        AssetURIResources.googleLogo,
                      ),
                    ),
                  );
                }
                return CircleAvatar(
                  backgroundColor: neutralRef.value92,
                  radius: SizeResources.avatarRadiusOuter,
                  child: CircleAvatar(
                    radius: SizeResources.avatarRadiusInner,
                    backgroundImage: NetworkImage(snapshot.data!.isEmpty
                        ? googlePictureURL
                        : snapshot.data!),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "$pointsTotal ${AppLocalizations.of(context)!.sProfileCurrentPoints}",
              style: Theme.of(context).textTheme.titleLarge!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "$pointsTotal ${AppLocalizations.of(context)!.sProfileTotalPoints}",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder<bool>(
                stream: editingUsername,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _textController,
                    autofillHints: const [
                      AutofillHints.username,
                    ],
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          Theme.of(context).buttonTheme.height * 8,
                    ),
                    decoration: InputDecoration(
                      label: (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!)
                          ? Text(
                              "${AppLocalizations.of(context)!.sProfileUsername}$username")
                          : Center(
                              child: Text(username),
                            ),
                      suffixIcon: (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!)
                          ? IconButton(
                              icon: const Icon(Icons.save_outlined),
                              onPressed: () {
                                if (_textController.text.isNotEmpty) {
                                  changeEditingUsername(false);
                                  username = _textController.text;
                                  _textController.clear();
                                  setState(() {});
                                }
                              },
                            )
                          : const Icon(Icons.edit_outlined),
                      enabledBorder: const UnderlineInputBorder(),
                      focusedBorder: const UnderlineInputBorder(),
                    ),
                    onChanged: (value) {
                      changeUsername(value);
                    },
                    onTap: () {
                      changeEditingUsername(true);
                    },
                    onTapOutside: (event) {
                      changeEditingUsername(false);
                      changeUsername(username);
                      _textController.clear();
                    },
                  );
                }),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _cardBuilder(
                title: AppLocalizations.of(context)!.sProfileVisited,
                sub:
                    "$municipalitiesVisited ${AppLocalizations.of(context)!.sProfileTowns}"),
            const SizedBox(
              width: 16,
            ),
            _cardBuilder(
                title: AppLocalizations.of(context)!.sProfileOrigin,
                sub: origin),
          ],
        ),
        const Divider(
          height: 32,
        ),
      ],
    );
  }

  Widget _cardBuilder({required String title, required String sub}) {
    return Expanded(
      child: Container(
        height: 96,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.merge(
                      TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                sub,
                style: Theme.of(context).textTheme.bodyMedium!.merge(
                      TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
