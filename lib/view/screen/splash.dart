import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  get appVersion => _BallBounceIndexState.appVersion;
  get appBuildNumber => _BallBounceIndexState.appBuildNumber;
  @override
  State<SplashScreen> createState() => _BallBounceIndexState();
}



class _BallBounceIndexState extends State<SplashScreen> {

  static String?  appVersion, appBuildNumber;

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  Future<void> getAppInfo() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("APP_NAME", appName);
    preferences.setString("PACKAGE_NAME", packageName);
    preferences.setString("APP_VERSION", version);
    preferences.setString("APP_BUILD_NUMBER", buildNumber);

    appVersion = preferences.getString("APP_VERSION");
    appBuildNumber = preferences.getString("APP_BUILD_NUMBER");

    debugPrint("version $appName $appVersion $appBuildNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          // This is to fill the entire stack
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                      child: Image.asset(
                    'assets/icon/icon.png',
                    height: 100,
                    width: 100,
                  )),
                ),
              )
                  .animate(
                onComplete: (_) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/books_list',ModalRoute.withName('/'),arguments: "splash"); // Navigate after animation
                },
              )
                  .slideY(begin: -0.5, end: 0.2, duration: 0.5.seconds)
                  .then(delay: 600.milliseconds)
                  .slideY(end: -0.3, duration: 0.5.seconds)
                  .then(delay: 600.milliseconds)
                  .slideY(end: 0.1, duration: 0.5.seconds)
                  .then(delay: 1.seconds)
                  .scaleXY(end: 20, duration: 2.seconds)
                  .then(delay: 2.seconds),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric( vertical: 20.0, horizontal: 8.0),
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: const FlutterLogo()
          //         .animate(
          //           onComplete: (_) {
          //             Navigator.pushNamedAndRemoveUntil(
          //                 context, '/books_list',ModalRoute.withName('/'),arguments: "splash"); // Navigate after animation
          //           },
          //         )
          //         .fadeIn(delay: 5.seconds, duration: 2500.milliseconds)
          //         .slideX(begin: 3, duration: 0.7.seconds),
          //   ),
          // ),
        ],
      ),
    );
  }
}
