# Testing NSWorkspace.shared.desktopImageOptions fillColor

In the Wallpaper preference pane in Mac OS Settings, you can set a desktop image and fill color.

<img width="491" alt="image" src="https://github.com/pascalpp/current-desktop-color/assets/1355312/428674e0-b41e-4fb9-98be-41e5d20d6d38">

I'm trying to set the these programmatically, using the `setDesktopImageURL` method on NSWorkspace.shared. Sample code:

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
}
```

But `setDesktopImageURL` seems to ignore the `fillColor` option, and always sets the fill color to some default blue.

So I've created this little test app which attempts to get the current fill color, which is supposedly available in the options returned by the `NSWorkspace.shared.desktopImageOptions`.
