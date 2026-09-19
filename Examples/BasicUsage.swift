import SwiftUI
import CopyButtonToast

struct BasicUsage: View {
    let inviteLink = "https://example.com/invite"

    var body: some View {
        VStack(spacing: 24) {
            Text(inviteLink)
                .font(.callout)
                .textSelection(.enabled)

            CopyButtonToast(
                text: inviteLink,
                title: "Copy link",
                successMessage: "Link copied!",
                systemImage: "link"
            )
        }
        .padding()
    }
}
