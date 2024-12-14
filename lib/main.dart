// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart' as svg;
import 'package:moon_event/screen/home_screen.dart';
import 'package:moon_event/screen/event_screen.dart';
import 'package:moon_event/screen/profile_screen.dart';
import 'package:moon_event/screen/scan_screen.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/secure_local_storage_util.dart';
import 'package:moon_event/utils/user_util.dart';
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



class MoonBottomNavigationBar extends ConsumerStatefulWidget {
  const MoonBottomNavigationBar({super.key});

  @override
  ConsumerState<MoonBottomNavigationBar> createState() => _MoonBottomNavigationBarState();
}

class _MoonBottomNavigationBarState extends ConsumerState<MoonBottomNavigationBar> {
  int _selectedIndex = 0;
  bool isLoggedIn = false;

  final List<Widget> _widgetOptions =<Widget>[
    const MoonHomeScreen(),
    const MoonEventScreen(),
    const MoonScanScreen(),
    const MoonProfileScreen(),
  ];
  
    @override
    void initState() {
      super.initState();
      _checkLoginStatus();
      fetchUserData(ref); // Fetch user data when the widget is initialized
    }
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    Future<void> _checkLoginAndNavigate(int index) async {
      if (index == 1 || index == 2) {
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
              color: _selectedIndex == 0 ? AppColors.primary : AppColors.textBlack,
              ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: svg.SvgPicture.asset(
              'assets/icons/event.svg',
              color: _selectedIndex == 1 ? AppColors.primary : AppColors.textBlack,
              ),
            label: 'My Event',
          ),
          BottomNavigationBarItem(
            icon: svg.SvgPicture.asset(
              'assets/icons/scan.svg',
              color: _selectedIndex == 2 ? AppColors.primary : AppColors.textBlack,
              ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon:  svg.SvgPicture.asset(
              'assets/icons/profile.svg',
              color: _selectedIndex == 3 ? AppColors.primary : AppColors.textBlack,
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
