import 'package:flutter/services.dart';

class LlamaChannel {
  static const MethodChannel _channel = MethodChannel('llama_channel');

  /// Method to send user input to the native code and receive the evaluated answer
  static Future<Map<String, dynamic>> evaluateAnswer(String userInput) async {
    try {
      // Send user input to native code and receive JSON response
      final result = await _channel.invokeMethod('evaluate', userInput);

      // Parse JSON response into data structure
      return jsonDecode(result) as Map<String, dynamic>;
    } catch (e) {
      // Handle errors
      print('Error evaluating answer: ${e.message}');
      return {};
    }
  }
}

