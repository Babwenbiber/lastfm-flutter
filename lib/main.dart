import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lastfm/presentation/pages/home_page.dart';
import 'package:lastfm/utils/colors/app_colors.dart';
import 'package:lastfm/utils/injection/injection_container.dart';
import 'package:lastfm/utils/navigation/on_generate_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool init = false;
  @override
  void initState() {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      initDependencies(isDebug: false, preferences: sp);
      setState(() {
        init = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        primaryColorBrightness: Brightness.light,
        accentColor: AppColors.background,
        cardColor: Colors.transparent,
        brightness: Brightness.dark,
        canvasColor: AppColors.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (settings) {
        return onGenerateRoute(settings, context);
      },
      home: init ? HomePage() : CircularProgressIndicator(),
    );
  }
}
