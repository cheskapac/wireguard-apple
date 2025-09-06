// SPDX-License-Identifier: MIT
// Copyright © 2018-2023 WireGuard LLC. All Rights Reserved.

import Foundation

/// This source file contains bits of code from:
/// https://oleb.net/blog/2018/01/notificationcenter-removeobserver/

/// Wraps the observer token received from
/// `NotificationCenter.addObserver(forName:object:queue:using:)`
/// and unregisters it in deinit.
public final class WireGuardKitNotificationToken {
    let notificationCenter: NotificationCenter
    let token: Any

    init(notificationCenter: NotificationCenter = .default, token: Any) {
        self.notificationCenter = notificationCenter
        self.token = token
    }

    deinit {
        notificationCenter.removeObserver(token)
    }
}

public extension NotificationCenter {
    /// Convenience wrapper for addObserver(forName:object:queue:using:)
    /// that returns our custom `WireGuardKitNotificationToken`.
    func observe(name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> WireGuardKitNotificationToken {
        let token = addObserver(forName: name, object: obj, queue: queue, using: block)
        return WireGuardKitNotificationToken(notificationCenter: self, token: token)
    }
}
