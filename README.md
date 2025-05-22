# Flasher

A Flutter widget that makes its child "flash" on-and-off (blink).

![Flasher in action](https://raw.githubusercontent.com/lukaswhite/flasher/refs/heads/main/docs/assets/flasher.gif)

## Usage

First, import the package:

```dart
import 'package:flasher/flasher.dart';
```

Minimal example:

```dart
Flasher(
    child: Text('Blink'),
)
```

By defalt, it will carry on animating forever. Use the `repeat` property to modify that behaviour:

```dart
Flasher(
    repeat: 10,
    child: Text('Flash ten times'),
)
```

You can customise the duration; `duration` is how long it sits at full opacity between "flashes", `flashDuration` is how long it takes to "blink".

```dart
Flasher(
    flashDuration: const Duration(milliseconds: 150),
    duration: const Duration(milliseconds: 250),
    child: Text('This is the child'),
)
```

If you limit the number of times it flashes (using `repeat`), you can configure it to fade out when it's complete.

```dart
Flasher.fadeOutAfter(
    repeat: 10,    
    child: Text('This is the child')
)
```

By default it waits a moment before fading out; modify this by setting `fadeOutDelay`. You can also confgiure how long it takes to fade out using `fadeOutDuration`.

```dart
Flasher.fadeOutAfter(
    repeat: 10,
    fadeOutDuration: const Duration(milliseconds: 350),
    fadeOutDelay: const Duration(milliseconds: 150,),
    child: Text('This is the child')
)
```

By default, the "flash" uses a simple easing curve (`Curves.ease`), but you can configue this as well:

```dart
Flasher.fadeOutAfter(
    curve: Curves.bounceInOut,
    child: Text('This is the child')
)
```

Finally, if you want to defer the start you can set `active` to `false`:

```dart
Flasher.fadeOutAfter(
    active: false,
    child: Text('This is the child')
)
```

Here's one with everything configured:

```dart
Flasher(
    active: true,
    flashDuration: const Duration(milliseconds: 150),
    duration: const Duration(milliseconds: 250),
    curve: Curves.bounceInOut,
    fadeOutDuration: const Duration(milliseconds: 350),
    fadeOutDelay: const Duration(milliseconds: 150,),
    fadeOutOnComplete: true,
    repeat: 10,
    child: Text('This is the child'),
)
```

Note that the child can be any Flutter widget; it's not limited to text.

The package also contains a very simple example app.