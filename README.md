# flutter-hero-widget-example
Flutter app with an example to reproduce a posible Hero widget bug using a Hero widget (AKA Destination Hero) that wraps a widget that requires a Material widget ancestor.

## Explanation

When you create a Hero widget (AKA Destination Hero) that wraps a widget that requires a Material widget ancestor (For example a IconButton), it appears an error during the transition from any Hero to the Destination Hero and then disappear.

## Steps to Reproduce

1. Create any Hero widget (Origin Widget):
```dart
Hero(
    tag: "image",
    child: Image.network("https://i.ibb.co/F6dxwfC/dummy.jpg")
)
```
2. Create a Hero widget (Destination Widget) that wraps any widget that requires a Material widget ancestor (In this example a IconButton):
```dart
Hero(
    tag: "image",
    child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
            Image.network("https://i.ibb.co/F6dxwfC/dummy.jpg"),
            Container(color: Colors.black54),
            Center(
                child: IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.error),
                    color: Colors.white,
                    tooltip: 'Anterior',
                    onPressed: () {
                        Navigator.of(context).pop();
                    },
                )
            ),
        ],
    )
)
```
3. Add a transition from Origin Hero to Destination Hero
4. An error will appear during the transition and then it will disappear

## Temporary fix

I was trying to understand why this error occurs and I could temporary fix it adding the following property to the Destination Hero:

```dart
Hero(
    tag: "image",
    flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) => Material(child: toHeroContext.widget),
    ...
```

Basically I wrapped the destination widget in a Material wiget during the transition.

## Video

In this video you could see the behaviour with an example showing the error and then using my temporary fix.

