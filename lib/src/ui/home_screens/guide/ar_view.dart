import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ARView extends StatefulWidget {
  final String information;

  const ARView({
    super.key,
    required this.information,
  });

  @override
  State<ARView> createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  UnityWidgetController? _unityWidgetController;
  late String information;

  @override
  void initState() {
    super.initState();
    information = widget.information;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          UnityWidget(
            onUnityCreated: onUnityCreated,
            fullscreen: false,
            unloadOnDispose: true,
            runImmediately: true,
          ),
          Positioned(
            bottom: 32,
            right: 16,
            left: 16,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Volver a la aplicación"),
            ),
          ),
        ],
      ),
    );
  }

  void onUnityCreated(controller) {
    _unityWidgetController = (controller as UnityWidgetController);
    _unityWidgetController!.isLoaded()!.then((loaded) {
      if (!loaded!) {
        _unityWidgetController!.create();
      }
      _unityWidgetController?.postMessage(
          "TextController", "SetComingText", information);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _unityWidgetController!.dispose();
  }
}
