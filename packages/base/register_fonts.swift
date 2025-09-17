import Foundation
import CoreText

guard CommandLine.arguments.count > 1 else {
    print("Usage: swift register_fonts.swift <directory>")
    exit(1)
}

let dirPath = CommandLine.arguments[1]
let fontDir = URL(fileURLWithPath: dirPath).standardized

let fm = FileManager.default
guard let files = try? fm.contentsOfDirectory(at: fontDir, includingPropertiesForKeys: nil) else {
    print("Could not list directory: \(fontDir.path)")
    exit(1)
}

let fontExtensions: Set<String> = ["ttf"] // Can add more here later

for file in files {
    if fontExtensions.contains(file.pathExtension.lowercased()) {
        var error: Unmanaged<CFError>?
        let registered = CTFontManagerRegisterFontsForURL(file as CFURL, .user, &error)
        if registered {
            print("Registered font: \(file.lastPathComponent)")
        } else if let e = error?.takeRetainedValue() {
            let errorCode = CFErrorGetCode(e)
            // Error Domain=com.apple.CoreText.CTFontManagerErrorDomain Code=105 "The file has already been registered in the specified scope."
            if errorCode == 105 {
                print("Font already registered: \(file.lastPathComponent)")
            } else {
                print("Failed to register \(file.lastPathComponent): \(e)")
            }
        }
    }
}
