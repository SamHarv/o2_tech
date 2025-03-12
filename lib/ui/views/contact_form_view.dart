import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
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
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(blue),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Processing Data")),
                          );
                        }
                        // TODO: Send data to backend
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
