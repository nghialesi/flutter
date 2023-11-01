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

    // Default is material style switches
    expect(find.text('Show cupertino style'), findsOneWidget);
    expect(find.text('Show material style'), findsNothing);

    final Finder adaptiveSwitch = find.byType(Switch).first;
    expect(
      adaptiveSwitch,
      paints
        ..rrect(color: const Color(0xff6750a4)) // M3 primary color.
        ..rrect()
        ..rrect(color: Colors.white), // Thumb color
    );
    
    await tester.tap(find.byType(OutlinedButton));
    await tester.pumpAndSettle();

    expect(
      adaptiveSwitch,
      paints
        ..rrect(color: const Color(0xff34c759)) // Cupertino system green.
        ..rrect()..rrect()..rrect()..rrect()
        ..rrect(color: Colors.white), // Thumb color
    );

    final Finder customCupertinoSwitch = find.byType(Switch).at(2);
    expect(
      customCupertinoSwitch,
      paints
        ..rrect(color: const Color(0xff795548)) // Customized track color only for cupertino.
        ..rrect()..rrect()..rrect()..rrect()
        ..rrect(color: const Color(0xffffeb3b)), // Customized thumb color only for cupertino.
    );
  });
}
