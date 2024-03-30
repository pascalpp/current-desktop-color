// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import AppKit

let version = ProcessInfo.processInfo.operatingSystemVersion
let options = NSWorkspace.shared.desktopImageOptions(for: NSScreen.main!)!

print("macOS version:", "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)")
print("imageScaling:", options[.imageScaling])
print("fillColor:", options[.fillColor])
 

