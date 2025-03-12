import 'dart:convert';

import 'package:http/http.dart' as http;

class EmailService {
  static Future sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    final serviceId = "service_elcz0qy";
    final templateId = "template_cnatzaq";
    final userId = "CHlJZxiFDn1K_DXsF";
    // Send email
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
      url,
      headers: {
        "origin": "http://localhost",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "user_name": name,
          "user_email": email,
          "user_message": message,
        },
      }),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to send email");
    }
  }
}
