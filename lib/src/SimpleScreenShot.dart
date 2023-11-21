import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Capture.dart';
import 'ScreenShotDevice.dart';


/// A Widget to create the appstore screenshot easy
/// Add callback to take screenshot
/// Add description if you want to display some word in the screenshot
class SimpleScreenShot extends StatefulWidget {
  const SimpleScreenShot(
      {super.key,
      required this.child,
      this.description,
      this.color,
      this.gradient,
      this.image,
      this.active = kDebugMode,
      this.callback})
      : assert(!(color != null && gradient != null));

  /// the page that you want to be displayed in the screenshot
  final Widget child;

  /// a function return a description
  final Widget Function(BuildContext)? description;

  ///background color
  final Color? color;

  ///background gradient
  final Gradient? gradient;

  ///background image
  final DecorationImage? image;

  ///action to be performed after taking screenshot. Must including this to take the screenshot
  final Future Function(Uint8List?)? callback;

  final bool active;

  @override
  State<SimpleScreenShot> createState() => _SimpleScreenShotState();
}

class _SimpleScreenShotState extends State<SimpleScreenShot> {
  bool showDevice = false;
  double deviceRatio = 0.8;
  Offset deviceOffset = const Offset(0, 0);
  Offset descriptionOffset = const Offset(0, 0);
  double labelPadding = 0;
  Orientation orientation = Orientation.portrait;
  Locale _locale = const Locale('en');
  double textScale = 1;
  final GlobalKey _key = GlobalKey();

  double get shrinkRatio => orientation == Orientation.portrait ? 1.5 : 1.0;

  ScreenShotDevice device = ScreenShotDevice.iphone14promax;

  Size get _ScreenSize => (getScreenSize(device) / _ratio)
      .reverse(orientation == Orientation.landscape);

  Size get _PhoneSize => showDevice
      ? (getPhoneSize(device) / _ratio)
          .reverse(orientation == Orientation.landscape)
      : _ScreenSize;

