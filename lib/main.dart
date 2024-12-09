import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart' as svg;
import 'package:moon_event/screen/home_screen.dart';
import 'package:moon_event/screen/event_screen.dart';
import 'package:moon_event/screen/profile_screen.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/secure_local_storage_util.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_custom_appbar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moon Event',
      theme: primaryTheme.copyWith(
        textTheme: AppTextTheme.getTextTheme(context), // Apply the text theme here
      ), // Apply the theme from theme.dart

      home: const MoonBottomNavigationBar(),
    );
  }
}



class MoonBottomNavigationBar extends StatefulWidget {
  const MoonBottomNavigationBar({super.key});

  @override
  State<MoonBottomNavigationBar> createState() => _MoonBottomNavigationBarState();
}

class _MoonBottomNavigationBarState extends State<MoonBottomNavigationBar> {
  int _selectedIndex = 0;
  bool isLoggedIn = false;

  final List<Widget> _widgetOptions =<Widget>[
    const MoonHomeScreen(),
    const MoonEventScreen(),
    const MoonProfileScreen(),
  ];
  

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    Future<void> _checkLoginAndNavigate(int index) async {
      if (index == 1) {
        _checkLoginStatus();
        if (!isLoggedIn) {
          _showLoginDialog();
          return;
        }
      }
      _onItemTapped(index);
    }

    void _checkLoginStatus() async {
      bool loggedIn = await isUserLoggedIn(); // Check login status asynchronously
      setState(() {
        isLoggedIn = loggedIn; // Update the state after getting the result
      });
  }

    void _showLoginDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const MoonAlertWidget(
            icon: Icons.error_outline,
            title: 'Error',
            description: 'Please log in before accessing the event.',
            typeError: true,
          );
        },
      );
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoonCustomAppBarWidget(),
      backgroundColor: AppColors.secondary,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: svg.SvgPicture.asset(
              'assets/icons/home.svg',
              // ignore: deprecated_member_use
              color: _selectedIndex == 0 ? AppColors.primary : AppColors.textBlack,
              ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: svg.SvgPicture.asset(
              'assets/icons/event.svg',
              // ignore: deprecated_member_use
              color: _selectedIndex == 1 ? AppColors.primary : AppColors.textBlack,
              ),
            label: 'My Event',
          ),
          BottomNavigationBarItem(
            icon:  svg.SvgPicture.asset(
              'assets/icons/profile.svg',
              // ignore: deprecated_member_use
              color: _selectedIndex == 2 ? AppColors.primary : AppColors.textBlack,
              ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textBlack,
        showUnselectedLabels: true,
        onTap: _checkLoginAndNavigate,
      ),
    );
  }
}

