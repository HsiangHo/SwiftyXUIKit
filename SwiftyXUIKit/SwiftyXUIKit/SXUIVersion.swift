//
//  SXUIVersion.swift
//  SwiftyXUIKit
//
//  Created by Jovi on 4/8/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

import Foundation

public class SXUIVersion{
    public static func macOSVersionString() -> String {
        var verString: String;
        if #available(OSX 10.10, *) {
            let ver = ProcessInfo.processInfo.operatingSystemVersion
            verString = String.init(format: "%d.%d.%d", ver.majorVersion, ver.minorVersion, ver.patchVersion)
        } else {
            verString = "10.9"
        }
        return verString;
    }
    
    public static func versionEqualTo(version:String) -> Bool {
        return macOSVersionString() == version
    }
    
    public static func versionGreaterThan(version:String) -> Bool {
        return macOSVersionString() > version
    }
    
    public static func versionGreaterThanOrEqualTo(version:String) -> Bool {
        return macOSVersionString() >= version
    }
    
    public static func versionLessThan(version:String) -> Bool {
        return macOSVersionString() < version
    }
    
    public static func versionLessThanOrEqualTo(version:String) -> Bool {
        return macOSVersionString() <= version
    }
}
