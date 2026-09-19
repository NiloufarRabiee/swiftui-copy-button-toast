import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A small SwiftUI button that copies text to the system clipboard
/// and briefly displays animated confirmation feedback.
public struct CopyButtonToast: View {
    private let text: String
    private let title: String
    private let successMessage: String
    private let systemImage: String
    private let toastDuration: TimeInterval
    private let tint: Color

    @State private var isShowingToast = false
    @State private var hideTask: Task<Void, Never>?

    public init(
        text: String,
        title: String = "Copy",
        successMessage: String = "Copied!",
        systemImage: String = "doc.on.doc",
        toastDuration: TimeInterval = 1.5,
        tint: Color = .accentColor
    ) {
        self.text = text
        self.title = title
        self.successMessage = successMessage
        self.systemImage = systemImage
        self.toastDuration = CopyButtonToastConfiguration.normalizedDuration(toastDuration)
        self.tint = tint
    }

    public var body: some View {
        Button(action: copy) {
            Label(title, systemImage: systemImage)
                .fontWeight(.semibold)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .foregroundStyle(tint)
                .background(
                    Capsule(style: .continuous)
                        .fill(tint.opacity(0.12))
                )
        }
        .buttonStyle(.plain)
        .overlay(alignment: .top) {
            if isShowingToast {
                toast
                    .offset(y: -52)
                    .transition(
                        .move(edge: .bottom)
                        .combined(with: .opacity)
                        .combined(with: .scale(scale: 0.96))
                    )
            }
        }
        .animation(.spring(response: 0.28, dampingFraction: 0.82), value: isShowingToast)
        .accessibilityLabel(title)
        .accessibilityHint("Copies the provided text to the clipboard")
        .onDisappear {
            hideTask?.cancel()
        }
    }

    private var toast: some View {
        HStack(spacing: 7) {
            Image(systemName: "checkmark.circle.fill")

            Text(successMessage)
                .fontWeight(.medium)
        }
        .font(.callout)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.regularMaterial, in: Capsule(style: .continuous))
        .shadow(radius: 6, y: 2)
        .accessibilityElement(children: .combine)
    }

    private func copy() {
        ClipboardWriter.write(text)

        hideTask?.cancel()

        withAnimation {
            isShowingToast = true
        }

        hideTask = Task { @MainActor in
            let nanoseconds = UInt64(toastDuration * 1_000_000_000)

            do {
                try await Task.sleep(nanoseconds: nanoseconds)
            } catch {
                return
            }

            guard !Task.isCancelled else { return }

            withAnimation {
                isShowingToast = false
            }
        }
    }
}

enum ClipboardWriter {
    static func write(_ text: String) {
        #if canImport(UIKit)
        UIPasteboard.general.string = text
        #elseif canImport(AppKit)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
        #endif
    }
}

enum CopyButtonToastConfiguration {
    static let minimumDuration: TimeInterval = 0.25
    static let fallbackDuration: TimeInterval = 1.5

    static func normalizedDuration(_ duration: TimeInterval) -> TimeInterval {
        guard duration.isFinite else {
            return fallbackDuration
        }

        return max(duration, minimumDuration)
    }
}

#Preview {
    VStack(spacing: 32) {
        CopyButtonToast(
            text: "hello@example.com",
            successMessage: "Email copied!"
        )

        CopyButtonToast(
            text: "https://example.com/invite",
            title: "Copy link",
            successMessage: "Link copied!",
            systemImage: "link",
            tint: .purple
        )
    }
    .padding(80)
}
