import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vallexplora/src/blocs/profile/profile_bloc.dart';
import 'package:vallexplora/src/constants/colors.dart';

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final _bloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _bloc.changeNotificationsGeo(false);
    _bloc.changeNotificationsGlobal(false);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: ColorResources.mayaBlue[600],
          statusBarBrightness: Brightness.light),
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              stretch: true,
              onStretchTrigger: () {
                return Future<void>.value();
              },
              expandedHeight: 160.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.fadeTitle],
                titlePadding: const EdgeInsets.all(16),
                title: Text(
                  StringResources.profileTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              backgroundColor: ColorResources.twNeutral[50],
              surfaceTintColor: ColorResources.mayaBlue[600],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16, top: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      ColorResources.twNeutral[100],
                                  radius: 34,
                                  child: const CircleAvatar(
                                    radius: 32,
                                    backgroundImage: NetworkImage(
                                        "https://lh3.googleusercontent.com/a/ACg8ocKPR4_8YTgSnyar8qXFHUBJmeYR7AN-w07eojWc2EpCvybU=s288-c-no"),
                                  ),
                                ),
                                const SizedBox(
                                    width: SizeResources.defaultSize),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "USERNAME",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              height: 80,
                              color: ColorResources.twNeutral[400],
                            ),
                            Container(
                              height: 128,
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              decoration: ShapeDecoration(
                                color: ColorResources.mayaBlue[50],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: ColorResources.mayaBlue[600]!,
                                  ),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Text("Municipios visitados"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 128,
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              decoration: ShapeDecoration(
                                color: ColorResources.mayaBlue[50],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: ColorResources.mayaBlue[600]!,
                                  ),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Text("Soy de MUNICIPIO/PAÍS"),
                                ],
                              ),
                            ),
                            Divider(
                              height: 80,
                              color: ColorResources.twNeutral[400],
                            ),
                            Text(
                              "Información Personal",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nombre de usuario",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  autofillHints: const [
                                    AutofillHints.username,
                                  ],
                                  scrollPadding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        SizeResources.buttonTextSize * 8,
                                  ),
                                  decoration: const InputDecoration(
                                    label: Text(
                                        StringResources.signUpFormFullName),
                                    prefixIcon:
                                        Icon(Icons.person_outline_rounded),
                                  ),
                                  onChanged: (value) {
                                    _bloc.changeUsername(value);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Cambia tu contraseña",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 12),
                                  StreamBuilder<bool>(
                                    stream: _bloc.newPasswordVisible,
                                    builder: (context, snapshot) {
                                      return TextField(
                                        autofillHints: const [
                                          AutofillHints.password,
                                        ],
                                        obscureText: snapshot.data ?? true
                                            ? false
                                            : true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        scrollPadding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              SizeResources.buttonTextSize * 8,
                                        ),
                                        decoration: InputDecoration(
                                          label:
                                              const Text("Tu nueva contraseña"),
                                          prefixIcon:
                                              const Icon(Icons.key_rounded),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              snapshot.data ?? true
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              _bloc.changeNewPasswordVissible(
                                                  !snapshot.data!);
                                            },
                                          ),
                                        ),
                                        onChanged: (value) {
                                          _bloc.changeNewPassword(value);
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  StreamBuilder<bool>(
                                    stream: _bloc.confirmPasswordVisible,
                                    builder: (context, snapshot) {
                                      return TextField(
                                        autofillHints: const [
                                          AutofillHints.password,
                                        ],
                                        obscureText: snapshot.data ?? true
                                            ? false
                                            : true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        scrollPadding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              SizeResources.buttonTextSize * 8,
                                        ),
                                        decoration: InputDecoration(
                                          label: const Text(
                                              "Confírmala, por si las moscas"),
                                          prefixIcon:
                                              const Icon(Icons.key_rounded),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              snapshot.data ?? true
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              _bloc
                                                  .changeConfirmPasswordVisible(
                                                      !snapshot.data!);
                                            },
                                          ),
                                        ),
                                        onChanged: (value) {
                                          _bloc.changeConfirmPassword(value);
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  StreamBuilder<bool>(
                                    stream: _bloc.passwordVisible,
                                    builder: (context, snapshot) {
                                      return TextField(
                                        autofillHints: const [
                                          AutofillHints.password,
                                        ],
                                        obscureText: snapshot.data ?? true
                                            ? false
                                            : true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        scrollPadding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              SizeResources.buttonTextSize * 8,
                                        ),
                                        decoration: InputDecoration(
                                          label:
                                              const Text("Contraseña actual"),
                                          prefixIcon:
                                              const Icon(Icons.key_rounded),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              snapshot.data ?? true
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              _bloc.changePasswordVisible(
                                                  !snapshot.data!);
                                            },
                                          ),
                                        ),
                                        onChanged: (value) {
                                          _bloc.changePassword(value);
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    child: const Text(
                                      "Confirmar cambio de contraseña",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: SizeResources.buttonTextSize,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Cambia tu correo",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    autofillHints: const [
                                      AutofillHints.email,
                                    ],
                                    keyboardType: TextInputType.emailAddress,
                                    scrollPadding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom +
                                          SizeResources.buttonTextSize * 8,
                                    ),
                                    decoration: const InputDecoration(
                                      label:
                                          Text(StringResources.signUpFormEmail),
                                      prefixIcon:
                                          Icon(Icons.alternate_email_rounded),
                                    ),
                                    onChanged: (value) {
                                      _bloc.changeEmail(value);
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  StreamBuilder<bool>(
                                    stream: _bloc.passwordVisible,
                                    builder: (context, snapshot) {
                                      return TextField(
                                        autofillHints: const [
                                          AutofillHints.password,
                                        ],
                                        obscureText: snapshot.data ?? true
                                            ? false
                                            : true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        scrollPadding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              SizeResources.buttonTextSize * 8,
                                        ),
                                        decoration: InputDecoration(
                                          label:
                                              const Text("Contraseña actual"),
                                          prefixIcon:
                                              const Icon(Icons.key_rounded),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              snapshot.data ?? true
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              _bloc.changePasswordVisible(
                                                  !snapshot.data!);
                                            },
                                          ),
                                        ),
                                        onChanged: (value) {
                                          _bloc.changePassword(value);
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    child: const Text(
                                      "Confirmar cambio de correo",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: SizeResources.buttonTextSize,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 80,
                              color: ColorResources.twNeutral[400],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Notificaciones",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 12),
                                StreamBuilder<bool>(
                                    stream: _bloc.notificationsGlobal,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SwitchListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          title: const Text(
                                            "Notificaciones globales",
                                          ),
                                          secondary: Icon(
                                            snapshot.data!
                                                ? Icons.notifications_active
                                                : Icons
                                                    .notifications_off_outlined,
                                            color: snapshot.data!
                                                ? ColorResources.mayaBlue[600]
                                                : ColorResources.twNeutral[500],
                                          ),
                                          value: snapshot.data!,
                                          onChanged: (value) {
                                            _bloc.changeNotificationsGlobal(
                                                value);
                                          },
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                                const SizedBox(height: 12),
                                StreamBuilder<bool>(
                                    stream: _bloc.notificationsGeo,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SwitchListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          title: const Text(
                                            "Notificaciones de zona",
                                          ),
                                          secondary: Icon(
                                            snapshot.data!
                                                ? Icons.notifications_active
                                                : Icons
                                                    .notifications_off_outlined,
                                            color: snapshot.data!
                                                ? ColorResources.mayaBlue[600]
                                                : ColorResources.twNeutral[500],
                                          ),
                                          value: snapshot.data!,
                                          onChanged: (value) {
                                            _bloc.changeNotificationsGeo(value);
                                          },
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                                const SizedBox(height: 24),
                                Text(
                                  "Borrar tu cuenta",
                                  style: TextStyle(
                                    color: Colors.red.shade600,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Al borrar tu cuenta, se eliminarán todos sus datos, incluidos tus marcadores, puntos, premios y configuración. Esta acción no se puede deshacer.\n\n¿Estás seguro de que quieres eliminar tu cuenta de forma permanente?",
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    foregroundColor: const Color.fromARGB(
                                        255, 248, 243, 243),
                                    backgroundColor: Colors.redAccent,
                                    padding: const EdgeInsets.all(
                                        SizeResources.buttonHeight),
                                    elevation: 0,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeResources.buttonTextSize,
                                    ),
                                  ),
                                  child: const Text(
                                    "Borrar cuenta permanentemente",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeResources.buttonTextSize,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
