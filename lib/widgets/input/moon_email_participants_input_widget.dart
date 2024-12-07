import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_event/theme.dart';

class MoonEmailParticipantsInputWidget extends StatefulWidget {
  final Map<String, String> userMap; // Key: UID, Value: Email
  final Function(List<String>) onParticipantsChanged;

  const MoonEmailParticipantsInputWidget({
    super.key,
    required this.userMap,
    required this.onParticipantsChanged,
  });

  @override
  State<MoonEmailParticipantsInputWidget> createState() => _MoonEmailParticipantsInputWidgetState();
}

class _MoonEmailParticipantsInputWidgetState extends State<MoonEmailParticipantsInputWidget> {
  final TextEditingController _inputController = TextEditingController();
  final List<String> _selectedUIDs = []; // Track selected UIDs
  late List<MapEntry<String, String>> _filteredSuggestions;

  @override
  void initState() {
    super.initState();
    _filteredSuggestions = widget.userMap.entries.toList(); // Initialize suggestions
  }

  void _addUser(String uid) {
    if (!_selectedUIDs.contains(uid)) {
      setState(() {
        _selectedUIDs.add(uid); // Add UID to the selected list
        _inputController.clear(); // Clear the input field
        _filteredSuggestions = widget.userMap.entries.toList(); // Reset suggestions
      });
      widget.onParticipantsChanged(_selectedUIDs); // Notify parent of the selected UIDs
    }
  }

  void _removeUser(String uid) {
    setState(() {
      _selectedUIDs.remove(uid); // Remove UID from the selected list
    });
    widget.onParticipantsChanged(_selectedUIDs); // Notify parent of the updated UIDs
  }

  void _onSearchChanged(String value) {
    setState(() {
      _filteredSuggestions = widget.userMap.entries
          .where((entry) =>
              entry.value.toLowerCase().contains(value.toLowerCase()))
          .toList(); // Filter suggestions based on email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected Participants (as Chips)
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _selectedUIDs.map((uid) {
            return Chip(
              label: Text(widget.userMap[uid] ?? 'Unknown'),
              onDeleted: () => _removeUser(uid),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // Input Field with Suggestions
        TextFormField(
          controller: _inputController,
          // decoration: InputDecoration(
          //   labelText: "Add Participants",
          //   hintText: "Type an email",
          //   border: OutlineInputBorder(),
          // ),
          decoration: InputDecoration(
          labelText:  "Add Participants",
          labelStyle: TextStyle(
            fontFamily: GoogleFonts.kantumruyPro().fontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: AppColors.textBlack, // Adjust to your AppAppColors
          ),
          hintText: "Type an email",
          hintStyle: TextStyle(
            fontFamily: GoogleFonts.kantumruyPro().fontFamily,
            fontWeight: FontWeight.w100, // Set font weight to normal
            fontSize: 16,
            color: AppColors.textBlack, // Adjust to your AppAppColors
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray), // Adjust to your AppAppColors
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray), // Adjust to your AppAppColors
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red), // Adjust to your AppAppColors
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red), // Adjust to your AppAppColors
          ),
        ),
          onChanged: _onSearchChanged,
        ),
        const SizedBox(height: 5),
        // Suggestions List
        if (_filteredSuggestions.isNotEmpty)
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: _filteredSuggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _filteredSuggestions[index];
                return ListTile(
                  title: Text(suggestion.value), // Display email
                  onTap: () => _addUser(suggestion.key), // Use UID as value
                );
              },
            ),
          ),
      ],
    );
  }
}
