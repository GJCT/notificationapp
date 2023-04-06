import 'package:flutter/material.dart';
import 'package:notification/screens/screens.dart';
import 'package:notification/services/push.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationServices.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationServices.messageStream.listen((message) {
      print('MyApp: $message');
      final snackBar = SnackBar(content: Text(message));
      scaffoldMessengerKey.currentState?.showSnackBar(snackBar);

      navigatorKey.currentState?.pushNamed('message', arguments: message);
     });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routes: {
        'home':    ( _) => const HomeScreen(),
        'message': ( _) => const MessageScreen() 
      },
    );
  }
}