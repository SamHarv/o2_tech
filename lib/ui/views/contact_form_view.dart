import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:o2_tech/logic/services/email_service.dart';
import 'package:o2_tech/logic/services/url_launcher.dart';
import 'package:o2_tech/ui/widgets/textfield_widget.dart';

import '../../config/constants.dart';
import '../../logic/services/adaptive_font.dart';
import '../widgets/fade_in_widget.dart';

class ContactFormView extends StatefulWidget {
  const ContactFormView({super.key});

  @override
  State<ContactFormView> createState() => _ContactFormViewState();
}

class _ContactFormViewState extends State<ContactFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _challengeController = TextEditingController();
  bool _isLoading = false;

  // List of challenges with answers
  final List<Map<String, String>> _challenges = [
    {'question': 'What color is the sky on a clear day?', 'answer': 'blue'},
    {'question': 'How many legs does a cat have?', 'answer': '4'},
    {'question': 'What is the opposite of hot?', 'answer': 'cold'},
    {'question': 'What do you call frozen water?', 'answer': 'ice'},
    {'question': 'What is 7 + 8?', 'answer': '15'},
  ];

  late Map<String, String> _currentChallenge;

  void _updateChallenge() {
    setState(() {
      _currentChallenge = _challenges[Random().nextInt(_challenges.length)];
    });
  }

  @override
  void initState() {
    _currentChallenge =
        _challenges[DateTime.now().microsecond % _challenges.length];
    super.initState();
  }

  // Validate the challenge answer (case-insensitive)
  bool _isValidChallengeAnswer() {
    return _challengeController.text.trim().toLowerCase() ==
        _currentChallenge['answer']!.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Beamer.of(context).beamToNamed("/home");
          },
          icon: Icon(Icons.navigate_before),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // App Title
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: mediaWidth - 48),
                      child: FadeInWidget(
                        widgetToFadeIn: Text(
                          "Contact",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: AdaptiveFontSize.getFontSize(
                                context,
                                24,
                              ),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open Sans",
                              color: white,
                              shadows: [
                                Shadow(color: blue, blurRadius: 3),
                                Shadow(color: blue, blurRadius: 6),
                                Shadow(color: blue, blurRadius: 9),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextFieldWidget(
                  controller: _nameController,
                  label: "Name",
                  inputType: TextInputType.name,
                  capitalisation: TextCapitalization.words,
                ),
                TextFieldWidget(
                  controller: _emailController,
                  label: "Email",
                  inputType: TextInputType.emailAddress,
                  capitalisation: TextCapitalization.none,
                ),

                TextFieldWidget(
                  controller: _messageController,
                  label: "Message",
                  inputType: TextInputType.multiline,
                  capitalisation: TextCapitalization.sentences,
                  maxLines: 100,
                  minLines: 5,
                ),
                TextFieldWidget(
                  controller: _challengeController,
                  label: "Security Check: ${_currentChallenge['question']}",
                  inputType: TextInputType.text,
                  capitalisation: TextCapitalization.sentences,
                  maxLines: 2,
                  minLines: 2,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(blue),
                      ),
                      // In your ElevatedButton onPressed:
                      onPressed:
                          _isLoading
                              ? null
                              : () async {
                                if (!_isValidChallengeAnswer()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please answer the security question correctly.",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  try {
                                    await EmailService.sendEmail(
                                      name: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      message: _messageController.text.trim(),
                                    );

                                    // Reset form
                                    _nameController.clear();
                                    _emailController.clear();
                                    _messageController.clear();
                                    _challengeController.clear();

                                    // Show success message
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: blue,
                                        content: Text(
                                          "Message sent successfully.",
                                          style: TextStyle(color: white),
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            Text("$e. Contact:"),
                                            TextButton(
                                              onPressed: () {
                                                // url launcher to send email
                                                UrlLauncher.email();
                                              },
                                              child: Text(
                                                "oxygentech@protonmail.com",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } finally {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    _updateChallenge();
                                  }
                                }
                              },

                      child: Text(
                        "Submit",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(color: white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
