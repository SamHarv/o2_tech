import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:o2_tech/logic/services/email_service.dart';
import 'package:o2_tech/logic/services/url_launcher.dart';
import 'package:o2_tech/ui/widgets/loading_widget.dart';
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
    _currentChallenge = _challenges[Random().nextInt(_challenges.length)];
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _challengeController.dispose();
    super.dispose();
  }

  // Validate the challenge answer (case-insensitive)
  bool _isValidChallengeAnswer() {
    return _challengeController.text.trim().toLowerCase() ==
        _currentChallenge['answer']!.toLowerCase();
  }

  Future<BrowserName> getBrowser() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    BrowserName browser = webBrowserInfo.browserName;
    return browser;
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: FutureBuilder(
        future: getBrowser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: LoadingWidget()));
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")),
            );
          }
          return Scaffold(
            resizeToAvoidBottomInset:
                snapshot.data == BrowserName.safari ||
                        snapshot.data == BrowserName.firefox
                    ? true
                    : false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Beamer.of(context).beamToNamed("/home");
                },
                icon: Icon(Icons.navigate_before),
              ),
            ),
            body:
                _isLoading
                    ? Center(child: LoadingWidget())
                    : SafeArea(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Form(
                              key: _formKey,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 500),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 24,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // App Title
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: mediaWidth - 48,
                                          ),
                                          child: FadeInWidget(
                                            widgetToFadeIn: Text(
                                              "Contact",
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  fontSize:
                                                      AdaptiveFontSize.getFontSize(
                                                        context,
                                                        24,
                                                      ),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Open Sans",
                                                  color: white,
                                                  shadows: [
                                                    Shadow(
                                                      color: blue,
                                                      blurRadius: 3,
                                                    ),
                                                    Shadow(
                                                      color: blue,
                                                      blurRadius: 6,
                                                    ),
                                                    Shadow(
                                                      color: blue,
                                                      blurRadius: 9,
                                                    ),
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
                                      capitalisation:
                                          TextCapitalization.sentences,
                                      maxLines: 100,
                                      minLines: 5,
                                    ),
                                    TextFieldWidget(
                                      controller: _challengeController,
                                      label:
                                          "Security: ${_currentChallenge['question']}",
                                      inputType: TextInputType.text,
                                      capitalisation:
                                          TextCapitalization.sentences,
                                      maxLines: 2,
                                      minLines: 2,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                  blue,
                                                ),
                                          ),
                                          // In your ElevatedButton onPressed:
                                          onPressed:
                                              _isLoading
                                                  ? null
                                                  : () async {
                                                    if (!_isValidChallengeAnswer()) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            "Please answer the security question correctly.",
                                                          ),
                                                        ),
                                                      );
                                                      return;
                                                    }
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        _isLoading = true;
                                                      });

                                                      try {
                                                        await EmailService.sendEmail(
                                                          name:
                                                              _nameController
                                                                  .text
                                                                  .trim(),
                                                          email:
                                                              _emailController
                                                                  .text
                                                                  .trim(),
                                                          message:
                                                              _messageController
                                                                  .text
                                                                  .trim(),
                                                        );

                                                        // Reset form
                                                        _nameController.clear();
                                                        _emailController
                                                            .clear();
                                                        _messageController
                                                            .clear();
                                                        _challengeController
                                                            .clear();

                                                        // Show success message

                                                        ScaffoldMessenger.of(
                                                          // ignore: use_build_context_synchronously
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            backgroundColor:
                                                                blue,
                                                            content: Text(
                                                              "Message sent successfully.",
                                                              style: TextStyle(
                                                                color: white,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                          // ignore: use_build_context_synchronously
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Row(
                                                              children: [
                                                                Text(
                                                                  "$e. Contact:",
                                                                ),
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
                                              textStyle: TextStyle(
                                                color: white,
                                                fontSize: 16,
                                              ),
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
                        ),
                      ),
                    ),
          );
        },
      ),
    );
  }
}
