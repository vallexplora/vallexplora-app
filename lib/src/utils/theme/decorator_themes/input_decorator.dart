import 'package:flutter/material.dart';

OutlineInputBorder outlineInputBorder(context) => OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
