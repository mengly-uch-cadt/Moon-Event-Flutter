import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/model/get_user.dart';

class MoonEmailParticipantsInputWidget extends StatefulWidget {
  final List<GetUser> userList; // List of GetUser objects
  final List<String>? preSelectedUIDs; // Pre-selected UIDs for edit mode
  final Function(List<String>) onParticipantsChanged; // Callback for UID list

  const MoonEmailParticipantsInputWidget({
    super.key,
    required this.userList,
    this.preSelectedUIDs,
    required this.onParticipantsChanged,
  });

  @override
  State<MoonEmailParticipantsInputWidget> createState() =>
      _MoonEmailParticipantsInputWidgetState();
}

class _MoonEmailParticipantsInputWidgetState
    extends State<MoonEmailParticipantsInputWidget> {
  final TextEditingController _inputController = TextEditingController();
  late List<String> _selectedUIDs; // Track selected UIDs
  late List<GetUser> _filteredSuggestions;

  @override
  void initState() {
    super.initState();
    // Initialize with pre-selected UIDs or empty
    _selectedUIDs = widget.preSelectedUIDs ?? [];
    _filteredSuggestions = widget.userList; // Initialize suggestions with the user list
  }

  void _addUser(String uid) {
    if (!_selectedUIDs.contains(uid)) {
      setState(() {
        _selectedUIDs.add(uid); // Add UID to the selected list
        _inputController.clear(); // Clear the input field
        _filteredSuggestions = widget.userList; // Reset suggestions
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
      _filteredSuggestions = widget.userList
          .where((user) =>
              user.email.toLowerCase().contains(value.toLowerCase()))
          .toList(); // Filter suggestions based on email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        // Selected Participants (as Chips)
        Wrap(
          spacing: 0,
          runSpacing: 0,
          children: _selectedUIDs.map((uid) {
            // Find the corresponding email for the UID or handle missing user
            final user = widget.userList.firstWhere(
              (user) => user.uid == uid,
              orElse: () => GetUser(uid: uid, email: "Unknown"),
            );
            return Chip(
              label: Text(user.email),
              onDeleted: () => _removeUser(uid),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // Input Field with Suggestions
        TextFormField(
          controller: _inputController,
          decoration: InputDecoration(
            labelText: "Add Participants",
            labelStyle: TextStyle(
              fontFamily: GoogleFonts.kantumruyPro().fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: AppColors.textBlack, // Adjust to your AppColors
            ),
            hintText: "Type an email",
            hintStyle: TextStyle(
              fontFamily: GoogleFonts.kantumruyPro().fontFamily,
              fontWeight: FontWeight.w100, // Set font weight to normal
              fontSize: 16,
              color: AppColors.textBlack, // Adjust to your AppColors
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray), // Adjust to your AppColors
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray), // Adjust to your AppColors
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red), // Adjust to your AppColors
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red), // Adjust to your AppColors
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
                  title: Text(suggestion.email), // Display email
                  onTap: () => _addUser(suggestion.uid), // Use UID as value
                );
              },
            ),
          ),
      ],
    );
  }
}
