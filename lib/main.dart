import 'dart:convert';

import 'package:core_dashboard/controllers/page_controller.dart';
import 'package:core_dashboard/controllers/performance_test_controller.dart';
import 'package:core_dashboard/pages/monitoring/widgets/mqtt_handler.dart';
import 'package:core_dashboard/shared/navigation/routes.dart';
import 'package:core_dashboard/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;
import 'dart:html' as html;

void main() async {
  await dotenv.load(fileName: "env");
  //api key injection to html
  var firebaseConfig = {
    "apiKey": dotenv.env['apiKey'],
    "authDomain": dotenv.env['authDomain'],
    "projectId": dotenv.env['projectId'],
    "storageBucket": dotenv.env['storageBucket'],
    "messagingSenderId": dotenv.env['messagingSenderId'],
    "appId": dotenv.env['appId'],
  };
  js.context['sterling'] = jsonEncode(firebaseConfig);
  html.document.dispatchEvent(html.CustomEvent("sterling"));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: dotenv.env['apiKey']!,
    appId: dotenv.env['appId']!,
    messagingSenderId: dotenv.env['messagingSenderId']!,
    projectId: dotenv.env['projectId']!,
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => PageIdController()),
    ChangeNotifierProvider(create: (_) => MqttHandler()),
    ChangeNotifierProvider(create: (_) => PerformanceTestController()),
  ], child: const EcofusionMobile()));
}

class EcofusionMobile extends StatelessWidget {
  const EcofusionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light(context),
      routerConfig: routerConfig,
    );
  }
}
