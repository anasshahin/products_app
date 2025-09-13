import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/local data/shared_pref.dart';
import 'core/router/router.dart';
import 'core/router/router_path.dart';
import 'core/utils/service_locator.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
 await SharedPrefHelper.init();
  runApp( MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final user = getIt.get<FirebaseAuth>();
    if(user.currentUser == null){

    }else{

    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute:Routes.starting ,
   //   initialRoute: Routes.loginScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
