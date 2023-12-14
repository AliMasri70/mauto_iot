import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mauto_iot/Home/homeElementDetail/detailsPageElement.dart';
import 'package:mauto_iot/Home/homeMainPage.dart';
import 'package:mauto_iot/IOTDashboard/configPages/buttonConfigs.dart';
import 'package:mauto_iot/IOTDashboard/elements/ElementsScreen.dart';
import 'package:mauto_iot/IOTDashboard/mainIOT.dart';
import 'package:mauto_iot/IOTDashboard/mqttConnection/connectionList.dart';
import 'package:mauto_iot/SignUp/SignUpPage.dart';
import 'package:mauto_iot/onBoarding/first_page.dart';
import 'package:mauto_iot/signIn/SignInMainPage.dart';
import 'package:mauto_iot/signIn/forgetPassword/forgetPage.dart';
import 'package:mauto_iot/signIn/forgetPassword/otpPage.dart';
import 'package:mauto_iot/signIn/forgetPassword/resetPassword.dart';
import 'package:mauto_iot/utils/ConnectionListProvider.dart';
import 'package:mauto_iot/utils/IOTListProvider.dart';
import 'package:mauto_iot/utils/colorsApp.dart';
import 'package:mauto_iot/utils/regulatorProvider.dart';
import 'package:mauto_iot/utils/rotaryProvider.dart';
import 'package:mauto_iot/utils/sliderStateprovider.dart';
import 'package:mauto_iot/utils/topicProvider.dart';

import 'package:mauto_iot/utils/variablesProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RotaryState(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegulatorWidgetState(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => WidgetModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectionListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopicListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VariableListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SliderState(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MainColor),
          useMaterial3: true,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(
              name: '/',
              page: () => MainIOT(),
              transition: Transition.rightToLeft),
          // GetPage(
          //     name: '/',
          //     page: () => ConnectionList(),
          //     transition: Transition.rightToLeft),
          // GetPage(
          // name: '/',
          // page: () => FirstPage(),
          // transition: Transition.rightToLeft),
          GetPage(
              name: '/signinPage',
              page: () => SignInMainPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: '/SignUpPage',
              page: () => SignUpMainPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: '/ForgetPassPage',
              page: () => ForgetPassPage(),
              transition: Transition.downToUp),
          GetPage(
              name: '/otpPage',
              page: () => OtpPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: '/resetPass',
              page: () => ResetPassword(),
              transition: Transition.rightToLeft),
          GetPage(
              name: '/HomeMainPage',
              page: () => HomeMainPage(),
              transition: Transition.native),
          GetPage(
              name: '/IOTWidgetListPage',
              page: () => ElementsScreen(),
              transition: Transition.fade),
          GetPage(
              name: '/ButtonConfigsPage',
              page: () => ButtonConfigs(),
              transition: Transition.fade),
        ],
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: ConnectionList(),
    );
  }
}
