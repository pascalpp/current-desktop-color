import AppKit
import Foundation

let version = ProcessInfo.processInfo.operatingSystemVersion
let screen = NSScreen.main!
let options = NSWorkspace.shared.desktopImageOptions(for: screen)!

print("")
print("Thanks! Please email the info below to pascal+fillcolor@pascal.com")
print("")
print("macOS version:", "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)")
print("imageScaling:", options[.imageScaling] as Any)
print("allowClipping:", options[.allowClipping] as Any)
print("fillColor:", options[.fillColor] as Any)
