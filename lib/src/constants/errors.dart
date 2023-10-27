import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Map<int, String> registerErrorCodes(context) => {
      0: AppLocalizations.of(context)!.sRegisterSuccess,
      1: AppLocalizations.of(context)!.sRegisterInvalidPass,
      2: AppLocalizations.of(context)!.sRegisterEmailTaken,
      -1: "Unknown firebase exception",
      3: "Data validation error",
    };

Map<int, String> loginErrorCodes(context) => {
  0: AppLocalizations.of(context)!.sLoginWelcomeToast,
  1: AppLocalizations.of(context)!.sLoginUserError,
  2: AppLocalizations.of(context)!.sLoginAuthorizeError,
  -1: "Unknown firebase exception",
  3: "Data validation error",
};
