import 'package:flutter/widgets.dart';

enum ScreenShotDevice {
  iphone14promax,
  iphone13promax,
  iphonese3,
  ipadpro,
  android,
  androidtab
}

Size getScreenSize(ScreenShotDevice device) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return const Size(1290, 2796);
    case ScreenShotDevice.iphone13promax:
      return const Size(1284, 2778);
    case ScreenShotDevice.iphonese3:
      return const Size(1242, 2208);
    case ScreenShotDevice.ipadpro:
      return const Size(2048, 2732);
    case ScreenShotDevice.android:
      return const Size(1620, 2880);
    case ScreenShotDevice.androidtab:
      return const Size(1620, 2880);
  }
}

Size getPhoneSize(ScreenShotDevice device) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return const Size(1290, 2796);
    case ScreenShotDevice.iphone13promax:
      return const Size(1284, 2778);
    case ScreenShotDevice.iphonese3:
      return const Size(1242, 2208);
    case ScreenShotDevice.ipadpro:
      return const Size(2048, 2732);
    case ScreenShotDevice.android:
      return const Size(1156, 2578);
    case ScreenShotDevice.androidtab:
      return const Size(1536, 2049);
  }
}

String getDeviceLabel(ScreenShotDevice device) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return "iPhone 14 Pro max";
    case ScreenShotDevice.iphone13promax:
      return "iPhone 13 Pro max";
    case ScreenShotDevice.iphonese3:
      return "iPhone SE 3";
    case ScreenShotDevice.ipadpro:
      return "iPad Pro";
    case ScreenShotDevice.android:
      return "Android Phone";
    case ScreenShotDevice.androidtab:
      return "Android Tablet";
  }
}

String getAssetsName(ScreenShotDevice device) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return "assets/iphone14pro.png";
    case ScreenShotDevice.iphone13promax:
      return "assets/iphone13pro.png";
    case ScreenShotDevice.iphonese3:
      return "assets/iphonese.png";
    case ScreenShotDevice.ipadpro:
      return "assets/ipad.png";
    case ScreenShotDevice.android:
      return "assets/android.png";
    case ScreenShotDevice.androidtab:
      return "assets/ipad.png";
  }
}

double getShrinkRatio(ScreenShotDevice device) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return 0.896;
    case ScreenShotDevice.iphone13promax:
      return 0.902;
    case ScreenShotDevice.iphonese3:
      return 0.755;
    case ScreenShotDevice.ipadpro:
      return 0.922;
    case ScreenShotDevice.android:
      return 0.934;
    case ScreenShotDevice.androidtab:
      return 0.922;
  }
}

double getAppBarRatio(ScreenShotDevice device) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return 0.05;
    case ScreenShotDevice.iphone13promax:
      return 0.032;
    case ScreenShotDevice.iphonese3:
      return 0;
    case ScreenShotDevice.ipadpro:
      return 0;
    case ScreenShotDevice.android:
      return 0.05;
    case ScreenShotDevice.androidtab:
      return 0;
  }
}

double getRadius(ScreenShotDevice device) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return 24;
    case ScreenShotDevice.iphone13promax:
      return 24;
    case ScreenShotDevice.iphonese3:
      return 0;
    case ScreenShotDevice.ipadpro:
      return 0;
    case ScreenShotDevice.android:
      return 24;
    case ScreenShotDevice.androidtab:
      return 0;
  }
}

Offset getOffset(ScreenShotDevice device, double pixelRatio) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return const Offset(0.5, 0) * pixelRatio;
    case ScreenShotDevice.iphone13promax:
      return const Offset(1, 0) * pixelRatio;
    case ScreenShotDevice.iphonese3:
      return const Offset(0, 0) * pixelRatio;
    case ScreenShotDevice.ipadpro:
      return const Offset(0, 0) * pixelRatio;
    case ScreenShotDevice.android:
      return const Offset(0, 0) * pixelRatio;
    case ScreenShotDevice.androidtab:
      return const Offset(0, 0) * pixelRatio;
  }
}

BoxFit getBoxFit(ScreenShotDevice device) {
  switch (device) {
    case ScreenShotDevice.iphone14promax:
      return BoxFit.fitWidth;
    case ScreenShotDevice.iphone13promax:
      return BoxFit.fitWidth;
    case ScreenShotDevice.iphonese3:
      return BoxFit.fitHeight;
    case ScreenShotDevice.ipadpro:
      return BoxFit.fitWidth;
    case ScreenShotDevice.android:
      return BoxFit.fitHeight;
    case ScreenShotDevice.androidtab:
      return BoxFit.fitWidth;
  }
}
