# CopyButtonToast

A tiny reusable **SwiftUI copy-to-clipboard button with animated toast feedback**.

It is useful anywhere users need to copy something and immediately know that the action succeeded.

Common examples:

- Email addresses
- Links
- Invite codes
- Usernames
- Code snippets
- Addresses
- Reference numbers

## Features

- Native SwiftUI
- No third-party dependencies
- Copies text to the system clipboard
- Animated "Copied!" toast
- Toast automatically disappears
- Custom success message
- Custom button title
- Custom SF Symbol
- Custom tint
- Custom toast duration
- iOS and macOS support
- Accessibility label and hint
- Swift Package Manager support

## Requirements

- iOS 16+
- macOS 13+
- Swift 5.9+

## Installation

### Swift Package Manager

In Xcode:

1. Open your project.
2. Go to **File > Add Package Dependencies...**
3. Enter:

```
https://github.com/NiloufarRabiee/swiftui-copy-button-toast
```

4. Add the `CopyButtonToast` package to your app target.

Then import it:

```swift
import CopyButtonToast
```

## Basic Usage

```swift
CopyButtonToast(
    text: "hello@example.com"
)
```

Tap the button and the text is copied to the clipboard. A short confirmation toast appears automatically.

## Custom Message

```swift
CopyButtonToast(
    text: inviteLink,
    title: "Copy link",
    successMessage: "Link copied!",
    systemImage: "link"
)
```

## Full Customization

```swift
CopyButtonToast(
    text: "ABC-123",
    title: "Copy code",
    successMessage: "Code copied!",
    systemImage: "doc.on.doc.fill",
    toastDuration: 2.0,
    tint: .purple
)
```

## Parameters

| Parameter | Description | Default |
|---|---|---|
| `text` | Text written to the clipboard | Required |
| `title` | Button label | `Copy` |
| `successMessage` | Toast message | `Copied!` |
| `systemImage` | SF Symbol used by the button | `doc.on.doc` |
| `toastDuration` | Seconds before the toast disappears | `1.5` |
| `tint` | Button accent color | `.accentColor` |

## How It Works

When the user taps the button:

1. The supplied text is written to the system clipboard.
2. The confirmation toast appears above the button.
3. The toast dismisses itself automatically.
4. Repeated taps restart the toast timer.

The package uses `UIPasteboard` on iOS and `NSPasteboard` on macOS.

## Example

A small usage example is included in:

```
Examples/BasicUsage.swift
```

## Testing

Run:

```bash
swift test
```

GitHub Actions CI is also included.

## Privacy Note

This package does not send copied text anywhere. It writes only to the operating system clipboard. Clipboard behavior and visibility are controlled by the platform.

## Contributing

Contributions and improvements are welcome.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project is available under the MIT License.

See [LICENSE](LICENSE).

---

Created by **Niloufar Rabiee**
