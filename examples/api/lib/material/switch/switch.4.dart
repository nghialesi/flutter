// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Flutter code sample for [Switch.adaptive].

void main() => runApp(const SwitchApp());

class SwitchApp extends StatefulWidget {
  const SwitchApp({super.key});

  @override
  State<SwitchApp> createState() => _SwitchAppState();
}

class _SwitchAppState extends State<SwitchApp> {
  bool isMaterial = true;
  TargetPlatform platform = TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      platform: isMaterial ? TargetPlatform.android : TargetPlatform.iOS,
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(title: const Text('Adaptive Switches')),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OutlinedButton(
            onPressed: () {
              setState(() {
                isMaterial = !isMaterial;
              });
            },
            child: isMaterial ? const Text('Show cupertino style') : const Text('Show material style'),
          ),
          const SizedBox(height: 20),
          const SwitchWithLabel(label: 'enabled', enabled: true),
          const SwitchWithLabel(label: 'disabled', enabled: false),
          Theme(
            data: theme.copyWith(
              adaptations: <Adaptation<Object>>[ const _SwitchThemeAdaptation() ],
            ),
            child: const SwitchWithLabel(
              label: 'customization for cupertino only',
              enabled: true,
            ),
          ),
        ],
                ),
      ),
    );
  }
}

class SwitchWithLabel extends StatefulWidget {
  const SwitchWithLabel({
    super.key,
    required this.enabled,
    required this.label,
  });

  final bool enabled;
  final String label;

  @override
  State<SwitchWithLabel> createState() => _SwitchWithLabelState();
}

class _SwitchWithLabelState extends State<SwitchWithLabel> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          padding: const EdgeInsets.only(right: 20),
          child: Text(widget.label)
        ),
        Switch.adaptive(
          value: active,
          onChanged: widget.enabled ?
            (bool value) {
              setState(() {
                active = value;
              });
            } : null,
        ),
      ],
    );
  }
}


class _SwitchThemeAdaptation extends Adaptation<SwitchThemeData> {
  const _SwitchThemeAdaptation();

  @override
  SwitchThemeData adapt(ThemeData theme, SwitchThemeData defaultValue) => SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.yellow;
      }
      return null; // Use the default.
    }),
    trackColor: const MaterialStatePropertyAll<Color>(Colors.brown),
  );
}
