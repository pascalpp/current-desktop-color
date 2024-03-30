import Foundation
import AppKit

let version = ProcessInfo.processInfo.operatingSystemVersion
let options = NSWorkspace.shared.desktopImageOptions(for: NSScreen.main!)!

print("")
print("Thanks! Please email the info below to pascalpp+fillcolor@gmail.com")
print("")
print("macOS version:", "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)")
print("imageScaling:", options[.imageScaling])
print("fillColor:", options[.fillColor])

