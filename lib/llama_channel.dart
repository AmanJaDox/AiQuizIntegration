import 'package:flutter/services.dart';

class LlamaChannel {
  static const MethodChannel _channel = MethodChannel('llama_channel');

  /// Method to send user input to the native code and receive the evaluated answer
  static Future<String> evaluateAnswer(String userInput) async {
    try {
      final String result = await _channel.invokeMethod('evaluate', userInput);
      return result;
    } on PlatformException catch (e) {
      // Handle platform exceptions (e.g., errors from native code)
      print('Error evaluating answer: ${e.message}');
      return null;
    }
  }
}
