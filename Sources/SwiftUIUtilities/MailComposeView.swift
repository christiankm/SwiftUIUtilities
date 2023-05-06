//
//  MailComposeView.swift
//  SwiftUIUtilities
//
//  Created by Christian Mitteldorf on 03/03/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import MessageUI
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct MailComposeView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?

    var recipient: String?
    var subject: String?

    final public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }

            if let error = error {
                self.result = .failure(error)
                return
            }

            self.result = .success(result)
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(presentation: presentation, result: $result)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator

        if let recipient = recipient {
            viewController.setToRecipients([recipient])
        }
        if let subject = subject {
            viewController.setSubject(subject)
        }

        return viewController
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailComposeView>) {}
}

@available(iOS 13.0, *)
extension View {

    /// Presents a send mail view when needed with optionally prefilled details
    /// or a "Mail not configured" alert if no mail account is present.
    @ViewBuilder
    public func mailComposeSheet(isPresented: Binding<Bool>, recipient: String? = nil, subject: String? = nil,
                  onMailNotConfigured: (() -> Void)? = nil) -> some View {
            self
                .sheet(isPresented: isPresented, content: { () -> MailComposeView in
                    var mailView = MailComposeView(result: .constant(nil))
                    mailView.recipient = recipient
                    mailView.subject = subject
                    return mailView
                })
    }
}

@available(iOS 13.0, *)
struct MailComposeView_Previews: PreviewProvider {

    static var previews: some View {
        Text("Hello")
            .mailComposeSheet(isPresented: .constant(true))
    }
}
