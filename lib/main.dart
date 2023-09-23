import 'package:attendance/theme/dark_theme.dart';
import 'package:attendance/theme/light_theme.dart';
import 'package:attendance/utils/assets.dart';
import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'package:get/get.dart';
import 'core/di/get_di.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.routes,
      initialRoute: rsDefaultPage,
      title: appName,
      theme: light(),
      darkTheme: dark(),
    );
  }
}
