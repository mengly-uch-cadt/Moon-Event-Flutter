import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' as svg;
import 'package:moon_event/screen/home_screen.dart';
import 'package:moon_event/screen/joined_screen.dart';
import 'package:moon_event/screen/profile_screen.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_custom_appbar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moon Event',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      MoonHomeScreen(),
      const MoonJoinedScreen(),
      MoonProfileScreen(onLoginSuccess: () => _onItemTapped(0)),
    ];
  }

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
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
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
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
                'assets/icons/connection.svg',
                // ignore: deprecated_member_use
                color: _selectedIndex == 1 ? AppColors.primary : AppColors.textBlack,
                ),
              label: 'Joined',
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
          onTap: _onItemTapped,
        ),
      );
    }
}
