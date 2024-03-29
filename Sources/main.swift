// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import AppKit

let options = NSWorkspace.shared.desktopImageOptions(for: NSScreen.main!)!

print("imageScaling:", options[.imageScaling])
print("fillColor:", options[.fillColor])
