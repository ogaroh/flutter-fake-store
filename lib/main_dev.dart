import 'package:fake_store/flavors.dart';
import 'main.dart';

// * Entry point for the dev flavor
void main() async {
  // Add environnement dependent code here
  // ...
  
  F.appFlavor = Flavor.dev;
  await runMainApp();
}
