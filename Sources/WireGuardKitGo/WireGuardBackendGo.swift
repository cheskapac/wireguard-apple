// SPDX-License-Identifier: MIT
// Copyright © 2018-2023 WireGuard LLC. All Rights Reserved.

import Foundation
import WGKitGo

#if SWIFT_PACKAGE
import WireGuardKit
#endif

// swiftlint:disable identifier_name
public final class WireGuardBackendGo: WireGuardBackend {
    public init() {
    }

    public func setLogger(context: UnsafeMutableRawPointer?, logger_fn: WireGuardLoggerCallback?) {
        wgSetLogger(
            unsafeBitCast(context, to: GoUintptr.self),
            unsafeBitCast(logger_fn, to: GoUintptr.self)
        )
    }

    public func turnOn(settings: String, tun_fd: Int32) -> Int32 {
        var result: Int32 = 0
        settings.withCString { cString in
            result = wgTurnOn(UnsafeMutablePointer(mutating: cString), tun_fd)
        }
        return result
    }

    public func turnOff(_ handle: Int32) {
        wgTurnOff(handle)
    }

    public func setConfig(_ handle: Int32, settings: String) -> Int64 {
        var result: Int64 = 0
        settings.withCString { cString in
            result = wgSetConfig(handle, UnsafeMutablePointer(mutating: cString))
        }
        return result
    }

    public func getConfig(_ handle: Int32) -> String? {
        String(cString: wgGetConfig(handle))
    }

    public func bumpSockets(_ handle: Int32) {
        wgBumpSockets(handle)
    }

    public func disableSomeRoamingForBrokenMobileSemantics(_ handle: Int32) {
        wgDisableSomeRoamingForBrokenMobileSemantics(handle)
    }

    public func version() -> String? {
        String(cString: wgVersion())
    }
}
// swiftlint:enable identifier_name

private extension String {
    var rawString: [CChar]? {
        cString(using: .utf8)
    }
}
