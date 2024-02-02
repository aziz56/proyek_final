import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/Services/authservices.dart';
import 'package:firebase_flutter/auth_usecase.dart';
import 'package:firebase_flutter/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _firebase = FirebaseAuth.instance;

class Auth extends StatelessWidget {
  Auth({super.key});
  final _form = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/messages.png'),
              ),
              Consumer<AuthService>(
                builder: (context, authService, child) {
                  return Card(
                    margin: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _form,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!authService.getisLogin())
                                UserImagePicker(
                                  onPickImage: (pickedImage) {
                                    Provider.of<AuthService>(context, listen: false).changeAuthImage(pickedImage);
                                  },
                                ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Email Address'),
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return 'Please enter a valid email address.';
                                  }

                                  return null;
                                },
                              ),
                              if (!authService.getisLogin())
                                TextFormField(
                                  decoration:
                                  const InputDecoration(labelText: 'Username'),
                                  controller: _usernameController,
                                  enableSuggestions: false,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length < 4) {
                                      return 'Please enter at least 4 characters.';
                                    }
                                    return null;
                                  },
                                ),
                              TextFormField(
                                decoration:
                                const InputDecoration(labelText: 'Password'),
                                controller: _passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.trim().length < 6) {
                                    return 'Password must be at least 6 characters long.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              if (authService.getIsAuth())
                                const CircularProgressIndicator(),
                              if (!authService.getIsAuth())
                                ElevatedButton(
                                  onPressed: () {
                                    print("IS_LOGIN_SUBMIT: ${Provider.of<AuthService>(context, listen: false).getisLogin()}");
                                    AuthUseCases().submit(
                                        form: _form,
                                        context: context,
                                        enteredEmail: _emailController.text,
                                        enteredPassword: _passwordController.text,
                                        enteredUsername: _usernameController.text
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  child: Text(authService.getIsAuth() ? 'Login' : 'Signup'),
                                ),
                              if (!authService.getIsAuth())
                                TextButton(
                                  onPressed: () {

                                    Provider.of<AuthService>(context, listen: false).changeIsLogin();
                                    print("IS_LOGIN: ${Provider.of<AuthService>(context, listen: false).getIsAuth()}");
                                  },
                                  child: Text(authService.getisLogin()
                                      ? 'Create an account'
                                      : 'I already have an account'),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}