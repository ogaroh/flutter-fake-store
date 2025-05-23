import 'package:fake_store/injection.dart' show configureDependencies;
import 'package:flutter/material.dart';
import 'package:fake_store/app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

Future<void> runMainApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  ErrorWidget.builder = errorBuilderWidget;

  // Add your initialization code here
  await PersistentShoppingCart().init();
  configureDependencies();

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

Widget errorBuilderWidget(FlutterErrorDetails details) {
  return Material(
    child: Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("An Error Was Encountered"),
              const SizedBox(height: 32),
              Text(details.exception.toString()),
            ],
          ),
        ),
      ),
    ),
  );
}
