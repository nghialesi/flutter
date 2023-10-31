// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_api_samples/material/switch/switch.4.dart' as example;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Show adaptive switch theme', (WidgetTester tester) async {
    await tester.pumpWidget(
      const example.SwitchApp(),
    );

    expect(find.text('iOS'), findsOneWidget);
    expect(find.text('android'), findsOneWidget);

    final Finder iOSSwitch = find.byType(Switch).first;
    expect(
      iOSSwitch,
      paints
        ..rrect(color: const Color(0xff34c759)) // Cupertino system green.
        ..rrect()..rrect()..rrect()..rrect()
        ..rrect(color: Colors.white), // Thumb color
    );

    final Finder iOSSwitchWithCustomization = find.byType(Switch).at(2);
    expect(
      iOSSwitchWithCustomization,
      paints
        ..rrect(color: const Color(0xff795548)) // Customized track color only for cupertino.
        ..rrect()..rrect()..rrect()..rrect()
        ..rrect(color: const Color(0xffffeb3b)), // Customized thumb color only for cupertino.
    );

    // Switch.adaptive on android platform still provides M3 switch.
    final Finder androidSwitch = find.byType(Switch).at(3); // The first switch on the second column.
    expect(
      androidSwitch,
      paints
        ..rrect(color: const Color(0xff6750a4)) // M3 primary color.
        ..rrect()
        ..rrect(color: Colors.white), // Thumb color
    );
  });
}
