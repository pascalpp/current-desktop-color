// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import AppKit

let cur = NSWorkspace.shared.desktopImageOptions(for: NSScreen.main!)!
print(cur[.fillColor])
