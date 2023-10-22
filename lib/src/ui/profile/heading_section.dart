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
                }),
            const SizedBox(height: SizeResources.smallHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .merge(TextStyle(color: neutralRef.value60)),
                ),
                const SizedBox(
                  width: SizeResources.smallHeight,
                ),
                Icon(
                  Icons.edit_outlined,
                  color: primaryRef.value50,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: SizeResources.smallCardContainerHeight,
              width: SizeResources.smallCardContainerHeight,
              decoration: ShapeDecoration(
                color: primaryRef.value50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SizeResources.defaultBorderRadius,
                  ),
                  side: BorderSide(
                    color: primaryRef.value50,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    StringResources.profileVisitedMunicipalities,
                    style: Theme.of(context).textTheme.bodySmall!.merge(
                          const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  ),
                  const SizedBox(
                    height: SizeResources.smallHeight,
                  ),
                  Text(
                    municipalitiesVisited.toString(),
                    style: Theme.of(context).textTheme.displayMedium!.merge(
                          TextStyle(
                            color: primaryRef.value92,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              height: SizeResources.smallCardContainerHeight,
              width: SizeResources.smallCardContainerHeight,
              decoration: ShapeDecoration(
                color: primaryRef.value50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SizeResources.defaultBorderRadius,
                  ),
                  side: BorderSide(
                    color: primaryRef.value50,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    StringResources.profileOriginPlace,
                    style: Theme.of(context).textTheme.bodySmall!.merge(
                          const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  ),
                  const SizedBox(
                    height: SizeResources.smallHeight,
                  ),
                  Text(
                    origin,
                    style: Theme.of(context).textTheme.displayMedium!.merge(
                          TextStyle(
                            color: primaryRef.value92,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
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
