import 'package:flutter/material.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/event/moon_created_event_widget.dart';
import 'package:moon_event/widgets/event/moon_joined_event_widget.dart';
import 'package:moon_event/widgets/event/moon_register_event_widget.dart';
class MoonEventScreen extends StatefulWidget {
  const MoonEventScreen({super.key});

  @override
  State<MoonEventScreen> createState() => _MoonEventScreenState();
}

class _MoonEventScreenState extends State<MoonEventScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Divider(
            color: Colors.grey[300],
            height: 0.5,
          ),
          // Custom Bar with Buttons
          Container(
            color: AppColors.getSecondaryColor(context),
            child: Row(
              children: [
                _buildNavItem("Registered", 0),
                _buildNavItem("Joined", 1),
                _buildNavItem("Created", 2),
              ],
            ),
          ),
          // // Expanded widget to constrain the height of the content
            Expanded(
              child: Builder(
                builder: (context) {
                switch (_selectedIndex) {
                  case 0:
                  return const MoonRegisterEventWidget();
                  case 1:
                  return const MoonJoinedEventWidget();
                  case 2:
                  return const MoonCreatedEventWidget();
                  default:
                  return Container();
                }
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    final isSelected = _selectedIndex == index;

    return Flexible(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: isSelected
              ? AppColors.primary
              : AppColors.getSecondaryColor(context),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
