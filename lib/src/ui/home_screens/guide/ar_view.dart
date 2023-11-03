import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ARView extends StatefulWidget {
  const ARView({super.key});

  @override
  State<ARView> createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  UnityWidgetController? _unityWidgetController;

  @override
  void initState() {
    super.initState();
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _unityWidgetController!.dispose();
  }
}
