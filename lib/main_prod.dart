import 'package:fake_store/flavors.dart';
import 'main.dart';

// * Entry point for the prod flavor
void main() async {
  // Add environnement dependent code here
  // ...
  
  F.appFlavor = Flavor.prod;
  await runMainApp();
}
