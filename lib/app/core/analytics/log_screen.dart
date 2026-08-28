import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class GetXAnalyticsObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _send(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null) {
      _send(newRoute);
    }
  }

  void _send(Route route) {
    final screenName = route.settings.name;
    if (screenName != null) {
      FirebaseAnalytics.instance.logScreenView(
        screenName: screenName,
      );
      print('Screen tracked: $screenName');
    }
  }
}