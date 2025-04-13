import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testdf/common/utils/app_routes.dart';
import 'package:testdf/common/utils/environment.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/src/auth/controllers/auth_notifier.dart';
import 'package:testdf/src/auth/controllers/password_notifier.dart';
import 'package:testdf/src/categories/controllers/category_notifier.dart';
import 'package:testdf/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:testdf/src/home/controllers/home_tab_notifier.dart';
import 'package:testdf/src/onboarding/controllers/onboarding_notifier.dart';
import 'package:testdf/src/products/controllers/colors_sizes_notifier.dart';
import 'package:testdf/src/products/controllers/product_notifier.dart';
import 'package:testdf/src/splashscreen/views/splashscreen_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load the correct envoirenment
  await dotenv.load(fileName: Environment.fileName);

  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingNotifier()),
        ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
        ChangeNotifierProvider(create: (_) => HomeTabNotifier()),
        ChangeNotifierProvider(create: (_) => ProductNotifier()),
        ChangeNotifierProvider(create: (_) => ColorSizesNotifier()),
        ChangeNotifierProvider(create: (_) => PasswordNotifier()),
        ChangeNotifierProvider(create: (_) => AuthNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppText.kAppName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: router,
        );
      },
      child: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    );
  }
}
