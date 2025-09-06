# [WireGuard](https://www.wireguard.com/) for iOS and macOS

This project contains a WireGuard VPN application for iOS and macOS, as well as the WireGuardKit framework that can be integrated into other applications. The project supports both platforms with shared components and platform-specific implementations.

## Features

- **Cross-platform support**: Native iOS and macOS applications
- **WireGuardKit framework**: Reusable Swift package for VPN functionality
- **Network Extension**: Secure VPN tunnel implementation
- **Modern Swift**: Built with Swift 5.9+ and latest iOS/macOS APIs
- **SwiftLint integration**: Code quality and style enforcement

## Requirements

- **Xcode**: 15.0 or later
- **Swift**: 5.9 or later
- **iOS**: 15.0 or later
- **macOS**: 12.0 or later
- **tvOS**: 17.0 or later (WireGuardKit only)

## Building

### Prerequisites

Install required development tools:

```bash
$ brew install swiftlint go
```

### Setup

1. Clone this repository:

```bash
$ git clone https://git.zx2c4.com/wireguard-apple
$ cd wireguard-apple
```

2. Configure your Apple Developer Team ID:

```bash
$ cp Sources/WireGuardApp/Config/Developer.xcconfig.template Sources/WireGuardApp/Config/Developer.xcconfig
$ vim Sources/WireGuardApp/Config/Developer.xcconfig
```

Edit the `Developer.xcconfig` file and replace the placeholders:
- `<team_id>`: Your Apple Developer Team ID
- `<app_id>`: Your app bundle identifiers (must have Network Extensions capability)

3. Open the project in Xcode:

```bash
$ open WireGuard.xcodeproj
```

4. Select your target platform (iOS or macOS) and build the project.

## Project Structure

```
Sources/
├── WireGuardApp/           # Main iOS/macOS application
│   ├── Config/            # Build configuration files
│   ├── Resources/         # App resources and assets
│   └── Base.lproj/        # Localization files
├── WireGuardKit/          # Core VPN framework (Swift)
├── WireGuardKitC/         # C bridge components
└── WireGuardKitGo/        # Go backend integration
```

## WireGuardKit Integration

WireGuardKit is available as a Swift Package Manager dependency. It provides VPN functionality that can be integrated into your own applications.

### Swift Package Manager

Add WireGuardKit to your project using Swift Package Manager:

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://git.zx2c4.com/wireguard-apple
   ```
3. Select the version or branch you want to use
4. Add `WireGuardKit` to your target

### Manual Integration

If you prefer manual integration or need more control:

1. Add this repository as a git submodule or download the source
2. Drag `WireGuardKit.xcodeproj` into your Xcode project
3. Add `WireGuardKit` framework to your target's dependencies
4. Import the framework in your Swift code:
   ```swift
   import WireGuardKit
   ```

### Usage Example

```swift
import WireGuardKit
import NetworkExtension

// Create a tunnel configuration
let tunnelConfiguration = TunnelConfiguration(name: "MyVPN")

// Configure the tunnel manager
let tunnelManager = NETunnelProviderManager()
tunnelManager.protocolConfiguration = NETunnelProviderProtocol()
tunnelManager.localizedDescription = "WireGuard VPN"

// Save and start the tunnel
tunnelManager.saveToPreferences { error in
    if let error = error {
        print("Failed to save tunnel: \(error)")
        return
    }
    
    try? tunnelManager.connection.startVPNTunnel()
}
```

### Requirements for Integration

- Your app must have the **Network Extensions** capability enabled
- For iOS: Disable Bitcode in your app target's build settings
- Ensure your provisioning profile includes Network Extensions entitlements

## Development

### Code Style

This project uses SwiftLint for code style enforcement. The configuration is defined in `.swiftlint.yml`. Run SwiftLint before submitting changes:

```bash
$ swiftlint
```

### Dependencies

The project uses Swift Package Manager for dependency management. Key dependencies include:

- **wg-go-apple**: Go backend implementation for WireGuard protocol
- **Swift 5.9+**: Modern Swift language features
- **Network Extension Framework**: iOS/macOS VPN capabilities

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes following the existing code style
4. Run SwiftLint to ensure code quality
5. Test on both iOS and macOS platforms
6. Submit a pull request

## Troubleshooting

### Common Build Issues

**"Developer Team ID not found"**
- Ensure you've configured `Developer.xcconfig` with your Apple Developer Team ID

**"Network Extensions capability missing"**
- Add Network Extensions capability to your App ID in Apple Developer Portal
- Update your provisioning profiles

**"Go build failed"**
- Ensure Go is installed: `brew install go`
- Check that Go version is compatible (1.19 or later recommended)

### Runtime Issues

**"VPN configuration failed"**
- Verify Network Extensions entitlements in your provisioning profile
- Check that your app has proper VPN permissions

**"Tunnel connection timeout"**
- Verify WireGuard server configuration
- Check network connectivity and firewall settings

## License

## MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