![Video](https://github.com/agallardol/flutter-hero-widget-bug-example/raw/master/resources/Flutter%20Hero%20Bug.gif)

## Example repo

Aditionally I created a repository with an example project to run the app of the video.

[Flutter Hero Widget possible bug](https://github.com/agallardol/flutter-hero-widget-bug-example)

## Flutter Logs

```
I/flutter ( 5015): ══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
I/flutter ( 5015): The following assertion was thrown building IconButton(Icon, tooltip: Anterior, dirty):
I/flutter ( 5015): No Material widget found.
I/flutter ( 5015): IconButton widgets require a Material widget ancestor.
I/flutter ( 5015): In material design, most widgets are conceptually "printed" on a sheet of material. In Flutter's
I/flutter ( 5015): material library, that material is represented by the Material widget. It is the Material widget
I/flutter ( 5015): that renders ink splashes, for instance. Because of this, many material library widgets require that
I/flutter ( 5015): there be a Material widget in the tree above them.
I/flutter ( 5015): To introduce a Material widget, you can either directly include one, or use a widget that contains
I/flutter ( 5015): Material itself, such as a Card, Dialog, Drawer, or Scaffold.
I/flutter ( 5015): The specific widget that could not find a Material ancestor was:
I/flutter ( 5015):   IconButton(Icon, tooltip: Anterior)
I/flutter ( 5015): The ancestors of this widget were:
I/flutter ( 5015):   Center(alignment: center)
I/flutter ( 5015):   Stack(alignment: AlignmentDirectional.topStart, fit: expand, overflow: clip)
I/flutter ( 5015):   Opacity(opacity: 1.0)
I/flutter ( 5015):   RepaintBoundary
I/flutter ( 5015):   IgnorePointer(ignoring: true)
I/flutter ( 5015):   Positioned(left: 6.9, top: 261.7, right: 6.9, bottom: 245.1)
I/flutter ( 5015):   AnimatedBuilder(animation: AnimationController#ea932(▶ 0.221; for
I/flutter ( 5015):   MaterialPageRoute<dynamic>(null))➩ProxyAnimation➩Cubic(0.40, 0.00, 0.20, 1.00)➩ProxyAnimation)
I/flutter ( 5015):   _OverlayEntry-[LabeledGlobalKey<_OverlayEntryState>#36d6f]
I/flutter ( 5015):   Stack(alignment: AlignmentDirectional.topStart, fit: expand, overflow: clip)
I/flutter ( 5015):   _Theatre
I/flutter ( 5015):   Overlay-[LabeledGlobalKey<OverlayState>#d8414]
I/flutter ( 5015):   _FocusScopeMarker
I/flutter ( 5015):   Semantics(container: false, properties: SemanticsProperties, label: null, value: null, hint: null,
I/flutter ( 5015):   hintOverrides: null)
I/flutter ( 5015):   FocusScope
I/flutter ( 5015):   AbsorbPointer(absorbing: false)
I/flutter ( 5015):   Listener(listeners: [down, up, cancel], behavior: deferToChild)
I/flutter ( 5015):   Navigator-[GlobalObjectKey<NavigatorState> _WidgetsAppState#6becc]
I/flutter ( 5015):   CupertinoTheme
I/flutter ( 5015):   IconTheme(IconThemeData#2abdc(color: Color(0xdd000000)))
I/flutter ( 5015):   _InheritedTheme
I/flutter ( 5015):   Theme(ThemeData#62042(buttonTheme: ButtonThemeData#bf267(buttonColor: Color(0xffe0e0e0),
I/flutter ( 5015):   colorScheme: ColorScheme#ee19e(primary: MaterialColor(primary value: Color(0xff2196f3)),
I/flutter ( 5015):   primaryVariant: Color(0xff1976d2), secondary: Color(0xff2196f3), secondaryVariant:
I/flutter ( 5015):   Color(0xff1976d2), background: Color(0xff90caf9), error: Color(0xffd32f2f), onSecondary:
I/flutter ( 5015):   Color(0xffffffff), onBackground: Color(0xffffffff)), materialTapTargetSize:
I/flutter ( 5015):   MaterialTapTargetSize.padded), textTheme: TextTheme#bcfcd, primaryTextTheme:
I/flutter ( 5015):   TextTheme#29b10(display4: TextStyle(debugLabel: whiteMountainView display4, inherit: true, color:
I/flutter ( 5015):   Color(0xb3ffffff), family: Roboto, decoration: TextDecoration.none), display3:
I/flutter ( 5015):   TextStyle(debugLabel: whiteMountainView display3, inherit: true, color: Color(0xb3ffffff), family:
I/flutter ( 5015):   Roboto, decoration: TextDecoration.none), display2: TextStyle(debugLabel: whiteMountainView
I/flutter ( 5015):   display2, inherit: true, color: Color(0xb3ffffff), family: Roboto, decoration:
I/flutter ( 5015):   TextDecoration.none), display1: TextStyle(debugLabel: whiteMountainView display1, inherit: true,
I/flutter ( 5015):   color: Color(0xb3ffffff), family: Roboto, decoration: TextDecoration.none), headline:
I/flutter ( 5015):   TextStyle(debugLabel: whiteMountainView headline, inherit: true, color: Color(0xffffffff), family:
I/flutter ( 5015):   Roboto, decoration: TextDecoration.none), title: TextStyle(debugLabel: whiteMountainView title,
I/flutter ( 5015):   inherit: true, color: Color(0xffffffff), family: Roboto, decoration: TextDecoration.none),
I/flutter ( 5015):   subhead: TextStyle(debugLabel: whiteMountainView subhead, inherit: true, color: Color(0xffffffff),
I/flutter ( 5015):   family: Roboto, decoration: TextDecoration.none), body2: TextStyle(debugLabel: whiteMountainView
I/flutter ( 5015):   body2, inherit: true, color: Color(0xffffffff), family: Roboto, decoration: TextDecoration.none),
I/flutter ( 5015):   body1: TextStyle(debugLabel: whiteMountainView body1, inherit: true, color: Color(0xffffffff),
I/flutter ( 5015):   family: Roboto, decoration: TextDecoration.none), caption: TextStyle(debugLabel: whiteMountainView
I/flutter ( 5015):   caption, inherit: true, color: Color(0xb3ffffff), family: Roboto, decoration:
I/flutter ( 5015):   TextDecoration.none), button: TextStyle(debugLabel: whiteMountainView button, inherit: true,
I/flutter ( 5015):   color: Color(0xffffffff), family: Roboto, decoration: TextDecoration.none), subtitle):
I/flutter ( 5015):   TextStyle(debugLabel: whiteMountainView subtitle, inherit: true, color: Color(0xffffffff), family:
I/flutter ( 5015):   Roboto, decoration: TextDecoration.none), overline: TextStyle(debugLabel: whiteMountainView
I/flutter ( 5015):   overline, inherit: true, color: Color(0xffffffff), family: Roboto, decoration:
I/flutter ( 5015):   TextDecoration.none)), accentTextTheme: TextTheme#29b10(display4: TextStyle(debugLabel:
I/flutter ( 5015):   whiteMountainView display4, inherit: true, color: Color(0xb3ffffff), family: Roboto, decoration:
I/flutter ( 5015):   TextDecoration.none), display3: TextStyle(debugLabel: whiteMountainView display3, inherit: true,
I/flutter ( 5015):   color: Color(0xb3ffffff), family: Roboto, decoration: TextDecoration.none), display2:
I/flutter ( 5015):   TextStyle(debugLabel: whiteMountainView display2, inherit: true, color: Color(0xb3ffffff), family:
I/flutter ( 5015):   Roboto, decoration: TextDecoration.none), display1: TextStyle(debugLabel: whiteMountainView
I/flutter ( 5015):   display1, inherit: true, color: Color(0xb3ffffff), family: Roboto, decoration:
I/flutter ( 5015):   TextDecoration.none), headline: TextStyle(debugLabel: whiteMountainView headline, inherit: true,
I/flutter ( 5015):   color: Color(0xffffffff), family: Roboto, decoration: TextDecoration.none), title:
I/flutter ( 5015):   TextStyle(debugLabel: whiteMountainView title, inherit: true, color: Color(0xffffffff), family:
I/flutter ( 5015):   Roboto, decoration: TextDecoration.none), subhead: TextStyle(debugLabel: whiteMountainView
I/flutter ( 5015):   subhead, inherit: true, color: Color(0xffffffff), family: Roboto, decoration:
I/flutter ( 5015):   TextDecoration.none), body2: TextStyle(debugLabel: whiteMountainView body2, inherit: true, color:
I/flutter ( 5015):   Color(0xffffffff), family: Roboto, decoration: TextDecoration.none), body1: TextStyle(debugLabel:
I/flutter ( 5015):   whiteMountainView body1, inherit: true, color: Color(0xffffffff), family: Roboto, decoration:
I/flutter ( 5015):   TextDecoration.none), caption: TextStyle(debugLabel: whiteMountainView caption, inherit: true,
I/flutter ( 5015):   color: Color(0xb3ffffff), family: Roboto, decoration: TextDecoration.none), button:
I/flutter ( 5015):   TextStyle(debugLabel: whiteMountainView button, inherit: true, color: Color(0xffffffff), family:
I/flutter ( 5015):   Roboto, decoration: TextDecoration.none), subtitle): TextStyle(debugLabel: whiteMountainView
I/flutter ( 5015):   subtitle, inherit: true, color: Color(0xffffffff), family: Roboto, decoration:
I/flutter ( 5015):   TextDecoration.none), overline: TextStyle(debugLabel: whiteMountainView overline, inherit: true,
I/flutter ( 5015):   color: Color(0xffffffff), family: Roboto, decoration: TextDecoration.none)), inputDecorationTheme:
I/flutter ( 5015):   InputDecorationTheme#1ad34, iconTheme: IconThemeData#2abdc(color: Color(0xdd000000)),
I/flutter ( 5015):   primaryIconTheme: IconThemeData#15fa8(color: Color(0xffffffff)), accentIconTheme:
I/flutter ( 5015):   IconThemeData#15fa8(color: Color(0xffffffff)), sliderTheme: SliderThemeData#1aaae, tabBarTheme:
I/flutter ( 5015):   TabBarTheme#e3dcc, cardTheme: CardTheme#b4e63, chipTheme: ChipThemeData#3a006,
I/flutter ( 5015):   materialTapTargetSize: MaterialTapTargetSize.padded, pageTransitionsTheme:
I/flutter ( 5015):   PageTransitionsTheme#b8b0e))
I/flutter ( 5015):   AnimatedTheme(duration: 200ms)
I/flutter ( 5015):   Builder
I/flutter ( 5015):   DefaultTextStyle(debugLabel: fallback style; consider putting your text in a Material, inherit:
I/flutter ( 5015):   true, color: Color(0xd0ff0000), family: monospace, size: 48.0, weight: 900, decoration: double
I/flutter ( 5015):   Color(0xffffff00) TextDecoration.underline, softWrap: wrapping at box width, overflow: clip)
I/flutter ( 5015):   CustomPaint
I/flutter ( 5015):   Banner("DEBUG", textDirection: ltr, location: topEnd, Color(0xa0b71c1c), text inherit: true, text
I/flutter ( 5015):   color: Color(0xffffffff), text size: 10.2, text weight: 900, text height: 1.0x)
I/flutter ( 5015):   CheckedModeBanner("DEBUG")
I/flutter ( 5015):   Title(title: "Flutter Hero Bug", color: MaterialColor(primary value: Color(0xff2196f3)))
I/flutter ( 5015):   Directionality(textDirection: ltr)
I/flutter ( 5015):   _LocalizationsScope-[GlobalKey#17a4e]
I/flutter ( 5015):   Semantics(container: false, properties: SemanticsProperties, label: null, value: null, hint: null,
I/flutter ( 5015):   textDirection: ltr, hintOverrides: null)
I/flutter ( 5015):   Localizations(locale: en_US, delegates: [DefaultMaterialLocalizations.delegate(en_US),
I/flutter ( 5015):   DefaultCupertinoLocalizations.delegate(en_US), DefaultWidgetsLocalizations.delegate(en_US)])
I/flutter ( 5015):   MediaQuery(MediaQueryData(size: Size(392.7, 850.9), devicePixelRatio: 2.8, textScaleFactor: 1.0,
I/flutter ( 5015):   platformBrightness: Brightness.light, padding: EdgeInsets(0.0, 40.0, 0.0, 0.0), viewInsets:
I/flutter ( 5015):   EdgeInsets.zero, alwaysUse24HourFormat: false, accessibleNavigation: falsedisableAnimations:
I/flutter ( 5015):   falseinvertColors: falseboldText: false))
I/flutter ( 5015):   WidgetsApp-[GlobalObjectKey _MaterialAppState#ed185]
I/flutter ( 5015):   ScrollConfiguration(behavior: _MaterialScrollBehavior)
I/flutter ( 5015):   MaterialApp
I/flutter ( 5015):   MyApp
I/flutter ( 5015):   [root]
I/flutter ( 5015): 
I/flutter ( 5015): When the exception was thrown, this was the stack:
I/flutter ( 5015): #0      debugCheckHasMaterial.<anonymous closure> (package:flutter/src/material/debug.dart:64:7)
I/flutter ( 5015): #1      debugCheckHasMaterial (package:flutter/src/material/debug.dart:67:4)
I/flutter ( 5015): #2      IconButton.build (package:flutter/src/material/icon_button.dart:245:12)
I/flutter ( 5015): #3      StatelessElement.build (package:flutter/src/widgets/framework.dart:3789:28)
I/flutter ( 5015): #4      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:3736:15)
I/flutter ( 5015): #5      Element.rebuild (package:flutter/src/widgets/framework.dart:3559:5)
I/flutter ( 5015): #6      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:3716:5)
I/flutter ( 5015): #7      ComponentElement.mount (package:flutter/src/widgets/framework.dart:3711:5)
I/flutter ( 5015): #8      Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #9      Element.updateChild (package:flutter/src/widgets/framework.dart:2759:12)
I/flutter ( 5015): #10     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:4876:14)
I/flutter ( 5015): #11     Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #12     MultiChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:4982:32)
I/flutter ( 5015): #13     Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #14     Element.updateChild (package:flutter/src/widgets/framework.dart:2759:12)
I/flutter ( 5015): #15     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:4876:14)
I/flutter ( 5015): #16     Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #17     Element.updateChild (package:flutter/src/widgets/framework.dart:2759:12)
I/flutter ( 5015): #18     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:4876:14)
I/flutter ( 5015): #19     Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #20     Element.updateChild (package:flutter/src/widgets/framework.dart:2759:12)
I/flutter ( 5015): #21     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:4876:14)
I/flutter ( 5015): #22     Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #23     Element.updateChild (package:flutter/src/widgets/framework.dart:2759:12)
I/flutter ( 5015): #24     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:3747:16)
I/flutter ( 5015): #25     Element.rebuild (package:flutter/src/widgets/framework.dart:3559:5)
I/flutter ( 5015): #26     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:3716:5)
I/flutter ( 5015): #27     ComponentElement.mount (package:flutter/src/widgets/framework.dart:3711:5)
I/flutter ( 5015): #28     ParentDataElement.mount (package:flutter/src/widgets/framework.dart:4063:11)
I/flutter ( 5015): #29     Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #30     Element.updateChild (package:flutter/src/widgets/framework.dart:2759:12)
I/flutter ( 5015): #31     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:3747:16)
I/flutter ( 5015): #32     Element.rebuild (package:flutter/src/widgets/framework.dart:3559:5)
I/flutter ( 5015): #33     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:3716:5)
I/flutter ( 5015): #34     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:3864:11)
I/flutter ( 5015): #35     ComponentElement.mount (package:flutter/src/widgets/framework.dart:3711:5)
I/flutter ( 5015): #36     Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #37     Element.updateChild (package:flutter/src/widgets/framework.dart:2759:12)
I/flutter ( 5015): #38     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:3747:16)
I/flutter ( 5015): #39     Element.rebuild (package:flutter/src/widgets/framework.dart:3559:5)
I/flutter ( 5015): #40     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:3716:5)
I/flutter ( 5015): #41     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:3864:11)
I/flutter ( 5015): #42     ComponentElement.mount (package:flutter/src/widgets/framework.dart:3711:5)
I/flutter ( 5015): #43     Element.inflateWidget (package:flutter/src/widgets/framework.dart:2956:14)
I/flutter ( 5015): #44     Element.updateChild (package:flutter/src/widgets/framework.dart:2759:12)
I/flutter ( 5015): #45     RenderObjectElement.updateChildren (package:flutter/src/widgets/framework.dart:4659:32)
I/flutter ( 5015): #46     MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:4992:17)
I/flutter ( 5015): #47     Element.updateChild (package:flutter/src/widgets/framework.dart:2748:15)
I/flutter ( 5015): #48     _TheatreElement.update (package:flutter/src/widgets/overlay.dart:508:16)
I/flutter ( 5015): #49     Element.updateChild (package:flutter/src/widgets/framework.dart:2748:15)
I/flutter ( 5015): #50     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:3747:16)
I/flutter ( 5015): #51     Element.rebuild (package:flutter/src/widgets/framework.dart:3559:5)
I/flutter ( 5015): #52     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:2273:33)
I/flutter ( 5015): #53     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding&PaintingBinding&SemanticsBinding&RendererBinding&WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:700:20)
I/flutter ( 5015): #54     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding&PaintingBinding&SemanticsBinding&RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:268:5)
I/flutter ( 5015): #55     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:988:15)
I/flutter ( 5015): #56     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:928:9)
I/flutter ( 5015): #57     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:840:5)
I/flutter ( 5015): #61     _invoke (dart:ui/hooks.dart:209:10)
I/flutter ( 5015): #62     _drawFrame (dart:ui/hooks.dart:168:3)
I/flutter ( 5015): (elided 3 frames from package dart:async)
```

## Flutter analyze

```
Analyzing flutter_hero_bug...
No issues found! (ran in 1.5s)
```
## Flutter doctor

```
[√] Flutter (Channel stable, v1.2.1, on Microsoft Windows [Version 10.0.17763.503], locale en-US)
[!] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
    X Android license status unknown.
[√] Android Studio (version 3.4)
[√] VS Code, 64-bit edition (version 1.33.1)
[√] Connected device (1 available)
```
