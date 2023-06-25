import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class SaleCard extends StatefulWidget {
  final String name;
  final String description;
  final String companyID;
  final Timestamp expirationDate;
  final bool stackable;
  final String place;

  const SaleCard({
    super.key,
    required this.name,
    required this.description,
    required this.companyID,
    required this.expirationDate,
    required this.stackable,
    required this.place,
  });

  @override
  State<StatefulWidget> createState() => _SaleCardState();
}

class _SaleCardState extends State<SaleCard> {
  late String name;
  late String description;
  late String companyID;
  late DateTime startDate;
  late bool stackable;
  late String place;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    companyID = widget.companyID;
    startDate = widget.expirationDate.toDate();
    stackable = widget.stackable;
    place = widget.place;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: ShapeDecoration(
        color: ColorResources.twNeutral[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: ColorResources.twNeutral[300]!,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 128,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: ShapeDecoration(
              color: ColorResources.mayaBlue[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$$stackable",
                ),
                Text(
                  place,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SizeResources.buttonHeight,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "${startDate.day}/${startDate.month}/${startDate.year}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
