# Help wanted

If you have a Mac with git and Xcode installed and would like to help troubleshoot an API issue I'm having, please download and run this little test app and email me the output.

## To run this app:

In Terminal:

```
gh repo clone pascalpp/current-desktop-color
cd current-desktop-color
swift run
```

If the build succeeds, the app will print the current OS version, the current desktop scaling option (a number from 0 to 3), and the current fill color. Please email the output to pascalpp+fillcolor@gmail.com.

Keep scrolling if you're curious to know more.

<table height="150"></table>

## The problem I'm trying to solve:

<img width="491" alt="image" src="https://github.com/pascalpp/current-desktop-color/assets/1355312/428674e0-b41e-4fb9-98be-41e5d20d6d38" style="margin-block: 1rem">

I'm trying to set the desktop image and fill color programmatically in macOS using the `NSWorkspace.shared.setDesktopImageURL` method.

One of the options for that method is `fillColor`, which is supposed to set the color that shows through transparent desktop images. This used to work, but no longer does.

The related method `NSWorkspace.shared.desktopImageOptions` is supposed to return the current desktop image options, including the fill color, but this no longer works either.

I've tested this on three machines.

- On my Macbook Pro 2018 (Intel) running macOS Monterey, I'm able to set and get the fill color correctly. When I run the test app, I get:

```
macOS version: 12.4.0
imageScaling: nil
fillColor: Optional(NSCalibratedRGBColorSpace 0.196805 0.384201) <-- good
```

- But on two different 14" Macbook Pros (an M1 Pro and an M3 Pro), both running macOS Sonoma, the fill color option is ignored when I try to set it, and when I run the test app I get:

```
macOS version: 14.4.1
imageScaling: Optional(3)
fillColor: nil <-- bad
```

On both of those Apple Silicon machines, the fillColor is always nil, and I think that's a bug. This might be a regression in macOS Ventura or Sonoma, but I need more folks to run this test to be sure.

## Why I'm trying to solve this problem

I'd like to make an app that allows the user to assign colors to spaces and easily differentiate one space from another, and to set the background color of the menubar to black or some other color, using transparent desktop images with the fill color showing through. (I've explored other methods of coloring the menu bar but haven't found one that works the way I want.)

So I'm trying to set the desktop image and color programmatically, using the `setDesktopImageURL` method on NSWorkspace.shared.

Some sample code:

```

import Foundation
import AppKit

let workspace = NSWorkspace.shared
let screens = NSScreen.screens

// scaling options for desktop pictures
let fill = NSImageScaling.scaleProportionallyDown.rawValue
let stretch = NSImageScaling.scaleAxesIndependently.rawValue
let center = NSImageScaling.scaleNone.rawValue
let fit = NSImageScaling.scaleProportionallyUpOrDown.rawValue

// I have two screens, so I have these two background images in my home folder:
let large = NSURL.fileURL(withPath: "/Users/pascal/Pictures/Wallpaper/large.png")
let small = NSURL.fileURL(withPath: "/Users/pascal/Pictures/Wallpaper/small.png")

for screen in screens {
// choose the image for the given screen size - room for improvement here, ignore this
let image = (screen.frame.width == 2560) ? large : small

// the color I'd like to use
let color = NSColor(calibratedRed: 64/255, green: 116/255, blue: 112/255, alpha: 1.0)

var options: [NSWorkspace.DesktopImageOptionKey : Any] = [:]
options[.imageScaling] = fit
options[.fillColor] = color

try workspace.setDesktopImageURL(image, for: screen, options: options)

```

This works in Montery, but in Sonoma `setDesktopImageURL` seems to ignore the `fillColor` option, and always sets the fill color to some default blue (even if I have set it to some other color manually.)
