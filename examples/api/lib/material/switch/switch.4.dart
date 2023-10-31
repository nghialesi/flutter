// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Flutter code sample for [Switch.adaptive].

void main() => runApp(const SwitchApp());

class SwitchApp extends StatelessWidget {
  const SwitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Adaptive Switches')),
        body: const Center(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AdaptiveSwitches(platform: TargetPlatform.iOS, ),
            SizedBox(width: 20,),
            AdaptiveSwitches(platform: TargetPlatform.android),
          ],
        ),
        ),
      ),
    );
  }
}

class AdaptiveSwitches extends StatefulWidget {
  const AdaptiveSwitches({
    super.key,
    required this.platform
  });

  final TargetPlatform platform;

  @override
  State<AdaptiveSwitches> createState() => _AdaptiveSwitchesState();
}

class _AdaptiveSwitchesState extends State<AdaptiveSwitches> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      platform: widget.platform,
    );

    Widget label(String switchLabel) {
      return widget.platform == TargetPlatform.iOS
        ? Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(switchLabel))
        : const Text('');
    }

    return Theme(
      data: theme,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(widget.platform == TargetPlatform.iOS ? 'Cupertino' : 'Material', style: const TextStyle(fontWeight: FontWeight.w600)),
          Row(
            children: <Widget>[
              label('enabled'),
              Switch.adaptive(
                value: active,
                onChanged: (bool value) {
                  setState(() {
                    active = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              label('disabled'),
              Switch.adaptive(
                value: active,
                onChanged: null,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              label('customization'),
              Theme(
                data: theme.copyWith(
                  adaptations: <Adaptation<Object>>[
                    const _SwitchThemeAdaptation()
                  ]
                ),
                child: Switch.adaptive(
                  value: active,
                  onChanged: (bool value) {
                    setState(() {
                      active = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
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
