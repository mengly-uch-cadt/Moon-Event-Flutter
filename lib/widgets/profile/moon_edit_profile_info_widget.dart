// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/user.dart';
import 'package:moon_event/services/user_service.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/input/moon_text_field_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MoonEditProfileInfoWidget extends ConsumerStatefulWidget {
  const MoonEditProfileInfoWidget({super.key});

  @override
  ConsumerState<MoonEditProfileInfoWidget> createState() => _MoonEditProfileInfoWidgetState();
}

class _MoonEditProfileInfoWidgetState extends ConsumerState<MoonEditProfileInfoWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  XFile? _image;

  final ImagePicker _picker = ImagePicker();
  final UserService _userService = UserService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    if (user != null) {
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _bioController.text = user.bio ?? '';
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(userProvider);
    if (user == null) {
      showDialog(
        context: context,
        builder: (ctx) => const MoonAlertWidget(
          icon: Icons.error_outline,
          title: 'Error',
          description: 'User data is not available.',
          typeError: true,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      ResponseResult responseResult = await _userService.updateUserInformation(
        uid: user.uid!,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        bio: _bioController.text.isEmpty ? '' : _bioController.text,
        profileImage: _image != null ? File(_image!.path) : File(''), // Use a placeholder if no image selected        email: user.email,
        notificationsEnabled: user.notificationsEnabled,
        email: user.email,
      );

      setState(() {
        _isLoading = false;
      });

      if (responseResult.isSuccess) {
        final updatedUser = responseResult.data as User;
        ref.read(userProvider.notifier).setUserData(updatedUser);
        showDialog(
          context: context,
          builder: (ctx) => MoonAlertWidget(
            icon: Icons.check_circle_outline,
            title: 'Success',
            description: responseResult.message,
            typeError: false,
          ),
        ).then((_) {
          Navigator.of(context).pop();
        });
      } else {
        showDialog(
          context: context,
          builder: (ctx) => MoonAlertWidget(
            icon: Icons.error_outline,
            title: 'Error',
            description: responseResult.message,
            typeError: true,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (ctx) => MoonAlertWidget(
          icon: Icons.error_outline,
          title: 'Error',
          description: e.toString(),
          typeError: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoonTitleWidget(firstTitle: "Edit", secondTitle: "Profile"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                          image: _image != null
                              ? DecorationImage(
                                  image: FileImage(File(_image!.path)),
                                  fit: BoxFit.cover,
                                )
                              : ref.read(userProvider)?.profilePictureUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(ref.read(userProvider)!.profilePictureUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                        ),
                        child: _image == null && ref.read(userProvider)?.profilePictureUrl == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey[700],
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MoonTextFieldWidget(
                      controller: _firstNameController,
                      labelText: "Firstname",
                      hintText: "Enter your firstname",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your firstname';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MoonTextFieldWidget(
                      controller: _lastNameController,
                      labelText: 'Lastname',
                      hintText: "Enter your lastname",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your lastname';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MoonTextFieldWidget(
                      controller: _bioController,
                      labelText: 'Bio',
                      hintText: "Enter your bio",
                    ),
                    const SizedBox(height: 20),
                    MoonButtonWidget(
                      onPressed: _onSave,
                      text: "Save",
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

}
