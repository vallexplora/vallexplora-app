import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/text_strings.dart';

import '../../constants/asset_uris.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class HeadingSection extends StatefulWidget {
  final String username;
  final Future<String> profilePictureURL;
  final String googlePictureURL;
  final int municipalitiesVisited;
  final String origin;

  const HeadingSection({
    super.key,
    required this.username,
    required this.profilePictureURL,
    required this.googlePictureURL,
    required this.municipalitiesVisited,
    required this.origin,
  });

  @override
  State<StatefulWidget> createState() => _HeadingSectionState();
}

class _HeadingSectionState extends State<HeadingSection> {
  late String username;
  late Future<String> profilePictureURL;
  late String googlePictureURL;
  late int municipalitiesVisited;
  late String origin;

  @override
  void initState() {
    super.initState();
    username = widget.username;
    profilePictureURL = widget.profilePictureURL;
    googlePictureURL = widget.googlePictureURL;
    municipalitiesVisited = widget.municipalitiesVisited;
    origin = widget.origin;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<String>(
                future: profilePictureURL,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return CircleAvatar(
                      backgroundColor: ColorResources.twNeutral[100],
                      radius: SizeResources.avatarRadiusOuter,
                      child: CircleAvatar(
                        radius: SizeResources.avatarRadiusInner,
                        backgroundColor: ColorResources.twNeutral[50],
                        backgroundImage: const AssetImage(
                          AssetURIResources.googleLogo,
                        ),
                      ),
                    );
                  }
                  return CircleAvatar(
                    backgroundColor: ColorResources.twNeutral[100],
                    radius: SizeResources.avatarRadiusOuter,
                    child: CircleAvatar(
                      radius: SizeResources.avatarRadiusInner,
                      backgroundImage: NetworkImage(snapshot.data!.isEmpty
                          ? googlePictureURL
                          : snapshot.data!),
                    ),
                  );
                }),
            const SizedBox(width: SizeResources.defaultSpacing),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
        Divider(
          height: SizeResources.defaultDividerHeight,
          color: ColorResources.twNeutral[400],
        ),
        Container(
          height: SizeResources.smallCardContainerHeight,
          padding: const EdgeInsets.only(
            left: SizeResources.defaultPadding,
            right: SizeResources.defaultPadding,
            top: SizeResources.defaultPadding,
          ),
          decoration: ShapeDecoration(
            color: ColorResources.mayaBlue[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                SizeResources.defaultBorderRadius,
              ),
              side: BorderSide(
                color: ColorResources.mayaBlue[600]!,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(municipalitiesVisited.toString()),
              const Text(
                StringResources.profileVisitedMunicipalities,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: SizeResources.defaultHeight,
        ),
        Container(
          height: SizeResources.smallCardContainerHeight,
          padding: const EdgeInsets.only(
            left: SizeResources.defaultPadding,
            right: SizeResources.defaultPadding,
            top: SizeResources.defaultPadding,
          ),
          decoration: ShapeDecoration(
            color: ColorResources.mayaBlue[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                SizeResources.defaultBorderRadius,
              ),
              side: BorderSide(
                color: ColorResources.mayaBlue[600]!,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                StringResources.profileOriginPlace(origin),
              ),
            ],
          ),
        ),
        Divider(
          height: SizeResources.defaultDividerHeight,
          color: ColorResources.twNeutral[400],
        ),
      ],
    );
  }
}
