This package help you to create appstore screenshot directly within the app.

## Features

This package can create screenshot easily in app. The size of the screenshot can be uploaded to Google Play Store and Apple AppStore directly. 
It is recommended to use this package in tablet.

<img src="https://github.com/lky2431/simple_appstore_screenshot/assets/61407859/e403b741-54a8-4fe3-bb55-29e7b4ca9adb" width="300" />
<img src="https://github.com/lky2431/simple_appstore_screenshot/assets/61407859/25fdb1e3-25e8-47f3-af1a-c95e34c3cc0d" width="300" />


## Getting started

#### wrap the page that you want to create screenshot inside SimpleScreenShot

```Dart
SimpleScreenShot(
  child: YourPage()
)
```
*SimpleScreenShot must be under MaterialApp or CupertinoApp*


#### take screenshot
specify how you want to treat the captured image in Uint8List.

For example, if you want to share your screenshot directly, you can add the share_plus package and then
```Dart
SimpleScreenShot(
  callback: (Uint8List? image) async {
        await Share.shareXFiles([XFile.fromData(image!,name: "image.png", mimeType: "png")]);
      },
  child: YourPage()
)
```



## Usage

#### add description
```Dart
SimpleScreenShot(
  description: (context)=>Text("Some Description",style:TextStyle()),
  child: YourPage()
)
```

#### set Background image
```Dart
SimpleScreenShot(
  image: const DecorationImage(
        image: AssetImage("assets/background.png"),
        fit: BoxFit.cover,
      ),
  child: YourPage()
)
```

#### set color background
```Dart
SimpleScreenShot(
  color: Colors.red,
  child: YourPage()
)
```

#### set gradient background
```Dart
SimpleScreenShot(
  gradient: const LinearGradient(colors: [Colors.red, Colors.blue]),
  child: YourPage()
)
```
*You can only set either color background or gradient background*


#### set active
This is package is only active in debug mode by default.
If you want to enable it in release mode, set the active to be true
```Dart
SimpleScreenShot(
  active:true,
  child: YourPage()
)
```

#### Precaution
This package have used context to determine the size. Therefore, please ensure the size of the children you passed into SimpleScreenShot did not use context above the SimpleScreenShot

For example
```
Widget build(BuildContext context) {
  return SimpleScreenShot(
    child: Column(
      children:[
        Text("Hi"),
        SomeWidget(context: context)
      ]
    )
  )
}
```
The size of the SomeWidget will be depend on context above the SimpleScreenShot and lead to unexpected behaviour.
To resolve this issue. Wrap the Column inside a Builder so that the context will be under SimpleScreenShot




