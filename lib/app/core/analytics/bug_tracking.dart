import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import 'package:idee_pet/firebase_options.dart';

import '../models/profile.entity.dart';

class BugTracking {
  BugTracking._() {
    _i = this;
  }
  factory BugTracking() => _i ?? BugTracking._();
  static BugTracking? _i;

  bool _isInitialized = false;

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> init() async {
    try {
      await _initFirebase();

      await _initCrashlytics();
      _isInitialized = true;
    } catch (e, s) {
      print("FATAL: Failed to initialize Firebase or Crashlytics: $e\n$s");
    }
  }

  Future<void> _initCrashlytics() async {
    if (Firebase.apps.isEmpty) {
      print("Firebase App not initialized, skipping Crashlytics setup.");
      return;
    }
    try {
      // await FirebaseCrashlytics.instance
      //     .setCrashlyticsCollectionEnabled(kReleaseMode);
      // print("Crashlytics collection enabled: $kReleaseMode");

      // Capture Flutter framework errors.
      FlutterError.onError = (FlutterErrorDetails details) async {
        await _initFirebase();
        await FirebaseCrashlytics.instance
            .recordFlutterError(details, fatal: true);
      };

      // Capture errors outside of the Flutter framework (e.g., async gaps, isolates).
      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        _initFirebase();
        send(
          'Unhandled Platform Error: ${error.toString()}',
          error,
          stack,
        );
        // Return true to indicate that the error has been handled.
        return true;
      };
    } catch (e, s) {
      print("Error initializing Crashlytics handlers: $e\n$s");
    }
  }

  /// Sends an error report to Firebase Crashlytics.
  ///
  /// - [message]: A descriptive message context for the error.
  /// - [exception]: The error/exception object.
  /// - [stackTrace]: The stack trace associated with the error.
  /// - [responseData]: Optional: Response data from an API call (will be truncated if too long).
  /// - [path]: Optional: API path or screen identifier.
  /// - [statusCode]: Optional: HTTP status code.
  /// - [isFatal]: Optional: Indicates if the error should be marked as fatal in Crashlytics.
  Future<void> send(
    final String message,
    final Object exception, [
    final StackTrace? stackTrace,
    final String? responseData,
    final String? path,
    final String? statusCode,
    final bool isFatal = false,
  ]) async {
    if (!_isInitialized) {
      print("BugTracking not initialized. Skipping error report: $message");
      return;
    }

    await _initFirebase();

    try {
      final Map<String, String> customKeys = {};

      customKeys['errorContextMessage'] =
          message.length > 256 ? '${message.substring(0, 253)}...' : message;

      if (responseData != null) {
        customKeys['responseData'] = responseData.length > 4096
            ? '${responseData.substring(0, 4093)}...'
            : responseData;
      }
      if (path != null) {
        customKeys['path'] =
            path.length > 256 ? '${path.substring(0, 253)}...' : path;
      }
      if (statusCode != null) {
        customKeys['statusCode'] = statusCode.length > 64
            ? '${statusCode.substring(0, 61)}...'
            : statusCode;
      }

      await Future.forEach(customKeys.entries,
          (MapEntry<String, String> entry) async {
        await FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
      });

      await FirebaseCrashlytics.instance.recordError(
        exception,
        stackTrace ?? StackTrace.current,
        reason: message,
        fatal: isFatal,
      );

      print("Crashlytics report sent for: $message");
    } catch (e, s) {
      print("CRITICAL: Error sending report to Crashlytics: $e\n$s");
    }
  }

  /// Logs a custom message to Firebase Crashlytics. Useful for tracking non-fatal events or flow.
  ///
  /// - [message]: The log message.
  /// - [properties]: Optional key-value pairs to add temporary context to the log.
  Future<void> log(
    final String message, [
    final Map<String, String>? properties, // Renamed for clarity
  ]) async {
    if (!_isInitialized) {
      print("BugTracking not initialized. Skipping log: $message");
      return;
    }
    await _initFirebase();
    print("Logging to Crashlytics: $message");
    try {
      if (properties != null && properties.isNotEmpty) {
        await Future.forEach(properties.entries,
            (MapEntry<String, String> entry) async {
          final key = entry.key.length > 64
              ? entry.key.substring(0, 61) + '...'
              : entry.key;
          final value = entry.value.length > 256
              ? entry.value.substring(0, 253) + '...'
              : entry.value;
          await FirebaseCrashlytics.instance.setCustomKey(key, value);
        });
      }

      await FirebaseCrashlytics.instance.log(message);

      if (properties != null && properties.isNotEmpty) {
        await Future.forEach(properties.keys, (String key) async {
          final originalKey =
              key.length > 64 ? key.substring(0, 61) + '...' : key;
          await FirebaseCrashlytics.instance.setCustomKey(originalKey, '');
        });
      }
    } catch (e, s) {
      print("Error logging to Crashlytics: $e\n$s");
    }
  }

  /// Logs a custom event to Firebase Analytics.
  Future<void> logEvent(
    final String eventName, [
    final Map<String, dynamic>? data,
  ]) async {
    if (!_isInitialized) {
      print(
          "BugTracking not initialized. Skipping Analytics event: $eventName");
      return;
    }
    await _initFirebase();
    final sanitizedEventName =
        eventName.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_').substring(0, 40);

    print("Logging Analytics Event: $sanitizedEventName");
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: sanitizedEventName,
        parameters: data?.map((key, value) => MapEntry(
            key.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_').substring(0, 40),
            value)),
      );
    } catch (e, s) {
      print("Error logging Analytics event '$sanitizedEventName': $e\n$s");
    }
  }

  void trackNavigation(final String pageName,
      {final Map<String, dynamic>? data}) async {
    if (!_isInitialized) {
      print(
          "BugTracking not initialized. Skipping navigation tracking: $pageName");
      return;
    }
    await _initFirebase();
    print("Tracking Navigation / Screen View: $pageName");

    unawaited(FirebaseAnalytics.instance.logScreenView(
        screenName: pageName.length > 100
            ? pageName.substring(0, 97) + '...'
            : pageName,
        parameters: data?.map((key, value) => MapEntry(key, value as Object))));
  }

  /// Identifies the current user in Crashlytics and Analytics.
  Future<void> identify(final Profile userInfo) async {
    if (!_isInitialized) {
      print("BugTracking not initialized. Skipping user identification.");
      return;
    }
    final userIdStr = userInfo.id.toString();
    final userName = userInfo.name ?? 'N/A';

    print("Identifying user: ID=$userIdStr, Name=$userName");
    try {
      await _initFirebase();
      await FirebaseCrashlytics.instance.setUserIdentifier(userIdStr);

      await FirebaseCrashlytics.instance.setCustomKey('userId', userIdStr);
      await FirebaseCrashlytics.instance.setCustomKey('userName', userName);

      await FirebaseAnalytics.instance.setUserId(id: userIdStr);
    } catch (e, s) {
      print("Error identifying user (ID: $userIdStr): $e\n$s");
    }
  }
}
