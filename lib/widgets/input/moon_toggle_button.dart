import 'package:flutter/material.dart';

class MoonToggleButton extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;

  const MoonToggleButton({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.thumbColor = Colors.white,
  });

  @override
  State<MoonToggleButton> createState() => _MoonToggleButtonState();
}

class _MoonToggleButtonState extends State<MoonToggleButton> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue; // Initialize with the given value
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOn = !isOn; // Toggle the state
        });
        widget.onChanged(isOn); // Pass the updated value to the parent
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 27,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isOn ? widget.activeColor : widget.inactiveColor, // Change background color
        ),
        alignment: isOn ? Alignment.centerRight : Alignment.centerLeft, // Align thumb
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.thumbColor, // Thumb color
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