  double get _ratio =>
      (3500 / shrinkRatio / MediaQuery.of(context).size.longestSide) *
      MediaQuery.of(context).devicePixelRatio;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        textScale = MediaQuery.of(context).textScaleFactor;
        _locale = Locale(Localizations.localeOf(context).languageCode,
            Localizations.localeOf(context).countryCode);
      });
    });
  }

  bool isCupertino() {
    if (context.findAncestorWidgetOfExactType<CupertinoApp>() != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) {
      return widget.child;
    }
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        body: Localizations.override(
          context: context,
          locale: _locale,
          child: Builder(builder: (context) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Transform.scale(
                      alignment: Alignment.topCenter,
                      scale: 1 / shrinkRatio,
                      child: SizedBox.fromSize(
                        size: _ScreenSize,
                        child: RepaintBoundary(
                          key: _key,
                          child: Center(
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  image: widget.image,
                                  color: widget.color,
                                  gradient: widget.gradient),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                    size: _PhoneSize,
                                    textScaleFactor: textScale,
                                    padding: EdgeInsets.only(
                                        top: showDevice
                                            ? orientation ==
                                                    Orientation.portrait
                                                ? _PhoneSize.height *
                                                    getAppBarRatio(device)
                                                : 0
                                            : 0,
                                        left: showDevice
                                            ? orientation ==
                                                    Orientation.landscape
                                                ? _PhoneSize.width *
                                                    getAppBarRatio(device)
                                                : 0
                                            : 0)),
                                child: Stack(
                                  children: [
                                    _buildScreen(),
                                    if (widget.description != null)
                                      _buildDescription(context),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: size.height - _ScreenSize.height / shrinkRatio - 32,
                    child: Column(
                      children: [
                        const Divider(),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (widget.callback != null)
                                ElevatedButton(
                                    onPressed: () async {
                                      await captureImage(_key, _ratio)
                                          .then(widget.callback!);
                                    },
                                    child: const Text("Capture")),
                              _orientationTile(),
                              _buildDeviceListTile(context),
                              _buildShowDevice(),
                              _buildLocaleTile(context),
                              if (showDevice) ...[
                                ListTile(
                                  leading: SizedBox(
                                      width: 150, child: const Text("Ratio")),
                                  subtitle: Slider(
                                      label: "Ratio",
                                      max: 1.5,
                                      min: 0.2,
                                      value: deviceRatio,
                                      onChanged: (double value) {
                                        setState(() {
                                          deviceRatio = value;
                                        });
                                      }),
                                ),
                                _buildRatioTile(
                                  onReset: () {
                                    deviceOffset = Offset(0, deviceOffset.dy);
                                  },
                                  description: 'Device X-offset',
                                  value: deviceOffset.dx,
                                  onChange: (double value) {
                                    setState(() {
                                      deviceOffset =
                                          Offset(value, deviceOffset.dy);
                                    });
                                  },
                                ),
                                _buildRatioTile(
                                  onReset: () {
                                    deviceOffset = Offset(deviceOffset.dx, 0);
                                  },
                                  description: 'Device Y-offset',
                                  value: deviceOffset.dy,
                                  onChange: (double value) {
                                    setState(() {
                                      deviceOffset =
                                          Offset(deviceOffset.dx, value);
                                    });
                                  },
                                ),
                              ],
                              if (widget.description != null) ...[
                                ListTile(
                                  leading: SizedBox(
                                      width: 150,
                                      child: const Text("Label Padding")),
                                  subtitle: Slider(
                                      max: 200,
                                      min: 0,
                                      value: labelPadding,
                                      onChanged: (double value) {
                                        setState(() {
                                          labelPadding = value;
                                        });
                                      }),
                                ),
                                _buildRatioTile(
                                  onReset: () {
                                    descriptionOffset =
                                        Offset(0, descriptionOffset.dy);
                                  },
                                  description: 'Label X-offset',
                                  value: descriptionOffset.dx,
                                  onChange: (double value) {
                                    setState(() {
                                      descriptionOffset =
                                          Offset(value, descriptionOffset.dy);
                                    });
                                  },
                                ),
                                _buildRatioTile(
                                  onReset: () {
                                    descriptionOffset =
                                        Offset(descriptionOffset.dx, 0);
                                  },
                                  description: 'Label Y-offset',
                                  value: descriptionOffset.dy,
                                  onChange: (double value) {
                                    setState(() {
                                      descriptionOffset =
                                          Offset(descriptionOffset.dx, value);
                                    });
                                  },
                                ),
                              ],
                              ListTile(
                                leading: SizedBox(
                                    width: 150,
                                    child: const Text("Text Ratio")),
                                subtitle: Slider(
                                    label: "Text Ratio",
                                    max: 4,
                                    min: 0.5,
                                    value: textScale,
                                    onChanged: (double value) {
                                      setState(() {
                                        textScale = value;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Align _buildScreen() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox.fromSize(
        size: _PhoneSize,
        child: Transform.scale(
            scale: showDevice ? deviceRatio : 1,
            child: Transform.translate(
              offset: showDevice
                  ? deviceOffset.scale(getScreenSize(device).width / _ratio,
                      getScreenSize(device).height / _ratio)
                  : const Offset(0, 0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Transform.translate(
                    offset: showDevice
                        ? getOffset(
                            device, MediaQuery.of(context).devicePixelRatio)
                        : Offset.zero,
                    child: Transform.scale(
                        scale: showDevice ? getShrinkRatio(device) : 1,
                        child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    showDevice ? getRadius(device) : 0)),
                            child: widget.child)),
                  ),
                  if (showDevice)
                    IgnorePointer(
                      ignoring: true,
                      child: RotatedBox(
                          quarterTurns:
                              orientation == Orientation.landscape ? -1 : 0,
                          child: Opacity(
                              opacity: 1,
                              child: Image.asset(
                                fit: BoxFit.contain,
                                getAssetsName(device),
                                package: "simple_appstore_screenshot",
                              ))),
                    )
                ],
              ),
            )),
      ),
    );
  }

  ListTile _orientationTile() {
    return ListTile(
      leading: const Text("Orientation"),
      trailing: SegmentedButton<Orientation>(
        segments: const [
          ButtonSegment(
              value: Orientation.portrait,
              icon: Icon(Icons.stay_current_portrait)),
          ButtonSegment(
              value: Orientation.landscape,
              icon: Icon(Icons.stay_current_landscape))
        ],
        selected: {orientation},
        onSelectionChanged: (Set<Orientation> newSelection) {
          setState(() {
            orientation = newSelection.first;
          });
        },
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Align(
          alignment: Alignment.topCenter,
          child: Transform.translate(
            offset: descriptionOffset.scale(getScreenSize(device).width / 2,
                getScreenSize(device).height / 2),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: labelPadding),
              child: widget.description!(context),
            ),
          )),
    );
  }

  ListTile _buildRatioTile(
      {required Function() onReset,
      required String description,
      required double value,
      required Function(double) onChange}) {
    return ListTile(
      trailing: TextButton(
        onPressed: () {
          setState(onReset);
        },
        child: Text("Reset"),
      ),
      leading: SizedBox(width: 150, child: Text(description)),
      subtitle: Slider(max: 0.5, min: -0.5, value: value, onChanged: onChange),
    );
  }

  ListTile _buildShowDevice() {
    return ListTile(
      leading: const Text("Show Device"),
      trailing: Switch(
        value: showDevice,
        onChanged: (bool result) {
          setState(() {
            showDevice = result;
          });
        },
      ),
    );
  }

  ListTile _buildLocaleTile(BuildContext context) {
    return ListTile(
      leading: const Text("Locale"),
      trailing: Text(_locale.toString()),
      onTap: () async {
        List<Locale> locales = context
            .findAncestorWidgetOfExactType<WidgetsApp>()!
            .supportedLocales
            .toList();
        if (isCupertino()) {
          await showCupertinoModalPopup<Locale>(
              context: context,
              builder: (context) => SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      itemExtent: 32,
                      useMagnifier: true,
                      children: locales.map((e) => Text(e.toString())).toList(),
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          _locale = locales[index];
                        });
                      },
                    ),
                  ));
        } else {
          await showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: locales
                        .map((e) => TextButton(
                            onPressed: () {
                              setState(() {
                                _locale = e;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(e.toString())))
                        .toList(),
                  ));
        }
      },
    );
  }

  ListTile _buildDeviceListTile(BuildContext context) {
    return ListTile(
      leading: const Text("Device"),
      trailing: Text(getDeviceLabel(device)),
      onTap: () async {
        List<Locale> locales = context
            .findAncestorWidgetOfExactType<WidgetsApp>()!
            .supportedLocales
            .toList();
        if (isCupertino()) {
          await showCupertinoModalPopup<Locale>(
              context: context,
              builder: (context) => SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      itemExtent: 32,
                      useMagnifier: true,
                      children: ScreenShotDevice.values
                          .map((e) => Text(getDeviceLabel(e)))
                          .toList(),
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          device = ScreenShotDevice.values[index];
                        });
                      },
                    ),
                  ));
        } else {
          ScreenShotDevice? _device = await showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: ScreenShotDevice.values
                        .map((e) => TextButton(
                            onPressed: () {
                              device = e;
                              Navigator.of(context).pop();
                            },
                            child: Text(getDeviceLabel(e))))
                        .toList(),
                  ));
        }
      },
    );
  }
}

extension on Size {
  Size reverse(bool result) {
    if (result) {
      return Size(height, width);
    }
    return this;
  }
}

extension on BoxFit {
  BoxFit reverse() {
    if (this == BoxFit.fitHeight) {
      return BoxFit.fitWidth;
    } else if (this == BoxFit.fitWidth) {
      return BoxFit.fitHeight;
    }
    return this;
  }
}
