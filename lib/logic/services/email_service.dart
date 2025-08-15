import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _mailCollection = _firestore.collection(
    'mail',
  );

  // Maximum emails allowed per time period
  static const int _maxEmailsPerHour = 5;
  static const String _lastEmailTimestampKey = 'last_email_timestamp';
  static const String _emailCountKey = 'email_count_today';

  static Future<void> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    // Check rate limiting
    if (!await _canSendEmail()) {
      throw 'Limit reached';
    }
    try {
      // Send email via Firestore
      await _mailCollection.add({
        'to':
            'info@o2tech.com.au', // Your email where you want to receive messages
        'message': {
          'subject': 'Enquiry from $name',
          'text': 'From: $name\nEmail: $email\n\nMessage:\n$message',
          'html': '''
            <div>
              <h2>Contact Form Submission</h2>
              <p><strong>From:</strong> $name</p>
              <p><strong>Email:</strong> $email</p>
              <p><strong>Message:</strong></p>
              <p>${message.replaceAll('\n', '<br>')}</p>
            </div>
          ''',
        },
        'replyTo': email, // So you can reply directly to the sender
      });
      // Update rate limit tracking
      await _updateRateLimitCounters();
    } catch (e) {
      throw Exception('Failed to send email: $e');
    }
  }

  // Check if user can send more emails
  static Future<bool> _canSendEmail() async {
    final prefs = await SharedPreferences.getInstance();

    // Get the current counts
    final lastEmailTimestamp = prefs.getInt(_lastEmailTimestampKey) ?? 0;
    final emailCount = prefs.getInt(_emailCountKey) ?? 0;

    final now = DateTime.now().millisecondsSinceEpoch;
    final oneHourAgo = now - (60 * 60 * 1000);

    // Reset counter if it's been more than an hour
    if (lastEmailTimestamp < oneHourAgo) {
      await prefs.setInt(_emailCountKey, 0);
      return true;
    }

    // Check if user has reached limit
    return emailCount < _maxEmailsPerHour;
  }

  // Update the counters after sending
  static Future<void> _updateRateLimitCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;

    // Update timestamp of last email
    await prefs.setInt(_lastEmailTimestampKey, now);

    // Increment email count
    final currentCount = prefs.getInt(_emailCountKey) ?? 0;
    await prefs.setInt(_emailCountKey, currentCount + 1);
  }
}
